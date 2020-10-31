//
//  UIView+CGXRoundedRadius.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, CGXCornerPosition) {
    CGXCornerPositionTop,
    CGXCornerPositionLeft,
    CGXCornerPositionBottom,
    CGXCornerPositionRight,
    CGXCornerPositionAll
};
@interface UIView (CGXRoundedRadius)
@property (nonatomic, assign) CGXCornerPosition gx_cornerPosition;
@property (nonatomic, assign) CGFloat gx_cornerRadius;

- (void)gx_setCornerOnTopWithRadius:(CGFloat)radius;
- (void)gx_setCornerOnLeftWithRadius:(CGFloat)radius;
- (void)gx_setCornerOnBottomWithRadius:(CGFloat)radius;
- (void)gx_setCornerOnRightWithRadius:(CGFloat)radius;
- (void)gx_setAllCornerWithCornerRadius:(CGFloat)radius;
- (void)gx_setNoneCorner;

@end

NS_ASSUME_NONNULL_END
