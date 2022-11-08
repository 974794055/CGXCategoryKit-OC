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
 @param color 图片颜色
 @param targetSize 生成尺寸
 @param cornerRadius 圆角大小
 @param backgroundColor 背景颜色
 */
+ (UIImage *)gx_imageWithColor:(UIColor *)color
                    targetSize:(CGSize)targetSize
                       corners:(UIRectCorner)corners
                  cornerRadius:(CGFloat)cornerRadius
               backgroundColor:(UIColor *)backgroundColor;
/**
 绘制图片
 @param color 背景色
 @param size 大小
 @param text 文字
 @param textAttributes 字体设置
 @param isCircular 是否圆形
 @return 图片
 */
+ (UIImage *)gx_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular;

#pragma mark - 根据颜色生成图片
/**
 *    根据颜色生成矩形图片
 *
 *    @param color            待生成的图片颜色
 *    @param targetSize    生成的图片大小
 *
 *    @return 图片对象
 */
+ (UIImage *)gx_imageWithColor:(UIColor *)color
                        toSize:(CGSize)targetSize;

/**
 *    根据颜色生成带圆角的图片。当有圆角时，默认被裁剪的圆角部分的颜色为白色。
 *
 *    @param color                待生成的图片颜色
 *    @param targetSize        生成的图片大小
 *    @param cornerRadius    圆角大小
 *
 *    @return 图片对象
 */
+ (UIImage *)gx_imageWithColor:(UIColor *)color
                        toSize:(CGSize)targetSize
                  cornerRadius:(CGFloat)cornerRadius;

/**
 *    根据颜色生成带圆角的图片
 *
 *    @param color                    待生成的图片颜色
 *    @param targetSize            生成的大小
 *    @param cornerRadius        圆角大小
 *    @param backgroundColor 当有圆角大小时，才需要到此参数。用于设置被裁剪的圆角部分的颜色。
 *
 *    @return 带圆角的图片对象
 */
+ (UIImage *)gx_imageWithColor:(UIColor *)color
                        toSize:(CGSize)targetSize
                  cornerRadius:(CGFloat)cornerRadius
               backgroundColor:(UIColor *)backgroundColor;

/**
 *    根据颜色生成带边框圆角的图片
 *
 *    @param color                    待生成的图片颜色
 *    @param targetSize            生成的大小
 *    @param cornerRadius        圆角大小
 *    @param backgroundColor 当有圆角大小时，才需要到此参数。用于设置被裁剪的圆角部分的颜色。
 *
 *    @return 带圆角的图片对象
 */
+ (UIImage *)gx_imageWithColor:(UIColor *)color
                        toSize:(CGSize)targetSize
                  cornerRadius:(CGFloat)cornerRadius
               backgroundColor:(UIColor *)backgroundColor
                   borderColor:(UIColor *)borderColor
                   borderWidth:(CGFloat)borderWidth;



@end

NS_ASSUME_NONNULL_END
