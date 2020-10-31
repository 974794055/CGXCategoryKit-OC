//
//  UIBarButtonItem+CGXBadge.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CGXBadge)

/** 角标 */
@property (strong, nonatomic) UILabel *gx_badgeLabel;

/** 角标的值 */
@property (nonatomic) NSString *gx_badgeValue;

/** 角标背景颜色 */
@property (nonatomic) UIColor *gx_badgeBGColor;

/** 角标文字颜色 */
@property (nonatomic) UIColor *gx_badgeTextColor;

/** 角标文字的字体 */
@property (nonatomic) UIFont *gx_badgeFont;

/** 角标边距 */
@property (nonatomic) CGFloat gx_badgePadding;

/** 角标最小的大小 */
@property (nonatomic) CGFloat gx_badgeMinSize;

/** 角标x坐标 */
@property (nonatomic) CGFloat gx_badgeOriginX;

/** 角标y坐标 */
@property (nonatomic) CGFloat gx_badgeOriginY;

/** 如果是数字0的话就隐藏角标不显示 */
@property BOOL gx_shouldHideBadgeAtZero;

/** 显示角标是否要缩放动画 */
@property BOOL gx_shouldAnimateBadge;

@end
