//
//  UIImage+CGXMerge.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CGXMerge)
/**
 *  @brief  合并两个图片
 *
 *  @param firstImage  一个图片
 *  @param secondImage 二个图片
 *
 *  @return 合并后图片
 */
+ (UIImage*)gx_mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;

/**
 镶嵌图片
 
 @param firstImage 图片1
 @param secondImage 图片2
 @return 拼接后的图片
 */
+ (UIImage *)gx_spliceFirstImage:(UIImage *)firstImage secondImage:(UIImage *)secondImage;

/**
 *  给图片添加水印
 *
 *  @param bgName         云图的名字
 *  @param waterImageName 水印的名字
 *
 *  @return 添加完水印的图片
 */
+ (UIImage *)gx_waterImageWithName:(NSString *)bgName WaterImageName:(NSString *)waterImageName;

@end
