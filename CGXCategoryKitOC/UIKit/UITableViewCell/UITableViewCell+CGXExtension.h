//
//  UITableViewCell+CGXExtension.h
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (CGXExtension)

/// 显示缩放效果
- (void)gx_showScaleAnimation;

/// 显示缩进效果
- (void)gx_showIndentAnimationWithCell;

/// 显示旋转效果
- (void)gx_showRoatationAnimation;

/// 设置分割线左边距,右边距
- (void)gx_setCellBottomLineLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;

/// 设置分割线左边距
- (void)gx_setCellBottomLineLeftSpace:(CGFloat)leftSpace;

/// 设置左右边距为0
- (void)gx_setCellBottomLineZeroSpace;

/// 隐藏分割线
- (void)gx_hiddenCellBottomLine;

- (void)gx_SectionCornerWithTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath CornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
