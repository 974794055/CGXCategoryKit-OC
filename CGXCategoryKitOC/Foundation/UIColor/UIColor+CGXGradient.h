//
//  UIColor+CGXGradient.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CGXGradientColorDirection) {
    /// 水平方向渐变
    CGXGradientColorDirectionLevel,
    /// 垂直方向渐变
    CGXGradientColorDirectionVertical,
    /// 主对角线方向渐变
    CGXGradientColorDirectionDiagonalLineUp,
    /// 副对角线方向渐变
    CGXGradientColorDirectionDiagonalLineDown,
};

@interface UIColor (CGXGradient)
/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)gx_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;

/*
 设置渐变颜色
 
 @param size 渐变区域的尺寸
 @param direction 渐变方向
 @param startColor 开始颜色
 @param endColor 结束颜色
 */
+ (UIColor *)gx_colorGradientChangeWithSize:(CGSize)size
                                  direction:(CGXGradientColorDirection)direction
                                 startColor:(UIColor*)startcolor
                                   endColor:(UIColor*)endColor;
@end

NS_ASSUME_NONNULL_END
