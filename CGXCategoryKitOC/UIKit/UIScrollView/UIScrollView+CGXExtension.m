//
//  UIScrollView+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIScrollView+CGXExtension.h"

@implementation UIScrollView (CGXExtension)
- (void)gx_scrollToTop {
    [self gx_scrollToTopAnimated:YES];
}

- (void)gx_scrollToBottom {
    [self gx_scrollToBottomAnimated:YES];
}

- (void)gx_scrollToLeft {
    [self gx_scrollToLeftAnimated:YES];
}

- (void)gx_scrollToRight {
    [self gx_scrollToRightAnimated:YES];
}

- (void)gx_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)gx_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)gx_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)gx_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
