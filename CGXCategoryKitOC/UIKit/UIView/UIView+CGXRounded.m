//
//  UIView+CGXRounded.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXRounded.h"
#import <objc/runtime.h>

@implementation NSObject (CGXRounded)

+ (void)gx_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)gx_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)gx_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)gx_removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIImage (CGXRounded)

+ (UIImage *)gx_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)gx_maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    return [UIImage gx_imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}

@end



static void *const _GXMaskCornerRadiusLayerKey = "_GXMaskCornerRadiusLayerKey";

static void *const _gx_cornerRadiusImageColor = "_gx_cornerRadiusImageColor";
static void *const _gx_cornerRadiusImageRadius = "_gx_cornerRadiusImageRadius";
static void *const _gx_cornerRadiusImageCorners = "_gx_cornerRadiusImageCorners";
static void *const _gx_cornerRadiusImageBorderColor = "_gx_cornerRadiusImageBorderColor";
static void *const _gx_cornerRadiusImageBorderWidth = "_gx_cornerRadiusImageBorderWidth";
static void *const _gx_cornerRadiusImageSize = "_gx_cornerRadiusImageSize";

static NSMutableSet<UIImage *> *maskCornerRaidusImageSet;

@implementation CALayer (CGXRounded)

+ (void)load{
    [CALayer gx_swizzleInstanceMethod:@selector(layoutSublayers) with:@selector(gx_RoundedlayoutSublayers)];
}

- (UIImage *)gx_contentImage{
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.contents];
}

- (void)setGx_contentImage:(UIImage *)gx_contentImage{
    self.contents = (__bridge id)gx_contentImage.CGImage;
}

- (void)gx_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color {
    
    [self gx_cornerRadius:radius cornerColor:color corners:UIRectCornerAllCorners];
}

- (void)gx_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners {
    
    [self gx_cornerRadius:CGSizeMake(radius, radius) cornerColor:color corners:corners borderColor:nil borderWidth:0];
}

- (void)gx_cornerRadius:(CGSize)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if (!color){
        return;
    }
    CALayer *cornerRadiusLayer = [self gx_getAssociatedValueForKey:_GXMaskCornerRadiusLayerKey];
    if (!cornerRadiusLayer) {
        cornerRadiusLayer = [CALayer new];
        cornerRadiusLayer.opaque = YES;
        [self gx_setAssociateValue:cornerRadiusLayer withKey:_GXMaskCornerRadiusLayerKey];
    }
    if (color) {
        [cornerRadiusLayer gx_setAssociateValue:color withKey:_gx_cornerRadiusImageColor];
    }else{
        [cornerRadiusLayer gx_removeAssociateWithKey:_gx_cornerRadiusImageColor];
    }
    [cornerRadiusLayer gx_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:_gx_cornerRadiusImageRadius];
    [cornerRadiusLayer gx_setAssociateValue:@(corners) withKey:_gx_cornerRadiusImageCorners];
    if (borderColor) {
        [cornerRadiusLayer gx_setAssociateValue:borderColor withKey:_gx_cornerRadiusImageBorderColor];
    }else{
        [cornerRadiusLayer gx_removeAssociateWithKey:_gx_cornerRadiusImageBorderColor];
    }
    [cornerRadiusLayer gx_setAssociateValue:@(borderWidth) withKey:_gx_cornerRadiusImageBorderWidth];
    UIImage *image = [self gx_getCornerRadiusImageFromSet];
    if (image) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.gx_contentImage = image;
        [CATransaction commit];
    }
    
}

