//
//  UIImage+CGXFileName.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CGXFileName)
/**
 *  @brief  根据main bundle中的文件名读取图片
 *
 *  @param name 图片名
 *
 *  @return 无缓存的图片
 */
+ (UIImage *)gx_imageWithFileName:(NSString *)name;
/**
 *
 *  根据指定bundle中的文件名读取图片
 *
 *  @param name   图片名
 *  @param bundle bundle
 *
 *  @return 无缓存的图片
 */
+ (UIImage *)gx_imageWithFileName:(NSString *)name inBundle:(NSBundle*)bundle;
@end
