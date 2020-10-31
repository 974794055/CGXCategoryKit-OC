//
//  UIView+CGXParentController.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXParentController.h"
#import <objc/runtime.h>

@interface UIView ()

/** 视图所在父控制器 */
@property (nonatomic, strong, readwrite) UIViewController *gx_parentViewController;
/** 视图所在导航控制器 */
@property (nonatomic, strong, readwrite) UINavigationController *gx_parentNavController;

@end

@implementation UIView (CGXParentController)

#pragma mark -- 关联 ym_parentViewController getter - setter 方法
- (UIViewController *)gx_parentViewController {
    self.gx_parentViewController = [self gx_parentController];
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGx_parentViewController:(UIViewController *)gx_parentViewController {
    objc_setAssociatedObject(self, @selector(gx_parentViewController), gx_parentViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -- 关联 ym_parentNavController getter - setter 方法
- (UINavigationController *)gx_parentNavController {
    self.gx_parentNavController = [self gx_parentNavigationController];
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGx_parentNavController:(UINavigationController *)gx_parentNavController {
    objc_setAssociatedObject(self, @selector(gx_parentNavController), gx_parentNavController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -- 视图所在父控制器
- (UIViewController *)gx_parentController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

#pragma mark -- 视图所在导航控制器
- (UINavigationController *)gx_parentNavigationController {
    return [self gx_parentController].navigationController;
}


@end
