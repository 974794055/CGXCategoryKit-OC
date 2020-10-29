//
//  UIButton+CGXClickArea.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UIButton+CGXClickArea.h"
#import <objc/runtime.h>


static const char * kHitEdgeInsets = "hitEdgeInsets";
static const char * kHitScale      = "hitScale";
static const char * kHitWidthScale      = "hitWidthScale";
static const char * kHitHeightScale      = "hitHeightScale";
@implementation UIButton (CGXClickArea)

#pragma mark - set Method
-(void)setGx_hitEdgeInsets:(UIEdgeInsets)gx_hitEdgeInsets{
    NSValue *value = [NSValue value:&gx_hitEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self,kHitEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setGx_hitScale:(CGFloat)gx_hitScale{
    CGFloat width = self.bounds.size.width * gx_hitScale;
    CGFloat height = self.bounds.size.height * gx_hitScale;
    self.gx_hitEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
    objc_setAssociatedObject(self, kHitScale, @(gx_hitScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void)setGx_hitWidthScale:(CGFloat)gx_hitWidthScale{
    CGFloat width = self.bounds.size.width * gx_hitWidthScale;
    CGFloat height = self.bounds.size.height ;
    self.gx_hitEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
    objc_setAssociatedObject(self, kHitWidthScale, @(gx_hitWidthScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setGx_hitHeightScale:(CGFloat)gx_hitHeightScale{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height * gx_hitHeightScale ;
    self.gx_hitEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
    objc_setAssociatedObject(self, kHitHeightScale, @(gx_hitHeightScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - get Method
-(UIEdgeInsets)gx_hitEdgeInsets{
    NSValue *value = objc_getAssociatedObject(self, kHitEdgeInsets);
    UIEdgeInsets edgeInsets;
    [value getValue:&edgeInsets];
    return value ? edgeInsets:UIEdgeInsetsZero;
}

-(CGFloat)gx_hitScale{
    return [objc_getAssociatedObject(self, kHitScale) floatValue];
}

-(CGFloat)gx_hitWidthScale{
    return [objc_getAssociatedObject(self, kHitWidthScale) floatValue];
}

-(CGFloat)gx_hitHeightScale{
    return [objc_getAssociatedObject(self, kHitHeightScale) floatValue];
}

#pragma mark - override super method
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //如果 button 边界值无变化  失效 隐藏 或者透明 直接返回
    if(UIEdgeInsetsEqualToEdgeInsets(self.gx_hitEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden || self.alpha == 0 ) {
        return [super pointInside:point withEvent:event];
    }else{
        CGRect relativeFrame = self.bounds;
        CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.gx_hitEdgeInsets);
        return CGRectContainsPoint(hitFrame, point);
    }
}

@end
