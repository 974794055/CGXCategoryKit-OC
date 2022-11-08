//
//  UIView+CGXRound.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXRound.h"
#import <objc/runtime.h>

static const void *CGXRound_keyHeveRadius = @"CGXRound_keyHeveRadius";

static const void *CGXRound_keyborderWidth = @"CGXRound_borderWidth";
static const void *CGXRound_keyborderColor = @"CGXRound_borderColor";
static const void *CGXRound_keycornerRadius = @"CGXRound_keycornerRadius";

static const void *CGXRound_keymaskLayer = @"CGXRound_keymaskLayer";
static const void *CGXRound_keyborderLayer = @"CGXRound_keyborderLayer";
static const void *CGXRound_keygx_corner = @"CGXRound_keygx_corner";
static const void *CGXRound_keygx_backgroundColor = @"CGXRound_keygx_backgroundColor";


@interface UIView ()

@property (nonatomic, strong) CAShapeLayer *gx_maskLayer;

@property (nonatomic, strong) CAShapeLayer *gx_borderLayer;
@property (nonatomic, assign) UIRectCorner gx_corner;
@end

@implementation UIView (CGXRound)

- (CAShapeLayer *)gx_maskLayer
{
    return objc_getAssociatedObject(self, CGXRound_keymaskLayer) ;
}
- (void)setGx_maskLayer:(CAShapeLayer *)gx_maskLayer
{
    objc_setAssociatedObject(self,CGXRound_keymaskLayer, gx_maskLayer,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CAShapeLayer *)gx_borderLayer
{
    return objc_getAssociatedObject(self, CGXRound_keyborderLayer) ;
}
- (void)setGx_borderLayer:(CAShapeLayer *)gx_borderLayer
{
    objc_setAssociatedObject(self,CGXRound_keyborderLayer, gx_borderLayer,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIRectCorner)gx_corner
{
    return [objc_getAssociatedObject(self, CGXRound_keygx_corner) unsignedIntegerValue];
}
- (void)setGx_corner:(UIRectCorner)gx_corner
{
    objc_setAssociatedObject(self,CGXRound_keygx_corner, @(gx_corner),OBJC_ASSOCIATION_RETAIN);
    [self reloadViewBorderAndRound];
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
    [self reloadViewBorderAndRound];
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
    [self reloadViewBorderAndRound];
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
    [self reloadViewBorderAndRound];
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
    [self reloadViewBorderAndRound];
}


- (void)gx_cornerRadius:(CGFloat)cornerRadius
{
    [self gx_cornerRadius:cornerRadius corners:UIRectCornerAllCorners];
}
- (void)gx_cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corner
{
    [self gx_cornerRadius:cornerRadius corners:corner backgroundColor:nil];
}
- (void)gx_cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corner
        backgroundColor:(nullable UIColor *)backgroundColor
{
    [self gx_cornerRadius:cornerRadius corners:corner borderWidth:0 borderColor:nil backgroundColor:backgroundColor];
}

- (void)gx_cornerRadius:(CGFloat)cornerRadius
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor
{
    [self gx_cornerRadius:cornerRadius corners:UIRectCornerAllCorners borderWidth:borderWidth borderColor:borderColor];
}

- (void)gx_cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corner
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor
{
    [self gx_cornerRadius:cornerRadius corners:corner borderWidth:borderWidth borderColor:borderColor backgroundColor:nil];
}
- (void)gx_cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corner
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor
        backgroundColor:(nullable UIColor *)backgroundColor
{
    self.gx_cornerRadius = cornerRadius;
    self.gx_corner = corner;
    self.gx_borderWidth = borderWidth;
    self.gx_borderColor = borderColor;
    self.gx_backgroundColor = backgroundColor;
    [self reloadViewBorderAndRound];
}
- (void)reloadViewBorderAndRound
{
    [self layoutIfNeeded];
    [self setNeedsLayout];
    CGRect sizeFrame =self.bounds;
    // 增加autolayout支持
    if (sizeFrame.size.width <= 0 || sizeFrame.size.height <= 0) {

        sizeFrame =self.bounds;
//        NSLog(@"sublayers1----:%@" , self.layer.sublayers);
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
        UIColor *strokeColor = self.gx_borderColor ? self.gx_borderColor:[UIColor whiteColor];
        CGFloat lineWidth = self.gx_borderWidth > 0 ? self.gx_borderWidth:0;
        UIColor *fillColor = self.gx_backgroundColor ? self.backgroundColor: [UIColor clearColor];
        CGFloat cornerRadius = self.gx_cornerRadius > 0 ? self.gx_cornerRadius:0;
        UIRectCorner corners = self.gx_corner ? self.gx_corner:UIRectCornerAllCorners;
        
        self.gx_maskLayer.frame = sizeFrame;
        self.gx_borderLayer.frame = sizeFrame;
        self.gx_borderLayer.lineWidth = lineWidth;
        self.gx_borderLayer.strokeColor = strokeColor.CGColor;
        self.gx_borderLayer.fillColor = fillColor.CGColor;
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:sizeFrame byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        self.gx_maskLayer.path = bezierPath.CGPath;
        self.gx_borderLayer.path = bezierPath.CGPath;
//
//        NSLog(@"sublayers2----:%@" , self.layer.sublayers);
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
