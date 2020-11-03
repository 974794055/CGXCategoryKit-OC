//
//  UIImage+CGXColor.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "UIImage+CGXColor.h"
#import <CoreText/CoreText.h>

@implementation UIImage (CGXColor)
/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)gx_imageWithColor:(UIColor *)color
{
    return [self gx_imageWithColor:color Size:CGSizeMake(1, 1)];
}
+ (UIImage *)gx_imageWithColor:(UIColor *)color Size:(CGSize)size
{
    if (!color) {
        color = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)gx_colorAtPoint:(CGPoint )point
{
    if (point.x < 0 || point.y < 0) return nil;
    
    CGImageRef imageRef = self.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    if (point.x >= width || point.y >= height) return nil;
    
    unsigned char *rawData = malloc(height * width * 4);
    if (!rawData) return nil;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast
                                                 | kCGBitmapByteOrder32Big);
    if (!context) {
        free(rawData);
        return nil;
    }
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    int byteIndex = (bytesPerRow * point.y) + point.x * bytesPerPixel;
    CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
    CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
    
    UIColor *result = nil;
    result = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    free(rawData);
    return result;
}
/**
 *  @brief  取某一像素的颜色
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)gx_colorAtPixel:(CGPoint)point
{
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }
    
    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */

+ (UIImage*)gx_covertToGrayImageFromImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return grayImage;
}

- (UIImage *)gx_imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur
{
    CGSize border = CGSizeMake(fabs(offset.width) + blur, fabs(offset.height) + blur);
    
    CGSize size = CGSizeMake(self.size.width + border.width * 2.0f, self.size.height + border.height * 2.0f);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShadowWithColor(context, offset, blur, color.CGColor);
    
    [self drawAtPoint:CGPointMake(border.width, border.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




-(UIImage *)gx_updateImageWithTintColor:(UIColor*)color
{
    return [self gx_updateImageWithTintColor:color alpha:1.0f];
}
-(UIImage *)gx_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha
{
    return [self gx_updateImageWithTintColor:color alpha:alpha insets:UIEdgeInsetsMake(0, 0, 0, 0)];
}
-(UIImage *)gx_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets
{
    CGRect originRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    CGRect tintImageRect = UIEdgeInsetsInsetRect(originRect, insets);
    return [self gx_updateImageWithTintColor:color alpha:alpha insets:UIEdgeInsetsMake(0, 0, 0, 0) rect:tintImageRect];
}

#pragma mark - 全能初始化方法
-(UIImage *)gx_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets rect:(CGRect)rect
{
    CGRect imageRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    
    // 启动图形上下文
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    // 获取图片上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // 利用drawInRect方法绘制图片到layer, 是通过拉伸原有图片
    [self drawInRect:imageRect];
    // 设置图形上下文的填充颜色
    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    // 设置图形上下文的透明度
    CGContextSetAlpha(contextRef, alpha);
    // 设置混合模式
    CGContextSetBlendMode(contextRef, kCGBlendModeSourceAtop);
    // 填充当前rect
    CGContextFillRect(contextRef, rect);
    
    // 根据位图上下文创建一个CGImage图片，并转换成UIImage
    CGImageRef imageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *tintedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    // 释放 imageRef，否则内存泄漏
    CGImageRelease(imageRef);
    // 从堆栈的顶部移除图形上下文
    UIGraphicsEndImageContext();
    
    return tintedImage;
}



+ (UIImage *)gx_triangleImageWithSize:(CGSize)size color:(UIColor *)color direction:(TriangleDirection)direction
{
    size = CGSizeMake(size.width*[UIScreen mainScreen].scale, size.height*[UIScreen mainScreen].scale);
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIImage *myImage = [UIImage gx_imageWithColor:color Size:size];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint sPoints[3];//坐标点
    if (direction == TriangleDirection_Down) {
        sPoints[0] =CGPointMake(0, 0);//坐标1
        sPoints[1] =CGPointMake(size.width, 0);//坐标2
        sPoints[2] =CGPointMake(size.width/2, size.height);//坐标3
    } else if (direction == TriangleDirection_Up) {
        sPoints[0] =CGPointMake(size.width/2, 0);//坐标1
        sPoints[1] =CGPointMake(0, size.height);//坐标2
        sPoints[2] =CGPointMake(size.width, size.height);//坐标3
    } else if (direction == TriangleDirection_Left) {
        sPoints[0] =CGPointMake(size.width, 0);//坐标1
        sPoints[1] =CGPointMake(0, size.height/2);//坐标2
        sPoints[2] =CGPointMake(size.width, size.height);//坐标3
    } else if (direction == TriangleDirection_Right) {
        sPoints[0] =CGPointMake(0, 0);//坐标1
        sPoints[1] =CGPointMake(0, size.height);//坐标2
        sPoints[2] =CGPointMake(size.width, size.height/2);//坐标3
    }
    
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextClip(context);
    [myImage drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (nullable UIImage *)gx_imageWithEmoji:(NSString *_Nonnull)emoji size:(CGFloat)size
{
    if (emoji.length == 0) return nil;
    if (size < 1) return nil;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CTFontRef font = CTFontCreateWithName(CFSTR("AppleColorEmoji"), size * scale, NULL);
    if (!font) return nil;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:emoji attributes:@{ (__bridge id)kCTFontAttributeName:(__bridge id)font, (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor whiteColor].CGColor }];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(NULL, size * scale, size * scale, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFTypeRef)str);
    CGRect bounds = CTLineGetBoundsWithOptions(line, kCTLineBoundsUseGlyphPathBounds);
    CGContextSetTextPosition(ctx, 0, -bounds.origin.y);
    CTLineDraw(line, ctx);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
    
    CFRelease(font);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(ctx);
    if (line)CFRelease(line);
    if (imageRef) CFRelease(imageRef);
    
    return image;
}


@end
