//
//  UIView+CGXCategoryGesture.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/* 点击 */
typedef void(^CGXGestureTapBlock)(UIView *gestureView, UITapGestureRecognizer *gesture);
/* 双击 */
typedef void(^CGXGestureLongDoubleBlock)(UIView *gestureView, UITapGestureRecognizer *gesture);
/* 长按 */
typedef void(^CGXGestureLongPressBlock)(UIView *gestureView, UILongPressGestureRecognizer *gesture);
/* 轻扫 */
typedef void(^CGXGestureSwipeBlock)(UIView *gestureView, UISwipeGestureRecognizer *gesture);
/* 移动 */
typedef void(^CGXGesturePanBlock)(UIView *gestureView, UIPanGestureRecognizer *gesture);
/* 旋转 */
typedef void(^CGXGestureRotateBlock)(UIView *gestureView, UIRotationGestureRecognizer *gesture);
/* 缩放 */
typedef void(^CGXGesturePinchBlock)(UIView *gestureView, UIPinchGestureRecognizer *gesture);

@interface UIView (CGXCategoryGesture)

/// 单击手势
- (UITapGestureRecognizer*)gx_AddTapGestureRecognizerBlock:(CGXGestureTapBlock)block;
/// 双击手势
- (UITapGestureRecognizer*)gx_AddDoubleGestureRecognizerBlock:(CGXGestureLongDoubleBlock)block;
/// 长按手势
- (UILongPressGestureRecognizer*)gx_AddLongPressGestureRecognizerBlock:(CGXGestureLongPressBlock)block;
/// 轻扫手势
- (UISwipeGestureRecognizer*)gx_AddSwipeGestureRecognizerBlock:(CGXGestureSwipeBlock)block;
/// 移动手势
- (UIPanGestureRecognizer*)gx_AddPanGestureRecognizerBlock:(CGXGesturePanBlock)block;
/// 旋转手势
- (UIRotationGestureRecognizer*)gx_AddRotateGestureRecognizerBlock:(CGXGestureRotateBlock)block;
/// 缩放手势
- (UIPinchGestureRecognizer*)gx_AddPinchGestureRecognizerBlock:(CGXGesturePinchBlock)block;

@end

NS_ASSUME_NONNULL_END

/* 使用示例 */
// [self.view gx_AddTapGestureRecognizerBlock:^(UIView *gestureView, UITapGestureRecognizer *gesture) {
//     [gestureView removeGestureRecognizer:gesture];
// }];
