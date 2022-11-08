//
//  UIImage+CGXRadius.m
//  CGXCategoryKit-OC-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UIImage+CGXRadius.h"



@implementation UIImage (CGXRadius)
- (UIImage *)gx_imageWithCornerRadius:(CGFloat)radius
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0f, radius);
    CGContextAddLineToPoint(context, 0.0f, self.size.height - radius);
    CGContextAddArc(context, radius, self.size.height - radius, radius, M_PI, M_PI / 2.0f, 1);
    CGContextAddLineToPoint(context, self.size.width - radius, self.size.height);
    CGContextAddArc(context, self.size.width - radius, self.size.height - radius, radius, M_PI / 2.0f, 0.0f, 1);
    CGContextAddLineToPoint(context, self.size.width, radius);
    CGContextAddArc(context, self.size.width - radius, radius, radius, 0.0f, -M_PI / 2.0f, 1);
    CGContextAddLineToPoint(context, radius, 0.0f);
    CGContextAddArc(context, radius, radius, radius, -M_PI / 2.0f, M_PI, 1);
    CGContextClip(context);
    
    [self drawAtPoint:CGPointZero];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
//高效添加圆角图片
- (UIImage*)gx_imageWithCornerRadius:(CGFloat)radius andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)gx_imageWithRoundImage:(UIImage *)image
{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat redius = ((width <= height) ? width : height)/2;
    CGRect  rect = CGRectMake(width/2-redius, height/2-redius, redius*2, redius*2);
    
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImage.size.width, newImage.size.height), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(newImage.size.width/2, newImage.size.height/2) radius:redius startAngle:0 endAngle:M_PI*2 clockwise:0];
    [path addClip];
    [newImage drawAtPoint:CGPointZero];
    UIImage *imageCut = UIGraphicsGetImageFromCurrentImageContext();
    
    return imageCut;
    
}

+ (UIImage *)gx_imageWithColor:(UIColor *)color
                    targetSize:(CGSize)targetSize
                       corners:(UIRectCorner)corners
                  cornerRadius:(CGFloat)cornerRadius
               backgroundColor:(UIColor *)backgroundColor
{
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
    
    CGRect targetRect = (CGRect){0, 0, targetSize.width, targetSize.height};
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, targetRect);
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (cornerRadius != 0 && cornerRadius > 0) {
        UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
        
        if (backgroundColor) {
            [backgroundColor setFill];
            CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
        }
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
        CGContextClip(UIGraphicsGetCurrentContext());
        [finalImage drawInRect:targetRect];
        finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return finalImage;
}


/**
 绘制图片
 
 @param color 背景色
 @param size 大小
 @param text 文字
 @param textAttributes 字体设置
 @param isCircular 是否圆形
 @return 图片
 */
+ (UIImage *)gx_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    if (isCircular) {
        CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //1.获取上下文
    UIGraphicsBeginImageContext(img.size);
    //2.绘制图片
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    //文字的属性 text
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    //3.绘制文字
    CGRect rect33 = CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height);
    [text drawInRect:rect33 withAttributes:textAttributes];
    //4.获取绘制到得图片
    UIImage *watermarkImg = UIGraphicsGetImageFromCurrentImageContext();
    //5.结束图片的绘制
    UIGraphicsEndImageContext();
    
    return watermarkImg;
}

+ (UIImage *)gx_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize
{
    return [self gx_imageWithColor:color toSize:targetSize cornerRadius:0];
}
+ (UIImage *)gx_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius
{
    return [self gx_imageWithColor:color toSize:targetSize cornerRadius:cornerRadius];
}
+ (UIImage *)gx_imageWithColor:(UIColor *)color
                        toSize:(CGSize)targetSize
                  cornerRadius:(CGFloat)cornerRadius
               backgroundColor:(UIColor *)backgroundColor
{
    return [self gx_imageWithColor:color toSize:targetSize cornerRadius:cornerRadius backgroundColor:backgroundColor borderColor:color borderWidth:0];
}


+ (UIImage *)gx_imageWithColor:(UIColor *)color
                        toSize:(CGSize)targetSize
                  cornerRadius:(CGFloat)cornerRadius
               backgroundColor:(UIColor *)backgroundColor
                   borderColor:(UIColor *)borderColor
                   borderWidth:(CGFloat)borderWidth
{
    UIGraphicsBeginImageContextWithOptions(targetSize, cornerRadius == 0, [UIScreen mainScreen].scale);
    CGRect targetRect = (CGRect){0, 0, targetSize.width, targetSize.height};
    UIImage *finalImage = nil;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    if (cornerRadius == 0) {
        if (borderWidth > 0) {
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextSetLineWidth(context, borderWidth);
            CGContextFillRect(context, targetRect);
            targetRect = CGRectMake(borderWidth / 2, borderWidth / 2, targetSize.width - borderWidth, targetSize.height - borderWidth);
            CGContextStrokeRect(context, targetRect);
        } else {
            CGContextFillRect(context, targetRect);
        }
    } else {
        targetRect = CGRectMake(borderWidth / 2, borderWidth / 2, targetSize.width - borderWidth, targetSize.height - borderWidth);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
        if (borderWidth > 0) {
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextSetLineWidth(context, borderWidth);
            CGContextDrawPath(context, kCGPathFillStroke);
        } else {
            CGContextDrawPath(context, kCGPathFill);
        }
    }
    finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

@end
