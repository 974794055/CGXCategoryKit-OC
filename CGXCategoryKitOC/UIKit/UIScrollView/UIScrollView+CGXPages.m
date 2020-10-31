//
//  UIScrollView+CGXPages.m
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIScrollView+CGXPages.h"

@implementation UIScrollView (CGXPages)
- (NSInteger)gx_pages{
    NSInteger pages = self.contentSize.width/self.frame.size.width;
    return pages;
}
- (NSInteger)gx_currentPage{
    NSInteger pages = self.contentSize.width/self.frame.size.width;
    CGFloat scrollPercent = [self gx_scrollPercent];
    NSInteger currentPage = (NSInteger)roundf((pages-1)*scrollPercent);
    return currentPage;
}
- (CGFloat)gx_scrollPercent{
    CGFloat width = self.contentSize.width-self.frame.size.width;
    CGFloat scrollPercent = self.contentOffset.x/width;
    return scrollPercent;
}

- (CGFloat)gx_pagesY {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat contentHeight = self.contentSize.height;
    return contentHeight/pageHeight;
}
- (CGFloat)gx_pagesX{
    CGFloat pageWidth = self.frame.size.width;
    CGFloat contentWidth = self.contentSize.width;
    return contentWidth/pageWidth;
}
- (CGFloat)gx_currentPageY{
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY = self.contentOffset.y;
    return offsetY / pageHeight;
}
- (CGFloat)gx_currentPageX{
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetX = self.contentOffset.x;
    return offsetX / pageWidth;
}
- (void)gx_setPageY:(CGFloat)page{
    [self gx_setPageY:page animated:NO];
}
- (void) setPageX:(CGFloat)page{
    [self gx_setPageX:page animated:NO];
}
- (void)gx_setPageY:(CGFloat)page animated:(BOOL)animated {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY = page * pageHeight;
    CGFloat offsetX = self.contentOffset.x;
    CGPoint offset = CGPointMake(offsetX,offsetY);
    [self setContentOffset:offset];
}
- (void)gx_setPageX:(CGFloat)page animated:(BOOL)animated{
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetY = self.contentOffset.y;
    CGFloat offsetX = page * pageWidth;
    CGPoint offset = CGPointMake(offsetX,offsetY);
    [self setContentOffset:offset animated:animated];
}

@end
