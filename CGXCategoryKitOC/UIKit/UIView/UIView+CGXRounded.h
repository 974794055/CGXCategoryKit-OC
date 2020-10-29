//
//  UIView+CGXRounded.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CGXRoundedPosition) {
    CGXRoundedPositionAll,
    CGXRoundedPositionTop,
    CGXRoundedPositionLeft,
    CGXRoundedPositionBottom,
    CGXRoundedPositionRight,
    
};

@interface UIView (CGXRounded)


/**
 设置一个四角圆角
 
 @param radius 圆角半径
 */
- (void)gx_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color;

/**
 设置一个普通圆角
 
 @param radius  圆角半径
 @param color   圆角背景色
 @param corners 圆角位置
 */
- (void)gx_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

/**
 设置一个带边框的圆角
 
 @param radius 圆角半径cornerRadii
 @param color       圆角背景色
 @param corners     圆角位置
 @param borderColor 边框颜色
 @param borderWidth 边框线宽
 */
- (void)gx_cornerRadius:(CGSize)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end

@interface CALayer (CGXRounded)

@property (nonatomic, strong) UIImage *contentImage;//contents的便捷设置

/**如下分别对应UIView的相应API*/

- (void)gx_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color;

- (void)gx_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

- (void)gx_cornerRadius:(CGSize)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
