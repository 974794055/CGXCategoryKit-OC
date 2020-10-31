//
//  UIButton+CGXTableViewGeneralBtnBlock.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CGXBtnBlock)

-(void)gx_addTapBlock:(void(^)(UIButton *tapBtn))block;
-(void)gx_addTapBlock:(void(^)(UIButton *tapBtn))block Event:(UIControlEvents)controlEvent;

@end

NS_ASSUME_NONNULL_END
