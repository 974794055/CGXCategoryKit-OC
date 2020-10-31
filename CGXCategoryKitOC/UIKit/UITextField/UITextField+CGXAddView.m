//
//  UITextField+CGXAddView.m
//  CGXAppStructure-OC
//
//  Created by CGX on 2019/6/24.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UITextField+CGXAddView.h"
#include <objc/runtime.h>

static const void *CGXAddViewLeftSpace1 = &CGXAddViewLeftSpace1;
static const void *CGXAddViewLeftSpace2 = &CGXAddViewLeftSpace2;
static const void *CGXAddViewRightSpace1 = &CGXAddViewRightSpace1;
static const void *CGXAddViewRightSpace2 = &CGXAddViewRightSpace2;

@implementation UITextField (CGXAddView)

- (CGFloat)gx_leftSpace1 {
    return [objc_getAssociatedObject(self, &CGXAddViewLeftSpace1) floatValue];
}
- (void)setGx_leftSpace1:(CGFloat)gx_leftSpace1 {
    objc_setAssociatedObject(self, &CGXAddViewLeftSpace1, @(gx_leftSpace1), OBJC_ASSOCIATION_RETAIN);
}
- (CGFloat)gx_leftSpace2 {
    return [objc_getAssociatedObject(self, &CGXAddViewLeftSpace2) floatValue];
}
- (void)setGx_leftSpace2:(CGFloat)gx_leftSpace2 {
    objc_setAssociatedObject(self, &CGXAddViewLeftSpace2, @(gx_leftSpace2), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)gx_rightSpace1 {
    return [objc_getAssociatedObject(self, &CGXAddViewRightSpace1) floatValue];
}
- (void)setGx_rightSpace1:(CGFloat)gx_rightSpace1 {
    objc_setAssociatedObject(self, &CGXAddViewRightSpace1, @(gx_rightSpace1), OBJC_ASSOCIATION_RETAIN);
}
- (CGFloat)gx_rightSpace2 {
    return [objc_getAssociatedObject(self, &CGXAddViewRightSpace2) floatValue];
}
- (void)setGx_rightSpace2:(CGFloat)gx_rightSpace2 {
    objc_setAssociatedObject(self, &CGXAddViewLeftSpace1, @(gx_rightSpace2), OBJC_ASSOCIATION_RETAIN);
}

-(void)gx_addLeftViewWithImage:(NSString *)image
{
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, self.bounds.size.height+self.gx_leftSpace1+self.gx_leftSpace2, self.bounds.size.height);
    // 密码输入框左边图片
    UIImageView *lockIv = [[UIImageView alloc] init];
    // 设置尺寸
    CGRect imageBound = CGRectMake(self.gx_leftSpace1, 0, self.bounds.size.height, self.bounds.size.height);;
    // 宽度高度一样
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds = imageBound;
    // 设置图片
    lockIv.image = [UIImage imageNamed:image];
    // 设置图片居中显示
    lockIv.contentMode = UIViewContentModeCenter;
    [leftView addSubview:lockIv];
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // 添加TextFiled的左边视图
    self.leftView = leftView;
    // 设置TextField左边的总是显示
    self.leftViewMode = UITextFieldViewModeAlways;
}
- (void)gx_addRightViewWithImage:(NSString *)image
{
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = CGRectMake(0, 0, self.bounds.size.height+self.gx_rightSpace1+self.gx_rightSpace2, self.bounds.size.height);
    // 密码输入框左边图片
    UIImageView *lockIv = [[UIImageView alloc] init];
    // 设置尺寸
    CGRect imageBound = CGRectMake(self.gx_rightSpace2, 0, self.bounds.size.height, self.bounds.size.height);;;
    // 宽度高度一样
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds = imageBound;
    // 设置图片
    lockIv.image = [UIImage imageNamed:image];
    // 设置图片居中显示
    lockIv.contentMode = UIViewContentModeCenter;
    [rightView addSubview:lockIv];
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // 添加TextFiled的左边视图
    self.rightView = rightView;
    // 设置TextField左边的总是显示
    self.rightViewMode = UITextFieldViewModeAlways;
}


@end
