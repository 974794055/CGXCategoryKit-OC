//
//  UIImage+CGXRadius.h
//  CGXCategoryKit-OC-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CGXRadius)

/** 圆角图片 */
- (UIImage *)gx_imageWithCornerRadius:(CGFloat)radius;

/** 圆角图片 */
- (UIImage*)gx_imageWithCornerRadius:(CGFloat)radius andSize:(CGSize)size;

/** 圆形图片 */
+ (UIImage *)gx_imageWithRoundImage:(UIImage *)image;

/**
 生成带圆角的颜色图片

 @param tintColor 图片颜色
 @param targetSize 生成尺寸
 @param cornerRadius 圆角大小
 @param backgroundColor 背景颜色
 */
+ (UIImage *)gx_cornerRadiusImageWithColor:(UIColor *)tintColor
                                targetSize:(CGSize)targetSize
                                   corners:(UIRectCorner)corners
                              cornerRadius:(CGFloat)cornerRadius
                           backgroundColor:(UIColor *)backgroundColor;

@end

NS_ASSUME_NONNULL_END
