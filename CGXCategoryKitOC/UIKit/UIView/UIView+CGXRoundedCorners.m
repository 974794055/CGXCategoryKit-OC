//
//  UIView+CGXRoundedCorners.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXRoundedCorners.h"
#import <objc/runtime.h>


@interface UIView ()
@property(nonatomic, assign) BOOL needUpdateRadius;
@property(nonatomic, strong) CAShapeLayer *maskLayer;
@property(nonatomic, strong) CAShapeLayer *borderLayer;
@property(nonatomic, strong) CAShapeLayer *shadowborderLayer;

@property(nonatomic, assign) CGRect oldBounds;



@end
@implementation UIView (CGXRoundedCorners)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 变化方法实现
        [self gx_swizzleMethod:[self class] orgSel:@selector(layoutSubviews) swizzSel:@selector(gx_CGXRoundedCornerslayoutSubviews)];
    });
}
+ (void)gx_swizzleMethod:(Class)class orgSel:(SEL)originalSelector swizzSel:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    char *swizzledTypes = (char *)method_getTypeEncoding(swizzledMethod);
    
    IMP originalImp = method_getImplementation(originalMethod);
    char *originalTypes = (char *)method_getTypeEncoding(originalMethod);
    
    BOOL success = class_addMethod(class, originalSelector, swizzledImp, swizzledTypes);
    if (success) {
        class_replaceMethod(class, swizzledSelector, originalImp, originalTypes);
    }else {
        // 添加失败，表明已经有这个方法，直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
#pragma mark - 
- (void)gx_CGXRoundedCornerslayoutSubviews
{
    // 调用本身的实现
    [self gx_CGXRoundedCornerslayoutSubviews];
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    
    BOOL isFrameChange = NO;;
    if(!CGRectEqualToRect(self.oldBounds, self.bounds)){
        isFrameChange = YES;
        self.oldBounds = self.bounds;
    }
    UIBezierPath *maskPath = [UIBezierPath  bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCorner)self.gx_clipType cornerRadii:CGSizeMake(self.gx_clipRadius, self.gx_clipRadius)];
    
    if(self.needUpdateRadius || isFrameChange){
        self.needUpdateRadius = NO;
        if (self.gx_clipType == CGXRoundedClipTypeNone || self.gx_clipRadius <= 0) {
            // 以前使用了maskLayer，去掉
            if(self.layer.mask == self.maskLayer){
                self.layer.mask = nil;
            }
            self.maskLayer = nil;
        } else {
            if (self.layer.mask == nil) {
                self.maskLayer = [[CAShapeLayer alloc] init];
            }
            self.maskLayer.frame = self.bounds;
            self.maskLayer.path = maskPath.CGPath;
            self.layer.mask = self.maskLayer;
        }
    }
    
    if(self.gx_borderWidth <= 0 || self.gx_borderColor == nil){
        if(self.borderLayer){
            [self.borderLayer removeFromSuperlayer];
        }
        self.borderLayer = nil;
    }else{
        if(self.borderLayer == nil){
            self.borderLayer = [CAShapeLayer layer];
            self.borderLayer.lineWidth = self.gx_borderWidth;
            self.borderLayer.fillColor = [UIColor clearColor].CGColor;
            if (@available(iOS 13.0, *)) {
                self.borderLayer.strokeColor = [self.gx_borderColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
            } else {
                self.borderLayer.strokeColor = self.gx_borderColor.CGColor;
            }
            self.borderLayer.frame = self.bounds;
            self.borderLayer.path = maskPath.CGPath;
            [self.layer addSublayer:self.borderLayer];
        }
    }
    
    
//    if(self.shadowborderLayer == nil){
//        self.shadowborderLayer = [CAShapeLayer layer];
//        self.borderLayer.frame = self.bounds;
//        self.borderLayer.path = maskPath.CGPath;
//        if (@available(iOS 13.0, *)) {
//            self.layer.shadowColor = [[UIColor orangeColor] resolvedColorWithTraitCollection:self.traitCollection].CGColor;
//        } else {
//            self.layer.shadowColor = [UIColor orangeColor].CGColor;
//        }
//        self.layer.shadowOffset = CGSizeMake(4, 4);
//        self.layer.shadowOpacity = 4;
//        self.layer.shadowRadius = 4;
//        [self.layer addSublayer:self.borderLayer];
//    }
}
#pragma mark - getter && setter
#pragma mark - radisu
- (void)setGx_clipType:(CGXRoundedClipType)gx_clipType
{
    if(self.gx_clipType == gx_clipType){
        // 数值相同不需要修改
        return;
    }
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(gx_clipType), @(gx_clipType), OBJC_ASSOCIATION_RETAIN);
    self.needUpdateRadius = YES;
}
- (CGXRoundedClipType)gx_clipType
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}

- (void)setGx_clipRadius:(CGFloat)gx_clipRadius
{
    if(self.gx_clipRadius == gx_clipRadius){
        // 数值相同，不需要修改内如
        return;
    }
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(gx_clipRadius), @(gx_clipRadius), OBJC_ASSOCIATION_RETAIN);
    self.needUpdateRadius = YES;
}
- (CGFloat)gx_clipRadius
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
#pragma mark - border
- (void)setGx_borderColor:(UIColor *)gx_borderColor
{
    if(self.gx_borderColor == gx_borderColor){
        // 数值相同不需要修改
        return;
    }
    objc_setAssociatedObject(self, @selector(gx_borderColor), gx_borderColor, OBJC_ASSOCIATION_RETAIN);
    self.needUpdateRadius = YES;
}
- (UIColor *)gx_borderColor
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setGx_borderWidth:(CGFloat)gx_borderWidth
{
    if(self.gx_borderWidth == gx_borderWidth){
        // 数值相同不需要修改
        return;
    }
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(gx_borderWidth), @(gx_borderWidth), OBJC_ASSOCIATION_RETAIN);
    self.needUpdateRadius = YES;
}
- (CGFloat)gx_borderWidth
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
- (void)setBorderLayer:(CAShapeLayer *)borderLayer
{
    objc_setAssociatedObject(self, @selector(borderLayer), borderLayer, OBJC_ASSOCIATION_RETAIN);
}
- (CAShapeLayer *)borderLayer
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setShadowborderLayer:(CAShapeLayer *)shadowborderLayer
{
    objc_setAssociatedObject(self, @selector(shadowborderLayer), shadowborderLayer, OBJC_ASSOCIATION_RETAIN);
}
- (CAShapeLayer *)shadowborderLayer
{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark -
- (BOOL)needUpdateRadius
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNeedUpdateRadius:(BOOL)needUpdateRadius
{
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(needUpdateRadius), @(needUpdateRadius), OBJC_ASSOCIATION_RETAIN);
}
- (void)setOldBounds:(CGRect)oldBounds
{
    // 以get方法名为key
    objc_setAssociatedObject(self, @selector(oldBounds), [NSValue valueWithCGRect:oldBounds], OBJC_ASSOCIATION_RETAIN);
}
- (CGRect)oldBounds
{
    // 以get方面为key
    return [objc_getAssociatedObject(self, _cmd) CGRectValue];
}
- (void)setMaskLayer:(CAShapeLayer *)maskLayer
{
    objc_setAssociatedObject(self, @selector(maskLayer), maskLayer, OBJC_ASSOCIATION_RETAIN);
}
- (CAShapeLayer *)maskLayer
{
    return objc_getAssociatedObject(self, _cmd);
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
    self.gx_clipRadius = radius;
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
}

@end
