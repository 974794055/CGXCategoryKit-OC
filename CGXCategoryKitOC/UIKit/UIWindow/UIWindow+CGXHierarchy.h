//
//  UIWindow+CGXHierarchy.h
//  CGXAppStructure
//
//  Created by CGX on 2017/7/21.
//  Copyright © 2017年 CGX. All rights reserved.
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
