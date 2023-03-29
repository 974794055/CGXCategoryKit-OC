//
//  UIView+CGXRoundedCorners.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXRoundedCorners.h"
#import <objc/runtime.h>

static const void *CGXRound_keyborderWidth = @"CGXRound_borderWidth";
static const void *CGXRound_keyborderColor = @"CGXRound_borderColor";
static const void *CGXRound_keycornerRadius = @"CGXRound_keycornerRadius";
static const void *CGXRound_keygx_backgroundColor = @"CGXRound_keygx_backgroundColor";

@interface UIView ()

@property(nonatomic, strong) CAShapeLayer *gx_maskLayer;
@property(nonatomic, strong) CAShapeLayer *gx_borderLayer;
@property(nonatomic, strong) CAShapeLayer *gx_shadowborderLayer;

@end

@implementation UIView (CGXRoundedCorners)


- (void)setGx_borderLayer:(CAShapeLayer *)gx_borderLayer
{
    objc_setAssociatedObject(self, @selector(gx_borderLayer), gx_borderLayer, OBJC_ASSOCIATION_RETAIN);
}
- (CAShapeLayer *)gx_borderLayer
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setGx_shadowborderLayer:(CAShapeLayer *)gx_shadowborderLayer
{
    objc_setAssociatedObject(self, @selector(gx_shadowborderLayer), gx_shadowborderLayer, OBJC_ASSOCIATION_RETAIN);
}
- (CAShapeLayer *)gx_shadowborderLayer
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setGx_maskLayer:(CAShapeLayer *)gx_maskLayer
{
    objc_setAssociatedObject(self, @selector(gx_maskLayer), gx_maskLayer, OBJC_ASSOCIATION_RETAIN);
}
- (CAShapeLayer *)gx_maskLayer
{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - Border
- (CGFloat)gx_borderWidth {
    NSNumber *borderWidth = objc_getAssociatedObject(self, CGXRound_keyborderWidth);
    if ([borderWidth respondsToSelector:@selector(doubleValue)]) {
        return borderWidth.doubleValue;
    }
    return 0;
}
- (void)setGx_borderWidth:(CGFloat)gx_borderWidth {
    objc_setAssociatedObject(self,CGXRound_keyborderWidth, @(gx_borderWidth),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadViewBorderRound];
}
- (UIColor *)gx_borderColor {
    UIColor *color = objc_getAssociatedObject(self, CGXRound_keyborderColor);
    if (color) {
        return color;
    }
    return self.backgroundColor;
}
- (void)setGx_borderColor:(UIColor *)gx_borderColor {
    objc_setAssociatedObject(self,CGXRound_keyborderColor,gx_borderColor,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadViewBorderRound];
}
- (UIColor *)gx_backgroundColor {
    UIColor *color = objc_getAssociatedObject(self, CGXRound_keygx_backgroundColor);
    if (color) {
        return color;
    }
    return self.backgroundColor;
}
- (void)setGx_backgroundColor:(UIColor *)gx_backgroundColor {
    objc_setAssociatedObject(self,CGXRound_keygx_backgroundColor,gx_backgroundColor,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadViewBorderRound];
}

- (CGFloat)gx_cornerRadius {
    NSNumber *cornerRadius = objc_getAssociatedObject(self, CGXRound_keycornerRadius);
    if ([cornerRadius respondsToSelector:@selector(doubleValue)]) {
        return cornerRadius.doubleValue;
    }
    return 0;
}
- (void)setGx_cornerRadius:(CGFloat)gx_cornerRadius {
    objc_setAssociatedObject(self,CGXRound_keycornerRadius, @(gx_cornerRadius),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadViewBorderRound];
}
- (void)setGx_clipType:(CGXRoundedClipType)gx_clipType
{
    if(self.gx_clipType == gx_clipType){
        // 数值相同不需要修改
        return;
    }
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(gx_clipType), @(gx_clipType), OBJC_ASSOCIATION_RETAIN);
    [self reloadViewBorderRound];
}
- (CGXRoundedClipType)gx_clipType
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}

/**
便捷添加圆角
@param radius 圆角角度
*/
- (void)gx_roundedCornerWithTopRadius:(CGFloat)radius
{
    [self gx_roundedCornerWithRadius:radius clipWithType:CGXRoundedClipTypeTopLeft | CGXRoundedClipTypeTopRight];
}
- (void)gx_roundedCornerWithBottomRadius:(CGFloat)radius
{
    [self gx_roundedCornerWithRadius:radius clipWithType:CGXRoundedClipTypeBottomLeft | CGXRoundedClipTypeBottomRight];
}
- (void)gx_roundedCornerWithLeftRadius:(CGFloat)radius
{
    [self gx_roundedCornerWithRadius:radius clipWithType:CGXRoundedClipTypeTopLeft | CGXRoundedClipTypeBottomLeft];
}
- (void)gx_roundedCornerWithRightRadius:(CGFloat)radius
{
    [self gx_roundedCornerWithRadius:radius clipWithType:CGXRoundedClipTypeTopRight | CGXRoundedClipTypeBottomRight];
}
- (void)gx_roundedCornerWithAllRadius:(CGFloat)radius
{
    [self gx_roundedCornerWithRadius:radius clipWithType:CGXRoundedClipTypeAll];
}
/**
 便捷添加圆角

 @param clipType 圆角类型
 @param radius 圆角角度
 */
- (void)gx_roundedCornerWithRadius:(CGFloat)radius clipWithType:(CGXRoundedClipType)clipType
{
    self.gx_clipType = clipType;
    self.gx_cornerRadius = radius;
    [self reloadViewBorderRound];
}
/**
 便捷给添加border

 @param color 边框的颜色
 @param borderWidth 边框的宽度
 */
