//
//  UIButton+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CGXExtension)

/** 设置按钮左对齐 */
- (void)gx_leftAlignment;
/** 设置按钮中心对齐 */
- (void)gx_centerAlignment;
/** 设置按钮右对齐 */
- (void)gx_rightAlignment;
/** 设置按钮上对齐 */
- (void)gx_topAlignment;
/** 设置按钮下对齐 */
- (void)gx_bottomAlignment;
/**
 * 设置普通状态与高亮状态的文字
 */
- (void)gx_NormaTitle:(NSString *)nTitle H_Title:(NSString *)hTitle;
/**
 * 设置普通状态与高亮状态的背景图片
 */
- (void)gx_NormalBG:(NSString *)nbg H_BG:(NSString *)hbg;
/**
 * 设置普通状态与高亮状态的拉伸后背景图片
 * size 拉伸比例
 */
- (void)gx_NormalBgImage:(NSString *)nbg H_Image:(NSString *)hbg Size:(CGSize)size;;
/**
 * 设置普通状态与高亮状态的文字
 */
- (void)gx_NormalTitleColor:(UIColor *)nColor HColor:(UIColor *)hColor;
/**
 *  @brief  使用颜色设置按钮背景
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)gx_backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
