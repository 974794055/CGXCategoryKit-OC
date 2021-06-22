//
//  UIButton+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UIButton+CGXExtension.h"

@implementation UIButton (CGXExtension)

- (void)gx_leftAlignment {
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}
- (void)gx_centerAlignment {
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}
- (void)gx_rightAlignment {
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}
- (void)gx_topAlignment {
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
}
- (void)gx_bottomAlignment {
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
}
/**
 * 设置普通状态与高亮状态的文字
 */
- (void)gx_NormaTitle:(NSString *)nTitle H_Title:(NSString *)hTitle
{
    [self setTitle:nTitle forState:UIControlStateNormal];
    [self setTitle:hTitle forState:UIControlStateHighlighted];
}
- (void)gx_NormalTitleColor:(UIColor *)nColor HColor:(UIColor *)hColor
{
    [self setTitleColor:nColor forState:UIControlStateNormal];
    [self setTitleColor:hColor forState:UIControlStateHighlighted];
}
- (void)gx_NormalBG:(NSString *)nbg H_BG:(NSString *)hbg
{
    [self setBackgroundImage:[UIImage imageNamed:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateHighlighted];
}

- (void)gx_NormalBgImage:(NSString *)nbg H_Image:(NSString *)hbg Size:(CGSize)size
{
    UIImage *normalImage = [UIImage imageNamed:nbg];
    int normalLeftCap = normalImage.size.width * size.width;
    int normalTopCap = normalImage.size.height * size.height;
    [self setBackgroundImage:[normalImage stretchableImageWithLeftCapWidth:normalLeftCap topCapHeight:normalTopCap] forState:UIControlStateNormal];
    
    UIImage *highlightedImage = [UIImage imageNamed:hbg];
    int highlightedImageLeftCap = normalImage.size.width * size.width;
    int highlightedImageTopCap = normalImage.size.height * size.height;
    [self setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:highlightedImageLeftCap topCapHeight:highlightedImageTopCap] forState:UIControlStateHighlighted];
}

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)gx_backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)gx_roundedRadius:(CGFloat)radius BorderColor:(UIColor *)color BorderWidth:(CGFloat)borderWidth RectCorner:(UIRectCorner)corners
{
//    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.bounds;
    borderLayer.lineWidth = borderWidth;
    borderLayer.strokeColor = color.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *bezierPath =  [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    [self.layer insertSublayer:borderLayer atIndex:0];
    [self.layer setMask:maskLayer];
}

@end
