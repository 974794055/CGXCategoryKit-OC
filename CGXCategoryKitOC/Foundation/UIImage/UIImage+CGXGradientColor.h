//
//  UIImage+CGXGradientColor.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, CGXExtensionGradientType) {
    CGXExtensionGradientTypeTopToBottom      = 0,//从上到小
    CGXExtensionGradientTypeLeftToRight      = 1,//从左到右
    CGXExtensionGradientTypeUpleftToLowright = 2,//左上到右下
    CGXExtensionGradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (CGXGradientColor)

/**
 通过渐变色生成图片
 
 @param colors 渐变颜色数组
 @param gradientType 渐变类型
 @param imageSize 需要的图片尺寸
 
 */
+ (UIImage *)gx_imageFromGradientColors:(NSArray *)colors gradientType:(CGXExtensionGradientType)gradientType imageSize:(CGSize)imageSize;
@end

NS_ASSUME_NONNULL_END