- (void)gx_BorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
    self.gx_borderColor = color;
    self.gx_borderWidth = borderWidth;
    [self reloadViewBorderRound];
}

- (void)gx_cornerRadius:(CGFloat)cornerRadius
{
    [self gx_cornerRadius:cornerRadius clipWithType:CGXRoundedClipTypeAll];
}
- (void)gx_cornerRadius:(CGFloat)cornerRadius
           clipWithType:(CGXRoundedClipType)clipType
{
    [self gx_cornerRadius:cornerRadius borderWidth:0 borderColor:nil backgroundColor:nil clipWithType:clipType];
}
- (void)gx_cornerRadius:(CGFloat)cornerRadius
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor
{
    [self gx_cornerRadius:cornerRadius borderWidth:borderWidth borderColor:borderColor clipWithType:CGXRoundedClipTypeAll];
}
- (void)gx_cornerRadius:(CGFloat)cornerRadius
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor
           clipWithType:(CGXRoundedClipType)clipType
{
    [self gx_cornerRadius:cornerRadius borderWidth:borderWidth borderColor:borderColor backgroundColor:nil clipWithType:clipType];
}
- (void)gx_cornerRadius:(CGFloat)cornerRadius
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor
        backgroundColor:(nullable UIColor *)backgroundColor
           clipWithType:(CGXRoundedClipType)clipType
{
    self.gx_cornerRadius = cornerRadius;
    self.gx_clipType = clipType;
    self.gx_borderWidth = borderWidth;
    self.gx_borderColor = borderColor;
    self.gx_backgroundColor = backgroundColor;
    [self reloadViewBorderRound];
}
- (void)reloadViewBorderRound
{
    [self layoutIfNeeded];
    [self setNeedsLayout];
    CGRect sizeFrame =self.bounds;
    if (sizeFrame.size.width > 0 && sizeFrame.size.height > 0) {
        // 解决中文label添加圆角及边框出现奇怪现象的问题
        if ([self isKindOfClass:[UILabel class]]) {
            self.layer.masksToBounds = YES;
        }
        if (!self.gx_borderLayer) {
            self.gx_borderLayer = [CAShapeLayer layer];
            [self.layer insertSublayer:self.gx_borderLayer atIndex:0];
        }
        if (!self.gx_maskLayer) {
            self.gx_maskLayer = [CAShapeLayer layer];
            [self.layer setMask:self.gx_maskLayer];
        }
        UIColor *strokeColor = self.gx_borderColor ? self.gx_borderColor:[UIColor clearColor];
        CGFloat lineWidth = self.gx_borderWidth > 0 ? self.gx_borderWidth:0;
        UIColor *fillColor = self.gx_backgroundColor ? self.gx_backgroundColor: [UIColor clearColor];
        CGFloat cornerRadius = self.gx_cornerRadius > 0 ? self.gx_cornerRadius:0;
        UIRectCorner corners = UIRectCornerAllCorners;
        if(self.gx_clipType != CGXRoundedClipTypeNone){
            corners = (UIRectCorner)self.gx_clipType;
        }
        self.gx_maskLayer.frame = sizeFrame;
        self.gx_borderLayer.frame = sizeFrame;
        self.gx_borderLayer.lineWidth = lineWidth;
        self.gx_borderLayer.fillColor = fillColor.CGColor;
        if (@available(iOS 13.0, *)) {
            self.gx_borderLayer.strokeColor = [strokeColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
        } else {
            self.gx_borderLayer.strokeColor = strokeColor.CGColor;
        }
        if(self.gx_borderWidth <= 0 || self.gx_borderColor == nil){
            if(self.gx_borderLayer){
                [self.gx_borderLayer removeFromSuperlayer];
            }
            self.gx_borderLayer = nil;
        }
        if (self.gx_clipType == CGXRoundedClipTypeNone || self.gx_cornerRadius <= 0) {
            // 以前使用了maskLayer，去掉
            if(self.layer.mask == self.gx_maskLayer){
                self.layer.mask = nil;
            }
            self.gx_maskLayer = nil;
            cornerRadius = 0;
        }
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:sizeFrame byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        if(self.gx_maskLayer){
            self.gx_maskLayer.path = bezierPath.CGPath;
        }
        if(self.gx_borderLayer){
            self.gx_borderLayer.path = bezierPath.CGPath;
        }
//        if(!self.gx_shadowborderLayer){
//            self.gx_shadowborderLayer = [CAShapeLayer layer];
//            if (@available(iOS 13.0, *)) {
//                self.layer.shadowColor = [[UIColor orangeColor] resolvedColorWithTraitCollection:self.traitCollection].CGColor;
//            } else {
//                self.layer.shadowColor = [UIColor orangeColor].CGColor;
//            }
//            self.layer.shadowOffset = CGSizeMake(4, 4);
//            self.layer.shadowOpacity = 4;
//            self.layer.shadowRadius = 4;
//        }
    }
}
- (UIColor *)private_color:(UIColor *)backgroundColor {
    UIColor *bgColor = nil;
    if (backgroundColor == nil || CGColorEqualToColor(backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
        UIView *superview = self.superview;
        while (superview.backgroundColor == nil || CGColorEqualToColor(superview.backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
            if (!superview) {
                break;
            }
            superview = [superview superview];
        }
        bgColor = superview.backgroundColor;
    } else {
        bgColor = backgroundColor;
    }
    if (bgColor == nil) {
        bgColor = self.backgroundColor;
    }
    if (CGColorEqualToColor(bgColor.CGColor, [UIColor clearColor].CGColor)) {
        bgColor = [UIColor whiteColor];
    }
    return bgColor;
}


@end
