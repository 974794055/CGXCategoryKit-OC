//
//  UINavigationBar+CGXAwesome.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (CGXAwesome)
- (void)gx_setBackgroundColor:(UIColor *)backgroundColor;
- (void)gx_setElementsAlpha:(CGFloat)alpha;
- (void)gx_setTranslationY:(CGFloat)translationY;
- (void)gx_reset;

/**
 在AppDelegate配置全局样式
 
 @param statusBarStyle 状态栏样式
 */
+ (void)gx_setDefaultStatusBarStyle:(UIStatusBarStyle)statusBarStyle;

@end
