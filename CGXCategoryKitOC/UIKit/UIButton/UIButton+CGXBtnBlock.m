//
//  UIButton+CGXTableViewGeneralBtnBlock.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UIButton+CGXBtnBlock.h"
#import <objc/runtime.h>

@implementation UIButton (CGXBtnBlock)

-(void)setBlock:(void(^)(UIButton*tapBtn))block{
    objc_setAssociatedObject(self,@selector(block), block,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}
-(void(^)(UIButton*))block{
    return objc_getAssociatedObject(self,@selector(block));
}
-(void)gx_addTapBlock:(void(^)(UIButton *tapBtn))block
{
    [self gx_addTapBlock:block Event:UIControlEventTouchUpInside];
}
-(void)gx_addTapBlock:(void(^)(UIButton *tapBtn))block Event:(UIControlEvents)controlEvent
{
    self.block= block;
    [self addTarget:self action:@selector(click:)forControlEvents:controlEvent];
}
-(void)click:(UIButton*)btn{
    if(self.block){
        self.block(btn);
    }
}
@end
