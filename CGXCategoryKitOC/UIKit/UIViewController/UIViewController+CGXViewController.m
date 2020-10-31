//
//  UIViewController+CGXViewController.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UIViewController+CGXViewController.h"

@implementation UIViewController (CGXViewController)

+(instancetype)findBestViewController:(UIViewController *)vc{
    if (vc.presentedViewController) {
        return [self findBestViewController:vc.presentedViewController];
    }else if ([vc isKindOfClass:[UISplitViewController class]]){
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count>0) {
            return [self findBestViewController:svc.viewControllers.lastObject];
        }else{
            return vc;
        }
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
        {
            return [self findBestViewController:svc.topViewController];
        }
        else
        {
            return vc;
        }
    }else if ([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController* svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0)
        {
            return [self findBestViewController:svc.selectedViewController];
        }
        else
        {
            return vc;
        }
        
    }else{
        return vc;
    }
}

+(UIViewController *)gx_currentViewController{
    UIViewController *viewController = [[UIApplication sharedApplication].delegate window].rootViewController;
    return [UIViewController findBestViewController:viewController];
}

+ (UINavigationController *)gx_currentNavigatonController {
    
    UIViewController * currentViewController =  [UIViewController gx_currentViewController];
    
    return currentViewController.navigationController;
}

- (void)gx_addChildController:(UIViewController *)childController intoView:(UIView *)view  {
    
    [self addChildViewController:childController];
    
    [view addSubview:childController.view];
    
    [childController didMoveToParentViewController:self];
}


/**
 *  状态栏是否显示背景色
 *
 *  @param show yes为显示背景色，否则为透明
 */
- (void)gx_navigationBarBackgroundShow:(BOOL)show
{
  self.navigationController.navigationBar.translucent = !show;
  UIColor *color = nil;
  if (show) {
    color = [UIColor whiteColor];
  } else {
    color = [UIColor clearColor];
  }
  CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, 64);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

  UIGraphicsEndImageContext();
  [self.navigationController.navigationBar
      setBackgroundImage:image
           forBarMetrics:UIBarMetricsDefault];
  self.navigationController.navigationBar.clipsToBounds = !show;
}
@end
