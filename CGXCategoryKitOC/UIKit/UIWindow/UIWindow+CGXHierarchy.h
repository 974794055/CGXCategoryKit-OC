//
//  UIWindow+CGXHierarchy.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (CGXHierarchy)
/*!
 @method topMostController
 
 @return Returns the current Top Most ViewController in hierarchy.
 */
- (UIViewController*)gx_topMostController;

/*!
 @method currentViewController
 
 @return Returns the topViewController in stack of topMostController.
 */
- (UIViewController*)gx_currentViewController;

@end
