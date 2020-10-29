//
//  UIView+CGXShake.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXShake.h"

@implementation UIView (CGXShake)

- (void)gx_shake {
    [self gx_shake:10 direction:1 currentTimes:0 withDelta:5 speed:0.03 shakeDirection:CGXViewShakeDirectionHorizontal completion:nil];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta {
    [self gx_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:CGXViewShakeDirectionHorizontal completion:nil];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)(void))handler {
    [self gx_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:CGXViewShakeDirectionHorizontal completion:handler];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self gx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:CGXViewShakeDirectionHorizontal completion:nil];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)(void))handler {
    [self gx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:CGXViewShakeDirectionHorizontal completion:handler];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(CGXViewShakeDirection)shakeDirection {
    [self gx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)gx_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(CGXViewShakeDirection)shakeDirection completion:(void (^)(void))completion {
    [self gx_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:completion];
}

- (void)gx_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(CGXViewShakeDirection)shakeDirection completion:(void (^)(void))completionHandler {
    [UIView animateWithDuration:interval animations:^{
        self.layer.affineTransform = (shakeDirection == CGXViewShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.layer.affineTransform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                if (completionHandler != nil) {
                    completionHandler();
                }
            }];
            return;
        }
        [self gx_shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:completionHandler];
    }];
}

@end
