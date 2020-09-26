//
//  UIWindow+CGXHierarchy.m
//  CGXAppStructure
//
//  Created by CGX on 2017/7/21.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import "UIWindow+CGXHierarchy.h"

@implementation UIWindow (CGXHierarchy)
- (UIViewController*)gx_topMostController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)gx_currentViewController;
{
    UIViewController *currentViewController = [self gx_topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}
@end
