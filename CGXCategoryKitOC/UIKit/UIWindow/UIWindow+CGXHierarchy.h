//
//  UIWindow+CGXHierarchy.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (CGXHierarchy)
/*!
 @method topMostController
 
 @return Returns the current Top Most ViewController in hierarchy.
 */
- (UIViewController*)gx_topMostController;

/*!
 @method currentViewController
 
 @return Returns the topViewController in stack of topMostController.
 */
- (UIViewController*)gx_currentViewController;


/// 获取主窗体
+ (UIWindow *)gx_getCurrentWindow;

/// 导航栈的栈顶视图控制器
+ (UIViewController *)gx_topViewController;

/// 获取当前显示的控制器
+ (UIViewController *)gx_visibleViewController;

/*
 visibleViewController和哪个导航栈没有关系，只是当前显示的控制器，也就是说任意一个导航的visibleViewController所返回的值应该是一样的,
 但是topViewController 就是某个导航栈的栈顶视图，和导航相关
 换句话说如果在仅有一个导航栈上，visibleViewController和topViewController应该是没有区别得。
 */

@end
