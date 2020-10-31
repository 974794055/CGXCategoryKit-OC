//
//  UIScrollView+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (CGXExtension)

/**
 Scroll content to top with animation.
 */
- (void)gx_scrollToTop;
/**
 Scroll content to bottom with animation.
 */
- (void)gx_scrollToBottom;
/**
 Scroll content to left with animation.
 */
- (void)gx_scrollToLeft;
/**
 Scroll content to right with animation.
 */
- (void)gx_scrollToRight;
/**
 Scroll content to top.
 @param animated  Use animation.
 */
- (void)gx_scrollToTopAnimated:(BOOL)animated;
/**
 Scroll content to bottom.
 @param animated  Use animation.
 */
- (void)gx_scrollToBottomAnimated:(BOOL)animated;
/**
 Scroll content to left.
 @param animated  Use animation.
 */
- (void)gx_scrollToLeftAnimated:(BOOL)animated;
/**
 Scroll content to right.
 @param animated  Use animation.
 */
- (void)gx_scrollToRightAnimated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
