//
//  UIView+CGXAnimation.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CGXViewAnimationType)
{
    CGXViewAnimationTypeOpen,// 动画开启
    CGXViewAnimationTypeClose// 动画关闭
};
float gx_radiansForDegrees(int degrees);

@interface UIView (CGXAnimation)

#pragma mark - 动画相关
/**
 *  在某个点添加动画
 *  @param point 动画开始的点
 */
- (void)gx_addAnimationAtPoint:(CGPoint)point;

/**
 *  在某个点添加动画
 *  @param point 动画开始的点
 *  @param type  动画的类型
 *  @param animationColor 动画的颜色
 */
- (void)gx_addAnimationAtPoint:(CGPoint)point WithType:(CGXViewAnimationType)type withColor:(UIColor *)animationColor;

/**
 *  在某个点添加动画
 *  @param point 动画开始的点
 *  @param type  动画的类型
 *  @param animationColor 动画的颜色
 *  @param completion 动画结束后的代码快
 */
- (void)gx_addAnimationAtPoint:(CGPoint)point WithType:(CGXViewAnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion;

/**
 *  在某个点添加动画
 *  @param point      动画开始的点
 *  @param duration   动画时间
 *  @param type       动画的类型
 *  @param animationColor 动画的颜色
 *  @param completion 动画结束后的代码快
 */
- (void)gx_addAnimationAtPoint:(CGPoint)point WithDuration:(NSTimeInterval)duration WithType:(CGXViewAnimationType) type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion;

// Moves
- (void)gx_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)gx_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)gx_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)gx_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)gx_rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)gx_scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)gx_spinClockwise:(float)secs;
- (void)gx_spinCounterClockwise:(float)secs;

// Transitions
- (void)gx_curlDown:(float)secs;
- (void)gx_curlUpAndAway:(float)secs;
- (void)gx_drainAway:(float)secs;

// Effects
- (void)gx_changeAlpha:(float)newAlpha secs:(float)secs;
- (void)gx_pulse:(float)secs continuously:(BOOL)continuously;

//add subview
- (void)gx_addSubviewWithFadeAnimation:(UIView *)subview;

@end
