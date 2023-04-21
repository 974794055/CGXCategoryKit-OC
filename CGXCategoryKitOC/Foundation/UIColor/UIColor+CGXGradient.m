//
//  UIColor+CGXGradient.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIColor+CGXGradient.h"

@implementation UIColor (CGXGradient)
/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)gx_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height
{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)gx_colorGradientChangeWithSize:(CGSize)size
                                  direction:(CGXGradientColorDirection)direction
                                 startColor:(UIColor*)startcolor
                                   endColor:(UIColor*)endColor{
    if(CGSizeEqualToSize(size,CGSizeZero) || !startcolor || !endColor) {
        return [UIColor clearColor];
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame=CGRectMake(0,0, size.width, size.height);
    CGPoint startPoint = CGPointZero;
    if (direction == CGXGradientColorDirectionDiagonalLineDown) {
        startPoint = CGPointMake(0.0,1.0);
    }
    gradientLayer.startPoint = startPoint;
    CGPoint endPoint = CGPointZero;
    switch(direction) {
        case CGXGradientColorDirectionLevel:
            endPoint = CGPointMake(1.0,0.0);
            break;
        case CGXGradientColorDirectionVertical:
            endPoint = CGPointMake(0.0,1.0);
            break;
        case CGXGradientColorDirectionDiagonalLineUp:
            endPoint = CGPointMake(1.0,1.0);
            break;
        case CGXGradientColorDirectionDiagonalLineDown:
            endPoint = CGPointMake(1.0,0.0);
            break;
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;
    gradientLayer.colors = @[(id)startcolor.CGColor, (id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}
@end
