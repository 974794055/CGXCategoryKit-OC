//
//  UIView+CGXRoundedRadius.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXRoundedRadius.h"
#import <objc/runtime.h>

static NSString * const CGXCornerRadiusPositionKey = @"CGXCornerRadiusPositionKey";
static NSString * const CGXCornerRadiusRadiusKey = @"CGXCornerRadiusRadiusKey";

@implementation UIView (CGXRoundedRadius)
@dynamic gx_cornerPosition;
- (CGXCornerPosition)gx_cornerPosition
{
    return [objc_getAssociatedObject(self, &CGXCornerRadiusPositionKey) integerValue];
}

- (void)setGx_cornerPosition:(CGXCornerPosition)gx_cornerPosition
{
    objc_setAssociatedObject(self, &CGXCornerRadiusPositionKey, @(gx_cornerPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic gx_cornerRadius;
- (CGFloat)gx_cornerRadius
{
    return [objc_getAssociatedObject(self, &CGXCornerRadiusRadiusKey) floatValue];
}

- (void)setGx_cornerRadius:(CGFloat)hg_cornerRadius
{
    objc_setAssociatedObject(self, &CGXCornerRadiusRadiusKey, @(hg_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    SEL ori = @selector(layoutSublayersOfLayer:);
    SEL new = NSSelectorFromString([@"cgx_" stringByAppendingString:NSStringFromSelector(ori)]);
    cgx_swizzle(self, ori, new);
}

void cgx_swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)cgx_layoutSublayersOfLayer:(CALayer *)layer
{
    [self cgx_layoutSublayersOfLayer:layer];
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    if (self.gx_cornerRadius > 0) {
        
        UIBezierPath *maskPath;
        switch (self.gx_cornerPosition) {
            case CGXCornerPositionTop:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.gx_cornerRadius, self.gx_cornerRadius)];
                break;
            case CGXCornerPositionLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(self.gx_cornerRadius, self.gx_cornerRadius)];
                break;
            case CGXCornerPositionBottom:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.gx_cornerRadius, self.gx_cornerRadius)];
                break;
            case CGXCornerPositionRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.gx_cornerRadius, self.gx_cornerRadius)];
                break;
            case CGXCornerPositionAll:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerAllCorners
                                                       cornerRadii:CGSizeMake(self.gx_cornerRadius, self.gx_cornerRadius)];
                break;
        }
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)gx_setCornerOnTopWithRadius:(CGFloat)radius
{
    self.gx_cornerPosition = CGXCornerPositionTop;
    self.gx_cornerRadius = radius;
}

- (void)gx_setCornerOnLeftWithRadius:(CGFloat)radius
{
    self.gx_cornerPosition = CGXCornerPositionLeft;
    self.gx_cornerRadius = radius;
}

- (void)gx_setCornerOnBottomWithRadius:(CGFloat)radius
{
    self.gx_cornerPosition = CGXCornerPositionBottom;
    self.gx_cornerRadius = radius;
}

- (void)gx_setCornerOnRightWithRadius:(CGFloat)radius
{
    self.gx_cornerPosition = CGXCornerPositionRight;
    self.gx_cornerRadius = radius;
}

- (void)gx_setAllCornerWithCornerRadius:(CGFloat)radius
{
    self.gx_cornerPosition = CGXCornerPositionAll;
    self.gx_cornerRadius = radius;
}

- (void)gx_setNoneCorner
{
    self.layer.mask = nil;
}
    

@end
