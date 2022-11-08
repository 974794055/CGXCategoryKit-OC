//
//  UIGestureRecognizer+CGXCategoryBlock.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (CGXCategoryBlock)

/// block初始化手势
- (instancetype)initWithGXActionBlock:(void (^)(id sender))block;

/// block添加手势回调
- (void)gx_addActionBlock:(void (^)(id sender))block;

/// 移除所有的手势block
- (void)gx_removeAllActionBlocks;

@end

NS_ASSUME_NONNULL_END
