//
//  UIImage+CGXClip.m
//  CGXCategoryKit-OC-OC
//
//  CGXCategoryKit-OC
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UIImage+CGXClip.h"
#import <objc/runtime.h>

static const char *s_gx_image_borderColorKey = "s_gx_image_borderColorKey";
static const char *s_gx_image_borderWidthKey = "s_gx_image_borderWidthKey";
static const char *s_gx_image_pathColorKey = "s_gx_image_pathColorKey";
static const char *s_gx_image_pathWidthKey = "s_gx_image_pathWidthKey";


@implementation UIImage (CGXClip)

#pragma mark - Border
- (CGFloat)gx_borderWidth {
    NSNumber *borderWidth = objc_getAssociatedObject(self, s_gx_image_borderWidthKey);
    if ([borderWidth respondsToSelector:@selector(doubleValue)]) {
        return borderWidth.doubleValue;
    }
    return 0;
}
- (void)setGx_borderWidth:(CGFloat)gx_borderWidth {
    objc_setAssociatedObject(self,s_gx_image_borderWidthKey,@(gx_borderWidth),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)gx_pathWidth {
    NSNumber *width = objc_getAssociatedObject(self, s_gx_image_pathWidthKey);
    if ([width respondsToSelector:@selector(doubleValue)]) {
        return width.doubleValue;
    }
    return 0;
}

- (void)setGx_pathWidth:(CGFloat)gx_pathWidth {
    objc_setAssociatedObject(self,s_gx_image_pathWidthKey,@(gx_pathWidth),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)gx_pathColor {
    UIColor *color = objc_getAssociatedObject(self, s_gx_image_pathColorKey);
    if (color) {
        return color;
    }
    return [UIColor whiteColor];
}

- (void)setGx_pathColor:(UIColor *)gx_pathColor {
    objc_setAssociatedObject(self,s_gx_image_pathColorKey,gx_pathColor,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)gx_borderColor {
    UIColor *color = objc_getAssociatedObject(self, s_gx_image_borderColorKey);
    if (color) {
        return color;
    }
    return [UIColor lightGrayColor];
}
- (void)setGx_borderColor:(UIColor *)gx_borderColor {
    objc_setAssociatedObject(self,s_gx_image_borderColorKey,gx_borderColor,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (UIImage *)gx_clipToSize:(CGSize)targetSize
{
    return [self gx_clipToSize:targetSize backgroundColor:[UIColor clearColor] isEqualScale:YES];
}

- (UIImage *)gx_clipToSize:(CGSize)targetSize
           backgroundColor:(UIColor *)backgroundColor
{
    return [self gx_clipToSize:targetSize backgroundColor:[UIColor clearColor] isEqualScale:YES];
}
- (UIImage *)gx_clipToSize:(CGSize)targetSize
           backgroundColor:(UIColor *)backgroundColor
              isEqualScale:(BOOL)isEqualScale
{
    return  [self gx_clipToSize:targetSize cornerRadius:0 corners:UIRectCornerAllCorners backgroundColor:backgroundColor isEqualScale:isEqualScale isCircle:YES];
}
- (UIImage *)gx_clipToSize:(CGSize)targetSize
              cornerRadius:(CGFloat)cornerRadius
{
    return [self gx_clipToSize:targetSize cornerRadius:cornerRadius corners:UIRectCornerAllCorners];
}
- (UIImage *)gx_clipToSize:(CGSize)targetSize
              cornerRadius:(CGFloat)cornerRadius
                   corners:(UIRectCorner)corners
{
    return [self gx_clipToSize:targetSize cornerRadius:cornerRadius corners:UIRectCornerAllCorners backgroundColor:[UIColor clearColor]];
}
- (UIImage *)gx_clipToSize:(CGSize)targetSize
              cornerRadius:(CGFloat)cornerRadius
                   corners:(UIRectCorner)corners
           backgroundColor:(UIColor *)backgroundColor
{
    return  [self gx_clipToSize:targetSize cornerRadius:cornerRadius corners:corners backgroundColor:backgroundColor isEqualScale:YES];
}
- (UIImage *)gx_clipToSize:(CGSize)targetSize
              cornerRadius:(CGFloat)cornerRadius
                   corners:(UIRectCorner)corners
              isEqualScale:(BOOL)isEqualScale
{
    return  [self gx_clipToSize:targetSize cornerRadius:cornerRadius corners:corners backgroundColor:[UIColor clearColor] isEqualScale:isEqualScale];
}

- (UIImage *)gx_clipToSize:(CGSize)targetSize
              cornerRadius:(CGFloat)cornerRadius
                   corners:(UIRectCorner)corners
           backgroundColor:(UIColor *)backgroundColor
              isEqualScale:(BOOL)isEqualScale
{
    return  [self gx_clipToSize:targetSize cornerRadius:cornerRadius corners:corners backgroundColor:backgroundColor isEqualScale:isEqualScale isCircle:YES];
}

- (UIImage *)gx_clipToSize:(CGSize)targetSize
              cornerRadius:(CGFloat)cornerRadius
                   corners:(UIRectCorner)corners
           backgroundColor:(UIColor *)backgroundColor
              isEqualScale:(BOOL)isEqualScale
                  isCircle:(BOOL)isCircle
{
    if (targetSize.width <= 0 || targetSize.height <= 0) {
        return self;
    }
    //  NSTimeInterval timerval = CFAbsoluteTimeGetCurrent();
    CGSize imgSize = self.size;
    CGSize resultSize = targetSize;
    if (isEqualScale) {
        CGFloat x = MAX(targetSize.width / imgSize.width, targetSize.height / imgSize.height);
        resultSize = CGSizeMake(x * imgSize.width, x * imgSize.height);
    }
    
    CGRect targetRect = (CGRect){0, 0, resultSize.width, resultSize.height};
    
    if (isCircle) {
        CGFloat width = MIN(resultSize.width, resultSize.height);
        targetRect = (CGRect){0, 0, width, width};
    }
    
    CGFloat pathWidth = self.gx_pathWidth;
    CGFloat borderWidth = self.gx_borderWidth;
    
    if (pathWidth > 0 && borderWidth > 0 && (isCircle || cornerRadius == 0)) {
        UIGraphicsBeginImageContextWithOptions(targetRect.size,
                                               backgroundColor != nil,
                                               [UIScreen mainScreen].scale);
        if (backgroundColor) {
            [backgroundColor setFill];
            CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
        }
        
        UIColor *borderColor = self.gx_borderColor;
        UIColor *pathColor = self.gx_pathColor;
        
        CGRect rect = targetRect;
        CGRect rectImage = rect;
        rectImage.origin.x += pathWidth;
        rectImage.origin.y += pathWidth;
        rectImage.size.width -= pathWidth * 2.0;
        rectImage.size.height -= pathWidth * 2.0;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        if (isCircle) {
            CGContextAddEllipseInRect(ctx, rect);
        } else {
            CGContextAddRect(ctx, rect);
        }
        
        CGContextClip(ctx);
        [self drawInRect:rectImage];
        
        // 添加内线和外线
        rectImage.origin.x -= borderWidth / 2.0;
        rectImage.origin.y -= borderWidth / 2.0;
        rectImage.size.width += borderWidth;
        rectImage.size.height += borderWidth;
        
        rect.origin.x += borderWidth / 2.0;
        rect.origin.y += borderWidth / 2.0;
        rect.size.width -= borderWidth;
        rect.size.height -= borderWidth;
        
        CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
        CGContextSetLineWidth(ctx, borderWidth);
        
        if (isCircle) {
            CGContextStrokeEllipseInRect(ctx, rectImage);
            CGContextStrokeEllipseInRect(ctx, rect);
        } else if (cornerRadius == 0) {
            CGContextStrokeRect(ctx, rectImage);
            CGContextStrokeRect(ctx, rect);
        }
        
        float centerPathWidth = pathWidth - borderWidth * 2.0;
        if (centerPathWidth > 0) {
            CGContextSetLineWidth(ctx, centerPathWidth);
            CGContextSetStrokeColorWithColor(ctx, [pathColor CGColor]);
            
            rectImage.origin.x -= borderWidth / 2.0 + centerPathWidth / 2.0;
            rectImage.origin.y -= borderWidth / 2.0 + centerPathWidth / 2.0;
            rectImage.size.width += borderWidth + centerPathWidth;
            rectImage.size.height += borderWidth + centerPathWidth;
            
            if (isCircle) {
                CGContextStrokeEllipseInRect(ctx, rectImage);
            } else if (cornerRadius == 0) {
                CGContextStrokeRect(ctx, rectImage);
            }
        }
    } else if (pathWidth > 0 && borderWidth > 0 && cornerRadius > 0 && !isCircle) {
        UIGraphicsBeginImageContextWithOptions(targetRect.size,
                                               backgroundColor != nil,
                                               [UIScreen mainScreen].scale);
        if (backgroundColor) {
            [backgroundColor setFill];
            CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
        }
        
        UIColor *borderColor = self.gx_borderColor;
        UIColor *pathColor = self.gx_pathColor;
        
        CGRect rect = targetRect;
        CGRect rectImage = rect;
        rectImage.origin.x += pathWidth;
        rectImage.origin.y += pathWidth;
        rectImage.size.width -= pathWidth * 2.0;
        rectImage.size.height -= pathWidth * 2.0;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [self drawInRect:rectImage];
        
        // 添加内线和外线
        rectImage.origin.x -= borderWidth / 2.0;
        rectImage.origin.y -= borderWidth / 2.0;
        rectImage.size.width += borderWidth;
        rectImage.size.height += borderWidth;
        
        rect.origin.x += borderWidth / 2.0;
        rect.origin.y += borderWidth / 2.0;
        rect.size.width -= borderWidth;
        rect.size.height -= borderWidth;
        
        CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
        CGContextSetLineWidth(ctx, borderWidth);
        
        CGFloat minusPath1 = pathWidth / 2;
        UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:rectImage byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius - minusPath1, cornerRadius - minusPath1)];
        CGContextAddPath(ctx, path1.CGPath);
        
        UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    byRoundingCorners:corners
                                                          cornerRadii:CGSizeMake(cornerRadius + minusPath1 ,cornerRadius + minusPath1)];
        CGContextAddPath(ctx, path2.CGPath);
        CGContextStrokePath(ctx);
        
        float centerPathWidth = pathWidth - borderWidth * 2.0;
        if (centerPathWidth > 0) {
            CGContextSetLineWidth(ctx, centerPathWidth);
            CGContextSetStrokeColorWithColor(ctx, [pathColor CGColor]);
            
            rectImage.origin.x -= borderWidth / 2.0 + centerPathWidth / 2.0;
            rectImage.origin.y -= borderWidth / 2.0 + centerPathWidth / 2.0;
            rectImage.size.width += borderWidth + centerPathWidth;
            rectImage.size.height += borderWidth + centerPathWidth;
            
            UIBezierPath *path3 = [UIBezierPath bezierPathWithRoundedRect:rectImage
                                                        byRoundingCorners:corners
                                                              cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CGContextAddPath(ctx, path3.CGPath);
            CGContextStrokePath(ctx);
        }
    } else if (pathWidth <= 0 && borderWidth > 0 && (cornerRadius > 0 || isCircle)) {
        UIColor *borderColor = self.gx_borderColor;
        
        CGRect rect = targetRect;
        CGRect rectImage = rect;
        rectImage.origin.x += borderWidth / 2;
        rectImage.origin.y += borderWidth / 2;
        rectImage.size.width -= borderWidth;
        rectImage.size.height -= borderWidth;
        
        UIImage *image = [self gx_privatescaleToSize:rectImage.size backgroundColor:backgroundColor];
        UIGraphicsBeginImageContextWithOptions(targetRect.size,
                                               NO,
                                               [UIScreen mainScreen].scale);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithPatternImage:image].CGColor);
        
        UIBezierPath *path1 = nil;
        if (!isCircle) {
            CGFloat minusPath1 = borderWidth / 2;
            path1 = [UIBezierPath bezierPathWithRoundedRect:rectImage
                                          byRoundingCorners:corners
                                                cornerRadii:CGSizeMake(cornerRadius - minusPath1, cornerRadius - minusPath1)];
        } else {
            path1 = [UIBezierPath bezierPathWithRoundedRect:rectImage
                                          byRoundingCorners:corners
                                                cornerRadii:CGSizeMake(rectImage.size.width / 2, rectImage.size.width / 2)];
        }
        
        CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
        CGContextSetLineWidth(ctx, borderWidth);
        CGContextAddPath(ctx, path1.CGPath);
        CGContextDrawPath(ctx, kCGPathFillStroke);
    } else {
        UIGraphicsBeginImageContextWithOptions(targetRect.size,
                                               backgroundColor != nil,
                                               [UIScreen mainScreen].scale);
        if (backgroundColor) {
            [backgroundColor setFill];
            CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
        }
        
        if (isCircle) {
            CGContextAddPath(UIGraphicsGetCurrentContext(),
                             [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                        cornerRadius:targetRect.size.width / 2].CGPath);
            CGContextClip(UIGraphicsGetCurrentContext());
        } else if (cornerRadius > 0) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                       byRoundingCorners:corners
                                                             cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
            CGContextClip(UIGraphicsGetCurrentContext());
        }
        
        [self drawInRect:targetRect];
    }
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //  NSLog(@"time:%f  originalImageSize: %@, targetSize: %@",
    //        CFAbsoluteTimeGetCurrent() - timerval,
    //        NSStringFromCGSize(imgSize),
    //        NSStringFromCGSize(targetSize));
    
    return finalImage;
}
- (UIImage *)gx_privatescaleToSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    if (backgroundColor) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextAddRect(context, rect);
        CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    }
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
