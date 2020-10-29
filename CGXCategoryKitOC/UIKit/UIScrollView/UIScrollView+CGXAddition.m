//
//  UIScrollView+CGXAddition.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIScrollView+CGXAddition.h"

@implementation UIScrollView (CGXAddition)
//frame
- (CGFloat)gx_contentWidth {
    return self.contentSize.width;
}
- (void)setGx_contentWidth:(CGFloat)gx_contentWidth {
    self.contentSize = CGSizeMake(gx_contentWidth, self.frame.size.height);
}
- (CGFloat)gx_contentHeight {
    return self.contentSize.height;
}
- (void)setGx_contentHeight:(CGFloat)gx_contentHeight {
    self.contentSize = CGSizeMake(self.frame.size.width, gx_contentHeight);
}
- (CGFloat)gx_contentOffsetX {
    return self.contentOffset.x;
}
- (void)setGx_contentOffsetX:(CGFloat)gx_contentOffsetX {
    self.contentOffset = CGPointMake(gx_contentOffsetX, self.contentOffset.y);
}
- (CGFloat)gx_contentOffsetY {
    return self.contentOffset.y;
}
- (void)setGx_contentOffsetY:(CGFloat)gx_contentOffsetY {
    self.contentOffset = CGPointMake(self.contentOffset.x, gx_contentOffsetY);
}

- (CGPoint)gx_topContentOffset
{
    return CGPointMake(0.0f, -self.contentInset.top);
}
- (CGPoint)gx_bottomContentOffset
{
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}
- (CGPoint)gx_leftContentOffset
{
    return CGPointMake(-self.contentInset.left, 0.0f);
}
- (CGPoint)gx_rightContentOffset
{
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}
- (CGXScrollDirection)gx_isScrollDirection
{
    CGXScrollDirection direction;
    
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f)
    {
        direction = CGXScrollDirectionUp;
    }
    else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f)
    {
        direction = CGXScrollDirectionDown;
    }
    else if ([self.panGestureRecognizer translationInView:self].x < 0.0f)
    {
        direction = CGXScrollDirectionLeft;
    }
    else if ([self.panGestureRecognizer translationInView:self].x > 0.0f)
    {
        direction = CGXScrollDirectionRight;
    }
    else
    {
        direction = CGXScrollDirectionWTF;
    }
    
    return direction;
}
- (BOOL)gx_isScrolledToTop
{
    return self.contentOffset.y <= [self gx_topContentOffset].y;
}
- (BOOL)gx_isScrolledToBottom
{
    return self.contentOffset.y >= [self gx_bottomContentOffset].y;
}
- (BOOL)gx_isScrolledToLeft
{
    return self.contentOffset.x <= [self gx_leftContentOffset].x;
}
- (BOOL)gx_isScrolledToRight
{
    return self.contentOffset.x >= [self gx_rightContentOffset].x;
}
- (NSUInteger)gx_verticalPageIndex
{
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}
- (NSUInteger)gx_horizontalPageIndex
{
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}
- (void)gx_ScrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}
- (void)gx_ScrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}


@end