- (UIImage *)gx_getCornerRadiusImageFromSet{
    if (!self.bounds.size.width || !self.bounds.size.height) return nil;
    CALayer *cornerRadiusLayer = [self gx_getAssociatedValueForKey:_GXMaskCornerRadiusLayerKey];
    UIColor *color = [cornerRadiusLayer gx_getAssociatedValueForKey:_gx_cornerRadiusImageColor];
    if (!color) return nil;
    CGSize radius = [[cornerRadiusLayer gx_getAssociatedValueForKey:_gx_cornerRadiusImageRadius] CGSizeValue];
    NSUInteger corners = [[cornerRadiusLayer gx_getAssociatedValueForKey:_gx_cornerRadiusImageCorners] unsignedIntegerValue];
    CGFloat borderWidth = [[cornerRadiusLayer gx_getAssociatedValueForKey:_gx_cornerRadiusImageBorderWidth] floatValue];
    UIColor *borderColor = [cornerRadiusLayer gx_getAssociatedValueForKey:_gx_cornerRadiusImageBorderColor];
    if (!maskCornerRaidusImageSet) {
        maskCornerRaidusImageSet = [NSMutableSet new];
    }
    __block UIImage *image = nil;
    [maskCornerRaidusImageSet enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        CGSize imageSize = [[obj gx_getAssociatedValueForKey:_gx_cornerRadiusImageSize] CGSizeValue];
        UIColor *imageColor = [obj gx_getAssociatedValueForKey:_gx_cornerRadiusImageColor];
        CGSize imageRadius = [[obj gx_getAssociatedValueForKey:_gx_cornerRadiusImageRadius] CGSizeValue];
        NSUInteger imageCorners = [[obj gx_getAssociatedValueForKey:_gx_cornerRadiusImageCorners] unsignedIntegerValue];
        CGFloat imageBorderWidth = [[obj gx_getAssociatedValueForKey:_gx_cornerRadiusImageBorderWidth] floatValue];
        UIColor *imageBorderColor = [obj gx_getAssociatedValueForKey:_gx_cornerRadiusImageBorderColor];
        BOOL isBorderSame = (CGColorEqualToColor(borderColor.CGColor, imageBorderColor.CGColor) && borderWidth == imageBorderWidth) || (!borderColor && !imageBorderColor) || (!borderWidth && !imageBorderWidth);
        BOOL canReuse = CGSizeEqualToSize(self.bounds.size, imageSize) && CGColorEqualToColor(imageColor.CGColor, color.CGColor) && imageCorners == corners && CGSizeEqualToSize(radius, imageRadius) && isBorderSame;
        if (canReuse) {
            image = obj;
            *stop = YES;
        }
    }];
    if (!image) {
        image = [UIImage gx_maskRoundCornerRadiusImageWithColor:color cornerRadii:radius size:self.bounds.size corners:corners borderColor:borderColor borderWidth:borderWidth];
        [image gx_setAssociateValue:[NSValue valueWithCGSize:self.bounds.size] withKey:_gx_cornerRadiusImageSize];
        [image gx_setAssociateValue:color withKey:_gx_cornerRadiusImageColor];
        [image gx_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:_gx_cornerRadiusImageRadius];
        [image gx_setAssociateValue:@(corners) withKey:_gx_cornerRadiusImageCorners];
        if (borderColor) {
            [image gx_setAssociateValue:color withKey:_gx_cornerRadiusImageBorderColor];
        }
        [image gx_setAssociateValue:@(borderWidth) withKey:_gx_cornerRadiusImageBorderWidth];
        [maskCornerRaidusImageSet addObject:image];
    }
    return image;
}

#pragma mark - exchage Methods

- (void)gx_RoundedlayoutSublayers {
    
    [self gx_RoundedlayoutSublayers];
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    CALayer *cornerRadiusLayer = [self gx_getAssociatedValueForKey:_GXMaskCornerRadiusLayerKey];
    if (cornerRadiusLayer) {
        UIImage *aImage = [self gx_getCornerRadiusImageFromSet];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.gx_contentImage = aImage;
        cornerRadiusLayer.frame = self.bounds;
        [CATransaction commit];
        [self addSublayer:cornerRadiusLayer];
    }
}

@end

@implementation UIView (CGXRounded)


- (void)gx_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color {
    
    [self.layer gx_cornerRadius:radius cornerColor:color];
}

- (void)gx_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners {
    
    [self.layer gx_cornerRadius:radius cornerColor:color corners:corners];
}

- (void)gx_cornerRadius:(CGSize)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    [self.layer gx_cornerRadius:radius cornerColor:color corners:corners borderColor:borderColor borderWidth:borderWidth];
}

@end
