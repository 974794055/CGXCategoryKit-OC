//
//  UIView+CGXRounded.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^CGXGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (CGXBlockGesture)<UIGestureRecognizerDelegate>
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)gx_addTapActionWithBlock:(CGXGestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)gx_addLongPressActionWithBlock:(CGXGestureActionBlock)block;
/**
 添加Pan手势
 *  @brief   添加LongPress手势

 *  @param block 代码块
 */
- (void)gx_addPanGestureWithBlock:(CGXGestureActionBlock)block;




@end
