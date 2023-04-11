//
//  UIDevice+CGXAddition.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (CGXAddition)
+ (CGFloat)gx_safeDistanceTop;
 
// 底部安全区高度
+ (CGFloat)gx_safeDistanceBottom;
 
//顶部状态栏高度（包括安全区）
+ (CGFloat)gx_statusBarHeight;
// 导航栏高度
+ (CGFloat)gx_navigationBarHeight;
// 状态栏+导航栏的高度
+ (CGFloat)gx_navigationFullHeight;
 
// 底部导航栏高度
+ (CGFloat)gx_tabBarHeight;
 
// 底部导航栏高度（包括安全区）
+ (CGFloat)gx_tabBarFullHeight;

+ (BOOL)gx_IsIphoneX;

@end

NS_ASSUME_NONNULL_END
