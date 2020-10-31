//
//  UIScrollView+CGXStopScroll.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIScrollView+CGXStopScroll.h"

#import <objc/runtime.h>
@implementation UIScrollView (CGXStopScroll)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([UIScrollView class], @selector(setDelegate:));
        Method replaceMethod = class_getInstanceMethod([UIScrollView class], @selector(gx_stopScroll_setDelegate:));
        method_exchangeImplementations(originalMethod, replaceMethod);
    });
}

/*
 1、快速滚动，自然停止；
 2、快速滚动，手指按压突然停止；
 3、慢速上下滑动停止
 */
#pragma mark - scrollView 停止滚动监测
- (void)gx_stopScroll:(UIScrollView *)scrollView {
    if (self.gx_stopScrollBlock) {
        self.gx_stopScrollBlock(scrollView);
    }
}

// 那没有实现需要hook的代理方法时，调用此处方法
#pragma mark - Add_Method
- (void)add_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [scrollView gx_stopScroll:scrollView];
    }
}

- (void)add_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"%s", __func__);
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [scrollView gx_stopScroll:scrollView];
        }
    }
}

// 已经实现需要hook的代理方法时，调用此处方法进行替换
#pragma mark - Replace_Method
- (void)gx_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    [self gx_scrollViewDidEndDecelerating:scrollView];
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [scrollView gx_stopScroll:scrollView];
    }
}

- (void)gx_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"%s", __func__);
    [self gx_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [scrollView gx_stopScroll:scrollView];
        }
    }
}

#pragma mark - Hook UIScrollView setDelegate
- (void)gx_stopScroll_setDelegate:(id<UIScrollViewDelegate>)delegate {
    [self gx_stopScroll_setDelegate:delegate];
    
    if ([self isMemberOfClass:[UIScrollView class]]) {
        NSLog(@"是UIScrollView，hook方法");
        //Hook (scrollViewDidEndDecelerating:) 方法
        CGX_Method([delegate class], @selector(scrollViewDidEndDecelerating:), [self class], @selector(gx_scrollViewDidEndDecelerating:), @selector(add_scrollViewDidEndDecelerating:));
        
        //Hook (scrollViewDidEndDragging:willDecelerate:) 方法
        CGX_Method([delegate class], @selector(scrollViewDidEndDragging:willDecelerate:), [self class], @selector(gx_scrollViewDidEndDragging:willDecelerate:), @selector(add_scrollViewDidEndDragging:willDecelerate:));
    } else {
        NSLog(@"不是UIScrollView，不需要hook方法");
    }
}
#pragma mark - Setter And Getter
static const char CGX_stopScrollBlock = '\0';
- (CGXStopScrollBlock)gx_stopScrollBlock {
    return objc_getAssociatedObject(self, &CGX_stopScrollBlock);
}

- (void)setGx_stopScrollBlock:(CGXStopScrollBlock)gx_stopScrollBlock {
    objc_setAssociatedObject(self, &CGX_stopScrollBlock, gx_stopScrollBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - CGX_Method
static void CGX_Method(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL noneSel){
    // 原实例方法
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    // 替换的实例方法
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    // 如果没有实现 delegate 方法，则手动动态添加
    if (!originalMethod) {
        Method noneMethod = class_getInstanceMethod(replacedClass, noneSel);
        BOOL addNoneMethod = class_addMethod(originalClass, originalSel, method_getImplementation(noneMethod), method_getTypeEncoding(noneMethod));
        if (addNoneMethod) {
            NSLog(@"******** 没有实现 (%@) 方法，手动添加成功！！",NSStringFromSelector(originalSel));
        }
        return;
    }
    // 向实现 delegate 的类中添加新的方法
    // 这里是向 originalClass 的 replaceSel（@selector(gx_scrollViewDidEndDecelerating:)） 添加 replaceMethod
    BOOL addMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (addMethod) {
        // 添加成功
        NSLog(@"******** 实现了 (%@) 方法并成功 Hook 为 --> (%@)", NSStringFromSelector(originalSel), NSStringFromSelector(replacedSel));
        // 重新拿到添加被添加的 method,这里是关键(注意这里 originalClass, 不 replacedClass), 因为替换的方法已经添加到原类中了, 应该交换原类中的两个方法
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        // 实现交换
        method_exchangeImplementations(originalMethod, newMethod);
    }else{
        // 添加失败，则说明已经 hook 过该类的 delegate 方法，防止多次交换。
        NSLog(@"******** 已替换过，避免多次替换 --> (%@)",NSStringFromClass(originalClass));
    }
}

@end
