//
//  UISplitViewController+CGXQuickAccess.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UISplitViewController (CGXQuickAccess)

@property (weak, readonly, nonatomic) UIViewController *gx_leftController;
@property (weak, readonly, nonatomic) UIViewController *gx_rightController;

@end
