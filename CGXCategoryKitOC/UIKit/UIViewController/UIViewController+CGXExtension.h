//
//  UIViewController+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ViewControllerHandlerProtocol <NSObject>

@optional

/** 重写下面的方法以拦截导航栏pop事件，返回 YES 则 pop，NO 则不 pop  默认返回上一页 */
- (BOOL)gx_navigationBarWillReturn;

@end

@interface UIViewController (CGXExtension)<ViewControllerHandlerProtocol>
/** 从导航控制器栈中查找ViewController，没有时返回nil */
- (UIViewController *)gx_findViewController:(NSString *)className;
/** 删除指定的视图控制器 */
- (void)gx_deleteViewController:(NSString *)className complete:(void(^)(void))complete;
/** 跳转到指定的视图控制器 */
- (void)gx_pushViewController:(NSString *)className animated:(BOOL)animated;
/** 跳转到指定的视图控制器，此方法可防止循环跳转 */
- (void)gx_preventCirculationPushViewController:(NSString *)className animated:(BOOL)animated;
/** 返回到指定的视图控制器 */
- (void)gx_popViewController:(NSString *)className animated:(BOOL)animated;
/**
 *  @brief  视图层级
 *  @return 视图层级字符串
 */
-(NSString*)gx_recursiveDescription;

- (BOOL)gx_isVisible;

@end

NS_ASSUME_NONNULL_END
