//
//  UITextField+CGXShake.m
//  CGXAppStructure
//
//  Created by CGX on 2018/12/14.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "UITextField+CGXShake.h"

@implementation UITextField (CGXShake)

- (void)gx_shake {
    [self gx_shake:5 withDelta:5 completion:nil];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta {
    [self gx_shake:times withDelta:delta completion:nil];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta completion:(nullable void (^)(void))handler {
    [self gx_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:CGXShakeDirectionHorizontal completion:handler];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self gx_shake:times withDelta:delta speed:interval completion:nil];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(nullable void (^)(void))handler {
    [self gx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:CGXShakeDirectionHorizontal completion:handler];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(CGXShakeDirection)shakeDirection {
    [self gx_shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(CGXShakeDirection)shakeDirection completion:(nullable void (^)(void))handler {
    [self gx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
}

- (void)gx_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(CGXShakeDirection)shakeDirection completion:(nullable void (^)(void))handler {
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == CGXShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        [self gx_shake:times
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:handler];
    }];
}

@end
