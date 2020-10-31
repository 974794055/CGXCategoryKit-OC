//
//  UIImage+CGXColor.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CGXColor)
/**
 *  @brief  根据颜色生成纯色图片
 *  @param color 颜色
 *  @return 纯色图片
 */
+ (UIImage *)gx_imageWithColor:(UIColor *)color;
/**
 *  @brief  取图片某一点的颜色
 *  @param point 某一点
 *  @return 颜色
 */
- (UIColor *)gx_colorAtPoint:(CGPoint )point;
//more accurate method ,colorAtPixel 1x1 pixel
/**
 *  @brief  取某一像素的颜色
 *  @param point 一像素
 *  @return 颜色
 */
- (UIColor *)gx_colorAtPixel:(CGPoint)point;
/**
 *  @brief  获得灰度图
 *  @param sourceImage 图片
 *  @return 获得灰度图片
 */
+ (UIImage*)gx_covertToGrayImageFromImage:(UIImage*)sourceImage;


/**
 带有阴影的图片

 @param color 颜色
 @param offset offset
 @param blur 模糊度，可以先设置个20试试
 @return 带有阴影的图片
 */
- (UIImage *)gx_imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;


-(UIImage *)gx_updateImageWithTintColor:(UIColor*)color;
-(UIImage *)gx_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha;
-(UIImage *)gx_updateImageWithTintColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage *)gx_updateImageWithTintColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage *)gx_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets;
-(UIImage *)gx_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha rect:(CGRect)rect;

@end
