//
//  UINavigationBar+CGXAwesome.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UINavigationBar+CGXAwesome.h"
#import <objc/runtime.h>

static char CGXDefaultStatusBarStyleKey;

@implementation UINavigationBar (CGXAwesome)
static char gx_overlayKey;

- (UIView *)gx_overlay
{
    return objc_getAssociatedObject(self, &gx_overlayKey);
}

- (void)setGx_overlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &gx_overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)gx_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.gx_overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.gx_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.gx_overlay.userInteractionEnabled = NO;
        self.gx_overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.gx_overlay atIndex:0];
    }
    self.gx_overlay.backgroundColor = backgroundColor;
}

- (void)gx_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)gx_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)gx_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.gx_overlay removeFromSuperview];
    self.gx_overlay = nil;
}


+ (void)gx_setDefaultStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    objc_setAssociatedObject(self, &CGXDefaultStatusBarStyleKey, @(statusBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)gx_DefaultStatusBarStyle {
    id style = objc_getAssociatedObject(self, &CGXDefaultStatusBarStyleKey);
    return style ? [style integerValue] : UIStatusBarStyleDefault;
}

@end
