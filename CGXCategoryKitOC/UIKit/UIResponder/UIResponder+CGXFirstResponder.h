//
//  UIResponder+CGXFirstResponder.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface UIResponder (CGXFirstResponder)
/**
 *  @brief  当前第一响应者
 *
 *  @return 当前第一响应者
 */
+ (id)gx_currentFirstResponder;

@end
