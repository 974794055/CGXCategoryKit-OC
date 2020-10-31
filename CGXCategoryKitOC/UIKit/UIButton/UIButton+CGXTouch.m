//
//  UIButton+CGXTouch.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UIButton+CGXTouch.h"
#import <objc/runtime.h>

#define CGXTouchdefaultInterval 0  //默认时间间隔

static NSString *const IndicatorViewKey = @"indicatorView";
static NSString *const ButtonTextObjectKey = @"buttonTextObject";

@implementation UIButton (CGXTouch)


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(mySendAction:to:forEvent:);
        Method methodA =   class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{
            method_exchangeImplementations(methodA, methodB);
        }
    });
}
- (NSTimeInterval)gx_timeInterval
{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setGx_timeInterval:(NSTimeInterval)gx_timeInterval
{
    objc_setAssociatedObject(self, @selector(gx_timeInterval), @(gx_timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        if (self.isIgnoreEvent == 0) {
            self.gx_timeInterval =self.gx_timeInterval ==0 ?CGXTouchdefaultInterval:self.gx_timeInterval;
        };
        if (self.isIgnoreEvent) return;
        if (self.gx_timeInterval > 0)
        {
            self.isIgnoreEvent = YES;
            [self performSelector:@selector(setIsIgnoreEvent:) withObject:@(NO) afterDelay:self.gx_timeInterval];
        }
    }
    [self mySendAction:action to:target forEvent:event];
}
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
