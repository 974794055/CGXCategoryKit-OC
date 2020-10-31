//
//  UIScrollView+CGXAddition.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CGXScrollDirection) {
    CGXScrollDirectionUp,
    CGXScrollDirectionDown,
    CGXScrollDirectionLeft,
    CGXScrollDirectionRight,
    CGXScrollDirectionWTF
};

@interface UIScrollView (CGXAddition)

@property(nonatomic) CGFloat gx_contentWidth;
@property(nonatomic) CGFloat gx_contentHeight;
@property(nonatomic) CGFloat gx_contentOffsetX;
@property(nonatomic) CGFloat gx_contentOffsetY;

- (CGPoint)gx_topContentOffset;
- (CGPoint)gx_bottomContentOffset;
- (CGPoint)gx_leftContentOffset;
- (CGPoint)gx_rightContentOffset;

- (CGXScrollDirection)gx_isScrollDirection;

- (BOOL)gx_isScrolledToTop;
- (BOOL)gx_isScrolledToBottom;
- (BOOL)gx_isScrolledToLeft;
- (BOOL)gx_isScrolledToRight;


- (NSUInteger)gx_verticalPageIndex;
- (NSUInteger)gx_horizontalPageIndex;

- (void)gx_ScrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)gx_ScrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
@end
