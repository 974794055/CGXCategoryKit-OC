//
//  UIView+CGXCategoryGesture.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXCategoryGesture.h"
#import <objc/runtime.h>

typedef void(^CGXGestureRecognizerBlock)(UIView *gestureView, UIGestureRecognizer *gesture);

typedef NS_ENUM(NSUInteger, CGXGestureType) {
    CGXGestureTypeTap,       // 点击
    CGXGestureTypeDouble,    // 双击
    CGXGestureTypeLongPress, // 长按
    CGXGestureTypeSwipe,     // 轻扫
    CGXGestureTypePan,       // 移动
    CGXGestureTypeRotate,    // 旋转
    CGXGestureTypePinch,     // 缩放
};

@implementation UIView (CGXCategoryGesture)
static NSString * const _Nonnull CGXGestureTypeStringMap[] = {
    [CGXGestureTypeTap]       = @"UITapGestureRecognizer",
    [CGXGestureTypeDouble]    = @"UITapGestureRecognizer",
    [CGXGestureTypeLongPress] = @"UILongPressGestureRecognizer",
    [CGXGestureTypeSwipe]     = @"UISwipeGestureRecognizer",
    [CGXGestureTypePan]       = @"UIPanGestureRecognizer",
    [CGXGestureTypeRotate]    = @"UIRotationGestureRecognizer",
    [CGXGestureTypePinch]     = @"UIPinchGestureRecognizer",
};

/// 单击手势
- (UITapGestureRecognizer*)gx_AddTapGestureRecognizerBlock:(CGXGestureTapBlock)block{
    UIGestureRecognizer *gest = [self gx_AddGestureRecognizer:CGXGestureTypeTap block:^(UIView *gestureView, UIGestureRecognizer *gesture) {
        if (block) {
            block(gestureView,(UITapGestureRecognizer *)gesture);
        }
    }];
    return (UITapGestureRecognizer *)gest;
}

/// 双击手势
- (UITapGestureRecognizer*)gx_AddDoubleGestureRecognizerBlock:(CGXGestureLongDoubleBlock)block
{
    UIGestureRecognizer *gest = [self gx_AddGestureRecognizer:CGXGestureTypeDouble block:^(UIView *gestureView, UIGestureRecognizer *gesture) {
        if (block) {
            block(gestureView,(UITapGestureRecognizer *)gesture);
        }
    }];
    return (UITapGestureRecognizer *)gest;
}
/// 长按手势
- (UILongPressGestureRecognizer*)gx_AddLongPressGestureRecognizerBlock:(CGXGestureLongPressBlock)block
{
    UIGestureRecognizer *gest = [self gx_AddGestureRecognizer:CGXGestureTypeLongPress block:^(UIView *gestureView, UIGestureRecognizer *gesture) {
        if (block) {
            block(gestureView,(UILongPressGestureRecognizer *)gesture);
        }
    }];
    return (UILongPressGestureRecognizer *)gest;
}
/// 轻扫手势
- (UISwipeGestureRecognizer*)gx_AddSwipeGestureRecognizerBlock:(CGXGestureSwipeBlock)block
{
    UIGestureRecognizer *gest = [self gx_AddGestureRecognizer:CGXGestureTypeSwipe block:^(UIView *gestureView, UIGestureRecognizer *gesture) {
        if (block) {
            block(gestureView,(UISwipeGestureRecognizer *)gesture);
        }
    }];
    return (UISwipeGestureRecognizer *)gest;
}
/// 移动手势
- (UIPanGestureRecognizer*)gx_AddPanGestureRecognizerBlock:(CGXGesturePanBlock)block
{
    UIGestureRecognizer *gest = [self gx_AddGestureRecognizer:CGXGestureTypePan block:^(UIView *gestureView, UIGestureRecognizer *gesture) {
        if (block) {
            block(gestureView,(UIPanGestureRecognizer *)gesture);
        }
    }];
    return (UIPanGestureRecognizer *)gest;
}
/// 旋转手势
- (UIRotationGestureRecognizer*)gx_AddRotateGestureRecognizerBlock:(CGXGestureRotateBlock)block
{
    UIGestureRecognizer *gest = [self gx_AddGestureRecognizer:CGXGestureTypeRotate block:^(UIView *gestureView, UIGestureRecognizer *gesture) {
        if (block) {
            block(gestureView,(UIRotationGestureRecognizer *)gesture);
        }
    }];
    return (UIRotationGestureRecognizer *)gest;
}
/// 缩放手势
- (UIPinchGestureRecognizer*)gx_AddPinchGestureRecognizerBlock:(CGXGesturePinchBlock)block
{
    UIGestureRecognizer *gest = [self gx_AddGestureRecognizer:CGXGestureTypePinch block:^(UIView *gestureView, UIGestureRecognizer *gesture) {
        if (block) {
            block(gestureView,(UIPinchGestureRecognizer *)gesture);
        }
    }];
    return (UIPinchGestureRecognizer *)gest;
}

- (UIGestureRecognizer*)gx_AddGestureRecognizer:(CGXGestureType)type block:(CGXGestureRecognizerBlock)block{
    self.userInteractionEnabled = YES;
    if (block) {
        NSString *string = CGXGestureTypeStringMap[type];
        UIGestureRecognizer *gesture = [[NSClassFromString(string) alloc] initWithTarget:self action:@selector(kGestureAction:)];
        [gesture setDelaysTouchesBegan:YES];
        [self addGestureRecognizer:gesture];
        if (type == CGXGestureTypeTap) {
            [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer *recognizer, NSUInteger idx, BOOL *stop) {
                if ([recognizer isKindOfClass:[UITapGestureRecognizer class]] && ((UITapGestureRecognizer*)recognizer).numberOfTapsRequired == 2) {
                    [gesture requireGestureRecognizerToFail:recognizer];
                    *stop = YES;
                }
            }];
            string = [string stringByAppendingString:@"Tap"];
        }else if (type == CGXGestureTypeDouble) {
            [(UITapGestureRecognizer*)gesture setNumberOfTapsRequired:2];
            [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer *recognizer, NSUInteger idx, BOOL *stop) {
                if ([recognizer isKindOfClass:[UITapGestureRecognizer class]] && ((UITapGestureRecognizer*)recognizer).numberOfTapsRequired == 1) {
                    [recognizer requireGestureRecognizerToFail:gesture];
                    *stop = YES;
                }
            }];
            string = [string stringByAppendingString:@"Double"];
        }
        self.selectorString = string;
        self.gesrureblock = block;
        return gesture;
    }
    return nil;
}

- (void)kGestureAction:(UIGestureRecognizer*)gesture{
    NSString *string = NSStringFromClass([gesture class]);
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        if (((UITapGestureRecognizer*)gesture).numberOfTapsRequired == 1) {
            string = [string stringByAppendingString:@"Tap"];
        }else {
            string = [string stringByAppendingString:@"Double"];
        }
    }
    self.selectorString = string;
    self.gesrureblock(gesture.view, gesture);
}

#pragma mark - associated
- (NSString *)selectorString{
    return objc_getAssociatedObject(self, @selector(selectorString));
}
- (void)setSelectorString:(NSString *)selectorString{
    objc_setAssociatedObject(self, @selector(selectorString), selectorString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGXGestureRecognizerBlock)gesrureblock{
    return (CGXGestureRecognizerBlock)objc_getAssociatedObject(self, NSSelectorFromString(self.selectorString));
}
- (void)setGesrureblock:(CGXGestureRecognizerBlock)gesrureblock{
    objc_setAssociatedObject(self, NSSelectorFromString(self.selectorString), gesrureblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
