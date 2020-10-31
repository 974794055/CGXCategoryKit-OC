//
//  UITextField+CGXShake.h
//  CGXAppStructure
//
//  Created by CGX on 2018/12/14.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

/** @enum ShakeDirection
 *
 * Enum that specifies the direction of the shake
 */
typedef NS_ENUM(NSInteger, CGXShakeDirection) {
    /** Shake left and right */
    CGXShakeDirectionHorizontal,
    /** Shake up and down */
    CGXShakeDirectionVertical
};

/**
 * @name UITextField+Shake
 * A UITextField category that add the ability to shake the component
 */
@interface UITextField (CGXShake)

/** Shake the UITextField
 *
 * Shake the text field with default values
 */
- (void)gx_shake;

/** Shake the UITextField
 *
 * Shake the text field a given number of times
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 */
- (void)gx_shake:(int)times withDelta:(CGFloat)delta;

/** Shake the UITextField
 *
 * Shake the text field a given number of times
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)gx_shake:(int)times withDelta:(CGFloat)delta completion:(nullable void (^)(void))handler;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 */
- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(nullable void (^)(void))handler;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param shakeDirection of the shake
 */
- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(CGXShakeDirection)shakeDirection;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param shakeDirection of the shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(CGXShakeDirection)shakeDirection completion:(nullable void (^)(void))handler;

@end
