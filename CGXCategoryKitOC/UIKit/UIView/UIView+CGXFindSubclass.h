//
//  UIView+CGXFindSubclass.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGXFindSubclass)

// 查找子视图
/// @param view      要查找的视图
// @param clazzName 子控件类名
/// @return 找到的第一个子视图
+ (UIView *)gx_find_firstInView:(UIView *)view clazzName:(NSString *)clazzName;
/**
 *  @brief  寻找子视图
 *  @param recurse 回调
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)gx_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;

-(void)gx_runBlockOnAllSubviews:(void (^)(UIView* view))block;

-(void)gx_runBlockOnAllSuperviews:(void (^)(UIView* superview))block;

/**
 *  @brief  启用视图的所有方法
 */
-(void)gx_enableAllControlsInViewHierarchy;
/**
 *  @brief  取消视图的所有方法
 */
-(void)gx_disableAllControlsInViewHierarchy;

/**
 *  @brief  找到指定类名的SubVie对象
 *  @param clazz SubVie类名
 *  @return view对象
 */
- (id)gx_findSubViewWithSubViewClass:(Class)clazz;
/**
 *  @brief  找到指定类名的SuperView对象
 *  @param clazz SuperView类名
 *  @return view对象
 */
- (id)gx_findSuperViewWithSuperViewClass:(Class)clazz;

/**
 *  @brief  找到并且resign第一响应者
 *  @return 结果
 */
- (BOOL)gx_findAndResignFirstResponder;
/**
 *  @brief  找到第一响应者
 *  @return 第一响应者
 */
- (UIView *)gx_findFirstResponder;

/** 所有子View */
- (NSArray *)gx_allSubviews;

/** 移除所有子视图 */
- (void)gx_removeAllSubviews;

@end

NS_ASSUME_NONNULL_END
