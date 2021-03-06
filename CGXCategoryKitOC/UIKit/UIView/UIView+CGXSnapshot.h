//
//  UIView+CGXSnapshot.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CGXSnapshot)

/**
 *  返回屏幕快照
 *
 *  @return 屏幕快照
 */
- (UIImage *)gx_snapshotImage;

/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)gx_screenshot;

/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param maxWidth 限制缩放的最大宽度 保持默认传0
 *
 *  @return 截图
 */
- (UIImage *)gx_screenshot:(CGFloat)maxWidth;

@end
