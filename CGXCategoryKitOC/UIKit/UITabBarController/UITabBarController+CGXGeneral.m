//
//  UITabBarController+CGXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/24.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UITabBarController+CGXGeneral.h"
#import "UIImage+CGXColor.h"

@implementation UITabBarController (CGXGeneral)

- (void)gx_setTabBarColor:(UIColor *)barColor shadowColor:(UIColor *)shadowColor
{
    UIImage *barImg = [UIImage gx_imageWithColor:barColor Size:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 49.)];
    UIImage *shadowImg = [UIImage gx_imageWithColor:barColor Size:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 1.)];
    [[UITabBar appearance] setBackgroundImage:barImg];
    [[UITabBar appearance] setShadowImage:shadowImg];
}

- (void)gx_setTabbarTitleNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor
{
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = normalColor;
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = selectedColor;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
