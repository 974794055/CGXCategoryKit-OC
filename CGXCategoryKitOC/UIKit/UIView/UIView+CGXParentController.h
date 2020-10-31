//
//  UIView+CGXParentController.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGXParentController)

#pragma mark --- 通过属性获取

/** 视图所在父控制器 */
@property (nonatomic, strong, readonly) UIViewController *gx_parentViewController;
/** 视图所在导航控制器 */
@property (nonatomic, strong, readonly) UINavigationController *gx_parentNavController;

#pragma mark --- 通过方法获取

/**
 视图所在父控制器

 @return 当前父控制器
 */
- (UIViewController *)gx_parentController;

/**
 视图所在导航控制器

 @return 当前导航控制器
 */
- (UINavigationController *)gx_parentNavigationController;
@end

NS_ASSUME_NONNULL_END
