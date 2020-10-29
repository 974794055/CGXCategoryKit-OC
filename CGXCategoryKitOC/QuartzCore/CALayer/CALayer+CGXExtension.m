//
//  CALayer+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CALayer+CGXExtension.h"

@implementation CALayer (CGXExtension)

-(void)gx_shake{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat shakeWidth = 16;
    keyAnimation.values = @[@(-shakeWidth),@(0),@(shakeWidth),@(0),@(-shakeWidth),@(0),@(shakeWidth),@(0)];
    //时长
    keyAnimation.duration = .1f;
    //重复
    keyAnimation.repeatCount =2;
    //移除
    keyAnimation.removedOnCompletion = YES;
    [self addAnimation:keyAnimation forKey:@"shake"];
}
-(void)setGx_borderColor:(UIColor *)gx_borderColor{
    self.borderColor = gx_borderColor.CGColor;
}

- (UIColor*)gx_borderColor {
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
