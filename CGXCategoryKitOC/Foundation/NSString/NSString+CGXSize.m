//
//  NSString+CGXSize.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSString+CGXSize.h"

@implementation NSString (CGXSize)

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)gx_HeightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    return [self  gx_BoundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) sizeWithFont:font].height;
}
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)gx_WidthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
   return [self  gx_BoundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) sizeWithFont:font].width;
}
/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param size 约束
 */
- (CGSize)gx_BoundingRectWithSize:(CGSize)size sizeWithFont:(UIFont *)font
{
    return [self gx_BoundingRectWithSize:size sizeWithFont:font mode:NSLineBreakByWordWrapping];
}
/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param size 约束宽度
 *  //paragraphStyle.lineSpacing = lineSpacing;//行间距
 //paragraphStyle.paragraphSpacing = 3;//段落间距
 */
- (CGSize)gx_BoundingRectWithSize:(CGSize)size sizeWithFont:(UIFont *)font  mode:(NSLineBreakMode)lineBreakMode
{
  return  [self gx_BoundingRectWithSize:size sizeWithFont:font mode:lineBreakMode lineSpacing:0 paragraphSpacing:0];
}

- (CGSize)gx_BoundingRectWithSize:(CGSize)size sizeWithFont:(UIFont *)font  mode:(NSLineBreakMode)lineBreakMode lineSpacing:(CGFloat)lineSpacing paragraphSpacing:(CGFloat)paragraphSpacing
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine |
                                               NSStringDrawingUsesFontLeading)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:size
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:size
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine |
                                           NSStringDrawingUsesFontLeading)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

/** 计算显示文本需要几行 */
- (CGFloat)gx_textShowLinesWithControlWidth:(CGFloat)controlWidth
                                       font:(UIFont *)font
                                lineSpacing:(CGFloat)lineSpacing
{
    return [self gx_textShowLinesWithControlWidth:controlWidth
                                             font:font
                                      lineSpacing:lineSpacing
                                 paragraphSpacing:0];
}
- (CGFloat)gx_textShowLinesWithControlWidth:(CGFloat)controlWidth
                                       font:(UIFont *)font
                                lineSpacing:(CGFloat)lineSpacing
                           paragraphSpacing:(CGFloat)paragraphSpacing
{
    //计算总高度
    CGFloat totalHeight = [self gx_BoundingRectWithSize:CGSizeMake(controlWidth, MAXFLOAT) sizeWithFont:font mode:NSLineBreakByWordWrapping lineSpacing:lineSpacing paragraphSpacing:paragraphSpacing].height;
    //计算每行的高度
    CGFloat lineHeight = font.lineHeight+lineSpacing;
    
    return totalHeight/lineHeight;
}
/** 计算显示文本到指定行数时需要的高度 */
- (CGFloat)gx_textHeightWithSpecifyRow:(NSInteger)specifyRow
                                  font:(UIFont *)font
                           lineSpacing:(CGFloat)lineSpacing {
    
    return (font.lineHeight+lineSpacing)*specifyRow;
}

@end
