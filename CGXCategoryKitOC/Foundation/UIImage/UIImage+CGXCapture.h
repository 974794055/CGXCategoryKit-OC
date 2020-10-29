//
//  UIImage+CGXCapture.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CGXCapture)

/**
 *  截屏
 *  @return 返回截屏的图片
 */
+ (UIImage *)gx_screenShot;
/**
 *  @brief  截图指定view成图片
 *  @param view 一个view
 *  @return 图片
 */
+ (UIImage *)gx_captureWithView:(UIView *)view;

+ (UIImage *)gx_capImageWithSize:(CGRect)myImageRect FromImage:(UIImage *)bigImage;

/**
 *  @author Jakey
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *  @param aView    指定的view
 *  @param maxWidth 宽的大小 0为view默认大小
 *  @return 截图
 */
+ (UIImage *)gx_screenshotWithView:(UIView *)aView limitWidth:(CGFloat)maxWidth;
@end
