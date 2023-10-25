//
//  UIView+CGXRounded.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXBlockGesture.h"
#import <objc/runtime.h>
static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;
static char kActionHandlerPanGestureKey;

@implementation UIView (CGXBlockGesture)
- (void)gx_addTapActionWithBlock:(CGXGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        gesture.delegate = self;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        CGXGestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
- (void)gx_addLongPressActionWithBlock:(CGXGestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        gesture.delegate = self;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        CGXGestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

// 添加Pan手势
- (void)gx_addPanGestureWithBlock:(CGXGestureActionBlock)block
{
    UIPanGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerPanGestureKey);
    if (!gesture)
    {
        gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForPanGesture:)];
        gesture.delegate = self;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerPanGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerPanGestureKey, block, OBJC_ASSOCIATION_COPY);
    
}
- (void)handleActionForPanGesture:(UIPanGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        CGXGestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerPanGestureKey);
        if (block)
        {
            block(gesture);
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    NSLog(@"\n%@\n%@\n%@" , NSStringFromClass([touch.view class]),NSStringFromClass([touch.view.superview class]),NSStringFromClass([touch.view.superview.superview class]));
    if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
    }
    if([NSStringFromClass([touch.view class]) isEqualToString:@"_UITableViewHeaderFooterContentView"]){
        return NO;
    }

    if([touch.view.superview isKindOfClass:[UICollectionViewCell class]]){
        return NO;
    }
    if([touch.view.superview isKindOfClass:[UICollectionReusableView class]]){
        return NO;
    }
    return YES;
}
@end
