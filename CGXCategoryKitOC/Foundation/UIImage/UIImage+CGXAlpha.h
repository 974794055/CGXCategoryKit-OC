// UIImage+CGXAlpha.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (CGXAlpha)
/**
 *  @brief  是否有alpha通道
 *
 *  @return 是否有alpha通道
 */
- (BOOL)gx_hasAlpha;
/**
 *  @brief  如果没有alpha通道 增加alpha通道
 *
 *  @return 如果没有alpha通道 增加alpha通道
 */
- (UIImage *)gx_imageWithAlpha;
/**
 *  @brief  增加透明边框
 *
 *  @param borderSize 边框尺寸
 *
 *  @return 增加透明边框后的图片
 */
- (UIImage *)gx_transparentBorderImage:(NSUInteger)borderSize;
/**
 *  @brief  裁切含透明图片为最小大小
 *
 *  @return 裁切后的图片
 */
- (UIImage *)gx_trimmedBetterSize;

/**
 透明图片

 @param alpha 透明度
 @return 透明图片
 */
- (UIImage *)gx_imageWithAlpha:(CGFloat)alpha;

@end
