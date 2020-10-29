//
//  UIButton+CGXEdgeInsets.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, CGXEdgeInsetsPosition) {
    /** 图片在左，文字在右，默认 */
    CGXEdgeInsetsPositionImageLeft = 0,
    /** 图片在右，文字在左 */
    CGXEdgeInsetsPositionImageRight = 1,
    /** 图片在上，文字在下 */
    CGXEdgeInsetsPositionImageTop = 2,
    /** 图片在下，文字在上 */
    CGXEdgeInsetsPositionImageBottom = 3,
};

@interface UIButton (CGXEdgeInsets)

- (void)gx_buttonWithEdgeInsetsStyle:(CGXEdgeInsetsPosition)style
                        imageTitleSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
