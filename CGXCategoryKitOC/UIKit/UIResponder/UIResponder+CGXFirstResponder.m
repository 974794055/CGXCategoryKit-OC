//
//  UIResponder+CGXFirstResponder.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//


#import "UIResponder+CGXFirstResponder.h"

static __weak id gx_currentFirstResponder;

@implementation UIResponder (CGXFirstResponder)
/**
 *  @brief  当前第一响应者
 *
 *  @return 当前第一响应者
 */
+ (id)gx_currentFirstResponder {
    gx_currentFirstResponder = nil;
    
    [[UIApplication sharedApplication] sendAction:@selector(gx_findCurrentFirstResponder:) to:nil from:nil forEvent:nil];
    
    return gx_currentFirstResponder;
}

- (void)gx_findCurrentFirstResponder:(id)sender {
    gx_currentFirstResponder = self;
}

@end
