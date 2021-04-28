//
//  UIView+CGXRoundedCorners.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS (NSUInteger, CGXRoundedClipType) {
    CGXRoundedClipTypeNone = 0,  // 不切
    CGXRoundedClipTypeTopLeft     = UIRectCornerTopLeft, // 左上角
    CGXRoundedClipTypeTopRight    = UIRectCornerTopRight, // 右上角
    CGXRoundedClipTypeBottomLeft  = UIRectCornerBottomLeft, // 左下角
    CGXRoundedClipTypeBottomRight = UIRectCornerBottomRight, // 右下角
    CGXRoundedClipTypeAll  = UIRectCornerAllCorners,// 全部四个角
};

@interface UIView (CGXRoundedCorners)

// 圆角
@property(nonatomic, assign) CGFloat gx_clipRadius;
@property(nonatomic, assign) CGXRoundedClipType gx_clipType;
// border
@property(nonatomic, assign) CGFloat gx_borderWidth;
@property(nonatomic, strong) UIColor *gx_borderColor;

/**
四角圆角
@param radius 圆角角度
*/
- (void)gx_roundedCornerWithAllRadius:(CGFloat)radius;
/**
上面两个圆角
@param radius 圆角角度
*/
- (void)gx_roundedCornerWithTopRadius:(CGFloat)radius;
/**
下面两个圆角
@param radius 圆角角度
*/
- (void)gx_roundedCornerWithBottomRadius:(CGFloat)radius;
/**
左面两个圆角
@param radius 圆角角度
*/
- (void)gx_roundedCornerWithLeftRadius:(CGFloat)radius;
/**
右面两个圆角
@param radius 圆角角度
*/
- (void)gx_roundedCornerWithRightRadius:(CGFloat)radius;
/**
 便捷添加圆角
 @param clipType 圆角类型
 @param radius 圆角角度
 */
- (void)gx_roundedCornerWithRadius:(CGFloat)radius clipWithType:(CGXRoundedClipType)clipType;
/**
 便捷给添加border
 @param color 边框的颜色
 @param borderWidth 边框的宽度
 */
- (void)gx_BorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

@end

