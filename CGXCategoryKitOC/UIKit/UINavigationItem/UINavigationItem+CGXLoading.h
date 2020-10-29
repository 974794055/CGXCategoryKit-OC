
//
// UINavigationItem+Loading.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Position to show UIActivityIndicatorView in a navigation bar
 */
typedef NS_ENUM(NSUInteger, CGXLoaderNavBarPosition){
    /**
     *  Will show UIActivityIndicatorView in place of title view
     */
    CGXLoaderNavBarPositionCenter = 0,
    /**
     *  Will show UIActivityIndicatorView in place of left item
     */
    CGXLoaderNavBarPositionLeft,
    /**
     *  Will show UIActivityIndicatorView in place of right item
     */
    CGXLoaderNavBarPositionRight
};

@interface UINavigationItem (CGXLoading)

/**
 *  Add UIActivityIndicatorView to view hierarchy and start animating immediately
 *
 *  @param position Left, center or right
 */
- (void)gx_startAnimatingAt:(CGXLoaderNavBarPosition)position;

/**
 *  Stop animating, remove UIActivityIndicatorView from view hierarchy and restore item
 */
- (void)gx_stopAnimating;

@end
