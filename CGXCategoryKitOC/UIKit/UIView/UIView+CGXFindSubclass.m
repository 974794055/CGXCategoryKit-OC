//
//  UIView+CGXFindSubclass.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXFindSubclass.h"
#import <objc/runtime.h>
@implementation UIView (CGXFindSubclass)
/// 查找视图 KEY
const char *FF_FIND_VIEW_KEY;

#pragma mark - 查找子视图
+ (UIView *)findView {
    return objc_getAssociatedObject(self, FF_FIND_VIEW_KEY);
}

+ (void)setFindView:(UIView *)findView {
    objc_setAssociatedObject(self, FF_FIND_VIEW_KEY, findView, OBJC_ASSOCIATION_ASSIGN);
}

+ (UIView *)gx_find_firstInView:(UIView *)view clazzName:(NSString *)clazzName {
    
    // 递归出口
    if ([self.findView isKindOfClass:NSClassFromString(clazzName)]) {
        return self.findView;
    }
    
    // 遍历所有子视图
    for (UIView *subView in view.subviews) {
        
        // 如果是要查找的类，记录并且返回
        if ([subView isKindOfClass:NSClassFromString(clazzName)]) {
            self.findView = subView;
            break;
        } else {
            // 使用子视图递归调用
            [self gx_find_firstInView:subView clazzName:clazzName];
        }
    }
    
    return self.findView;
}

/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)gx_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse
{
    for( UIView* subview in self.subviews ) {
        BOOL stop = NO;
        if( recurse( subview, &stop ) ) {
            return [subview gx_findViewRecursively:recurse];
        } else if( stop ) {
            return subview;
        }
    }
    
    return nil;
}


-(void)gx_runBlockOnAllSubviews:(CGXSubviewBlock)block
{
    block(self);
    for (UIView* view in [self subviews])
    {
        [view gx_runBlockOnAllSubviews:block];
    }
}

-(void)gx_runBlockOnAllSuperviews:(CGXSuperviewBlock)block
{
    block(self);
    if (self.superview)
    {
        [self.superview gx_runBlockOnAllSuperviews:block];
    }
}

-(void)gx_enableAllControlsInViewHierarchy
{
    [self gx_runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]])
        {
            [(UIControl *)view setEnabled:YES];
        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            [(UITextView *)view setEditable:YES];
        }
    }];
}

-(void)gx_disableAllControlsInViewHierarchy
{
    [self gx_runBlockOnAllSubviews:^(UIView *view) {
        
        if ([view isKindOfClass:[UIControl class]])
        {
            [(UIControl *)view setEnabled:NO];
        }
        else if ([view isKindOfClass:[UITextView class]])
        {
            [(UITextView *)view setEditable:NO];
        }
    }];
}


/**
 *  @brief  找到指定类名的view对象
 *
 *  @param clazz view类名
 *
 *  @return view对象
 */
- (id)gx_findSubViewWithSubViewClass:(Class)clazz
{
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:clazz]) {
            return subView;
        }
    }
    
    return nil;
}
/**
 *  @brief  找到指定类名的SuperView对象
 *
 *  @param clazz SuperView类名
 *
 *  @return view对象
 */
- (id)gx_findSuperViewWithSuperViewClass:(Class)clazz
{
    if (self == nil) {
        return nil;
    } else if (self.superview == nil) {
        return nil;
    } else if ([self.superview isKindOfClass:clazz]) {
        return self.superview;
    } else {
        return [self.superview gx_findSuperViewWithSuperViewClass:clazz];
    }
}
/**
 *  @brief  找到并且resign第一响应者
 *
 *  @return 结果
 */
- (BOOL)gx_findAndResignFirstResponder {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    
    for (UIView *v in self.subviews) {
        if ([v gx_findAndResignFirstResponder]) {
            return YES;
        }
    }
    
    return NO;
}
/**
 *  @brief  找到第一响应者
 *
 *  @return 第一响应者
 */
- (UIView *)gx_findFirstResponder {
    
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]])
        && (self.isFirstResponder)) {
        return self;
    }
    
    for (UIView *v in self.subviews) {
        UIView *fv = [v gx_findFirstResponder];
        if (fv) {
            return fv;
        }
    }
    
    return nil;
}
- (void)gx_removeAllSubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (NSArray *)gx_allSubviews
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    [array addObjectsFromArray:self.subviews];
    
    for (UIView *view in self.subviews)
    {
        [array addObjectsFromArray:[view gx_allSubviews]];
    }
    
    return array;
}
@end
