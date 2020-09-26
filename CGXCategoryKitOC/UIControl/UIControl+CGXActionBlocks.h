//
//  UIControl+CGXActionBlocks.h
//  CGXAppStructure
//
//  Created by CGX on 2018/12/14.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UIControlCGXActionBlock)(id weakSender);


@interface UIControlCGXActionBlockWrapper : NSObject
@property (nonatomic, copy) UIControlCGXActionBlock gx_actionBlock;
@property (nonatomic, assign) UIControlEvents gx_controlEvents;
- (void)gx_invokeBlock:(id)sender;
@end



@interface UIControl (CGXActionBlocks)
- (void)gx_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlCGXActionBlock)actionBlock;
- (void)gx_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;
@end
