//
//  UIScrollView+CGXPages.h
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CGXPages)
- (NSInteger)gx_pages;
- (NSInteger)gx_currentPage;
- (CGFloat)gx_scrollPercent;

- (CGFloat)gx_pagesY;
- (CGFloat)gx_pagesX;
- (CGFloat)gx_currentPageY;
- (CGFloat)gx_currentPageX;
- (void)gx_setPageY:(CGFloat)page;
- (void)gx_setPageX:(CGFloat)page;
- (void)gx_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void)gx_setPageX:(CGFloat)page animated:(BOOL)animated;
@end
