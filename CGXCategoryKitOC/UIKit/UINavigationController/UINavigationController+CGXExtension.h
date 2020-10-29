//
//  UINavigationController+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (CGXExtension)

/** 以某种动画形式push */
- (void)gx_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;

/** 以某种动画形式pop */
- (UIViewController *)gx_popViewControllerWithTransition:(UIViewAnimationTransition)transition;


@end

NS_ASSUME_NONNULL_END
