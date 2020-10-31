//
//  UIViewController+CGXViewController.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (CGXViewController)

//找到当前视图控制器
+ (UIViewController *)gx_currentViewController;

//找到当前导航控制器
+ (UINavigationController *)gx_currentNavigatonController;

/**
 * 在当前视图控制器中添加子控制器，将子控制器的视图添加到 view 中
 *
 * @param childController 要添加的子控制器
 * @param view            要添加到的视图
 */
- (void)gx_addChildController:(UIViewController *)childController intoView:(UIView *)view;

/**
 *  状态栏是否显示背景色
 *
 *  @param show yes为显示背景色，否则为透明
 */
- (void)gx_navigationBarBackgroundShow:(BOOL)show;
@end
