//
//  UIResponder+CGXChain.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//
#import <UIKit/UIKit.h>

@interface UIResponder (CGXChain)
/**
 *  @brief  响应者链
 *
 *  @return  响应者链
 */
- (NSString *)gx_responderChainDescription;

@end
