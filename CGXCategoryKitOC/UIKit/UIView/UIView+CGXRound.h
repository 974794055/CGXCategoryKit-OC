//
//  UIView+CGXRound.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGXRound)

/**
 *    默认为0.0，当小于0时，不会添加边框，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat gx_borderWidth;
/**
 *    边框线的颜色，默认为[UIColor lightGrayColor]，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *gx_borderColor;
/**
 *    边框线的颜色，默认为0，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat gx_cornerRadius;

@property (nonatomic, strong) UIColor *gx_backgroundColor;


- (void)gx_cornerRadius:(CGFloat)cornerRadius;

- (void)gx_cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corner;

- (void)gx_cornerRadius:(CGFloat)cornerRadius
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor;

- (void)gx_cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corner
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor;
/**
 *  给控件本身添加圆角，不是通过图片实现的。
 *    @param corner          添加哪些圆角
 *    @param cornerRadius    圆角大小
 *    @param borderWidth     边框大小
 *    @param borderColor     边框宽度
 *    @param backgroundColor 控件的背景色与剪裁后的背景色是一样的时候，若需要指定为不一样，传此参数。
 *                         若没有传此参数，默认取最顶层父视图的背景色，若为透明，则取本身背景色，若也为透明，则取白色
 */
- (void)gx_cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corner
            borderWidth:(CGFloat)borderWidth
            borderColor:(nullable UIColor *)borderColor
        backgroundColor:(nullable UIColor *)backgroundColor;


@end

NS_ASSUME_NONNULL_END
