//
//  NSString+CGXSize.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (CGXSize)

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)gx_HeightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)gx_WidthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;
/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param size 约束
 */
- (CGSize)gx_BoundingRectWithSize:(CGSize)size sizeWithFont:(UIFont *)font;
/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param size 约束宽度
 */
- (CGSize)gx_BoundingRectWithSize:(CGSize)size sizeWithFont:(UIFont *)font  mode:(NSLineBreakMode)lineBreakMode;
/**
*  @brief 计算文字的大小
*
*  @param font  字体(默认为系统字体)
*  @param size 约束宽度
*  @param lineSpacing 行间距
*  @param paragraphSpacing 段落间距
*/
- (CGSize)gx_BoundingRectWithSize:(CGSize)size
                     sizeWithFont:(UIFont *)font
                             mode:(NSLineBreakMode)lineBreakMode
                      lineSpacing:(CGFloat)lineSpacing
                 paragraphSpacing:(CGFloat)paragraphSpacing;


//
///** 计算显示文本需要几行 */
- (CGFloat)gx_textShowLinesWithControlWidth:(CGFloat)controlWidth
                                       font:(UIFont *)font
                                lineSpacing:(CGFloat)lineSpacing;

/** 计算显示文本到指定行数时需要的高度 */
- (CGFloat)gx_textHeightWithSpecifyRow:(NSInteger)specifyRow
                                  font:(UIFont *)font
                           lineSpacing:(CGFloat)lineSpacing;

@end
