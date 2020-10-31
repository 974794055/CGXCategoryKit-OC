//
//  UIScrollView+CGXStopScroll.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CGXStopScrollBlock)(UIScrollView *scrollView);


@interface UIScrollView (CGXStopScroll)

@property(nonatomic, copy) CGXStopScrollBlock gx_stopScrollBlock;


@end

NS_ASSUME_NONNULL_END
