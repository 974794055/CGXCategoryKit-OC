//
//  UIScreen+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UIScreen+CGXExtension.h"

@implementation UIScreen (CGXExtension)
+ (CGSize)gx_size
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)gx_width
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)gx_height
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)gx_orientationSize
{
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion]
                             doubleValue];
    BOOL isLand =   UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    return (systemVersion>8.0 && isLand) ? gx_SizeSWAP([UIScreen gx_size]) : [UIScreen gx_size];
}

+ (CGFloat)gx_orientationWidth
{
    return [UIScreen gx_orientationSize].width;
}

+ (CGFloat)gx_orientationHeight
{
    return [UIScreen gx_orientationSize].height;
}

+ (CGSize)gx_DPISize
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}

+ (CGFloat)gx_scale {
    return [self mainScreen].scale;
}
/**
 *  交换高度与宽度
 */
static inline CGSize gx_SizeSWAP(CGSize size) {
    return CGSizeMake(size.height, size.width);
}

@end
