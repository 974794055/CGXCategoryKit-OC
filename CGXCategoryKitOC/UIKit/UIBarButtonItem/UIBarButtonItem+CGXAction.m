//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIBarButtonItem+CGXAction.h"
#import <objc/runtime.h>

char * const CGXBarButtonItemActionBlockString = "CGXBarButtonItemActionBlockString";


@implementation UIBarButtonItem (CGXAction)

- (void)performActionBlock {
    dispatch_block_t block = self.clickActionBlock;
    if (block)
        block();
}
- (CGXBarButtonItemActionBlock)clickActionBlock {
    return objc_getAssociatedObject(self, CGXBarButtonItemActionBlockString);
}
- (void)gx_clickActionBlock:(CGXBarButtonItemActionBlock)actionBlock
{
    if (actionBlock != self.clickActionBlock) {
        [self willChangeValueForKey:@"actionBlock"];
        objc_setAssociatedObject(self,CGXBarButtonItemActionBlockString,actionBlock,OBJC_ASSOCIATION_COPY);
        // Sets up the action.
        [self setTarget:self];
        [self setAction:@selector(performActionBlock)];
        [self didChangeValueForKey:@"actionBlock"];
    }
}
@end
