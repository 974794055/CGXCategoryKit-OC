//
//  UIView+CGXRoundedCorners.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS (NSUInteger, CGXRoundedClipType) {
    CGXRoundedClipTypeNone = 0,  // 不切
    CGXRoundedClipTypeTopLeft     = UIRectCornerTopLeft, // 左上角
    CGXRoundedClipTypeTopRight    = UIRectCornerTopRight, // 右上角
    CGXRoundedClipTypeBottomLeft  = UIRectCornerBottomLeft, // 左下角
    CGXRoundedClipTypeBottomRight = UIRectCornerBottomRight, // 右下角
    CGXRoundedClipTypeAll  = UIRectCornerAllCorners,// 全部四个角
};
@interface UIView (CGXRoundedCorners)

@property(nonatomic, assign) CGXRoundedClipType gx_clipType;
/**
 *    默认为0.0，当小于0时，不会添加边框，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat gx_borderWidth;
/**
 *    边框线的颜色，默认为[UIColor lightGrayColor]，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor * _Nonnull gx_borderColor;
/**
 *    边框线的颜色，默认为0，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat gx_cornerRadius;

@property (nonatomic, strong) UIColor * _Nonnull gx_backgroundColor;

/**
 四角圆角
 @param radius 圆角角度
 */
- (void)gx_roundedCornerWithAllRadius:(CGFloat)radius;
/**
 上面两个圆角
 @param radius 圆角角度
 */
- (void)gx_roundedCornerWithTopRadius:(CGFloat)radius;
/**
 下面两个圆角
 @param radius 圆角角度
 */
- (void)gx_roundedCornerWithBottomRadius:(CGFloat)radius;
/**
 左面两个圆角
 @param radius 圆角角度
 */
- (void)gx_roundedCornerWithLeftRadius:(CGFloat)radius;
/**
 右面两个圆角
 @param radius 圆角角度
 */
- (void)gx_roundedCornerWithRightRadius:(CGFloat)radius;
/**
 便捷添加圆角
 @param clipType 圆角类型
 @param radius 圆角角度
 */
- (void)gx_roundedCornerWithRadius:(CGFloat)radius clipWithType:(CGXRoundedClipType)clipType;
/**
 便捷给添加border
 @param color 边框的颜色
 @param borderWidth 边框的宽度
 */
- (void)gx_BorderWithColor:(UIColor *_Nonnull)color borderWidth:(CGFloat)borderWidth;


- (void)gx_cornerRadius:(CGFloat)cornerRadius;

- (void)gx_cornerRadius:(CGFloat)cornerRadius
           clipWithType:(CGXRoundedClipType)clipType;

- (void)gx_cornerRadius:(CGFloat)cornerRadius
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor;

- (void)gx_cornerRadius:(CGFloat)cornerRadius
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor
           clipWithType:(CGXRoundedClipType)clipType;
/**
 *  给控件本身添加圆角，不是通过图片实现的。
 *    @param clipType          添加哪些圆角
 *    @param cornerRadius    圆角大小
 *    @param borderWidth     边框大小
 *    @param borderColor     边框宽度
 *    @param backgroundColor 控件的背景色与剪裁后的背景色是一样的时候，若需要指定为不一样，传此参数。
 *                         若没有传此参数，默认取最顶层父视图的背景色，若为透明，则取本身背景色，若也为透明，则取白色
 */
- (void)gx_cornerRadius:(CGFloat)cornerRadius
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor
        backgroundColor:(nullable UIColor *)backgroundColor
           clipWithType:(CGXRoundedClipType)clipType;

@end

