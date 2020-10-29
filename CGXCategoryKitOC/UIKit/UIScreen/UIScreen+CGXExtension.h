//
//  UIScreen+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface UIScreen (CGXExtension)

+ (CGSize)gx_size;
+ (CGFloat)gx_width;
+ (CGFloat)gx_height;

+ (CGSize)gx_orientationSize;
+ (CGFloat)gx_orientationWidth;
+ (CGFloat)gx_orientationHeight;
+ (CGSize)gx_DPISize;

/**
 *  主屏幕缩放因子
 *  @return 主屏幕缩放因子
 */
+ (CGFloat)gx_scale;

@end
