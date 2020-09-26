//
//  UIControl+CGXActionBlocks.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIControl+CGXActionBlocks.h"
#import <objc/runtime.h>

static const void *UIControlCGXActionBlockArray = &UIControlCGXActionBlockArray;

@implementation UIControlCGXActionBlockWrapper

- (void)gx_invokeBlock:(id)sender {
    if (self.gx_actionBlock) {
        self.gx_actionBlock(sender);
    }
}
@end


@implementation UIControl (CGXActionBlocks)
-(void)gx_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlCGXActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self gx_actionBlocksArray];
    
    UIControlCGXActionBlockWrapper *blockActionWrapper = [[UIControlCGXActionBlockWrapper alloc] init];
    blockActionWrapper.gx_actionBlock = actionBlock;
    blockActionWrapper.gx_controlEvents = controlEvents;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self addTarget:blockActionWrapper action:@selector(gx_invokeBlock:) forControlEvents:controlEvents];
}


- (void)gx_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray *actionBlocksArray = [self gx_actionBlocksArray];
    NSMutableArray *wrappersToRemove = [NSMutableArray arrayWithCapacity:[actionBlocksArray count]];
    
    [actionBlocksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIControlCGXActionBlockWrapper *wrapperTmp = obj;
        if (wrapperTmp.gx_controlEvents == controlEvents) {
            [wrappersToRemove addObject:wrapperTmp];
            [self removeTarget:wrapperTmp action:@selector(gx_invokeBlock:) forControlEvents:controlEvents];
        }
    }];
    
    [actionBlocksArray removeObjectsInArray:wrappersToRemove];
}


- (NSMutableArray *)gx_actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, UIControlCGXActionBlockArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, UIControlCGXActionBlockArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}
@end
