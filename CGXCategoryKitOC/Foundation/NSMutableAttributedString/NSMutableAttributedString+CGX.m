//
//  NSMutableAttributedString+CGX.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSMutableAttributedString+CGX.h"

@implementation NSMutableAttributedString (CGX)

#pragma mark - 文本颜色属性
- (void)gx_addAttributeTextColor:(UIColor*)color
{
    [self gx_addAttributeTextColor:color range:NSMakeRange(0, [self length])];
}

- (void)gx_addAttributeTextColor:(UIColor*)color range:(NSRange)range
{
    if (color.CGColor)
    {
        [self removeAttribute:(NSString *)kCTForegroundColorAttributeName range:range];
        
        [self addAttribute:(NSString *)kCTForegroundColorAttributeName
                     value:(id)color.CGColor
                     range:range];
    }
    
}

#pragma mark - 文本字体属性
- (void)gx_addAttributeFont:(UIFont *)font
{
    [self gx_addAttributeFont:font range:NSMakeRange(0, [self length])];
}

- (void)gx_addAttributeFont:(UIFont *)font range:(NSRange)range
{
    if (font)
    {
        [self removeAttribute:(NSString*)kCTFontAttributeName range:range];
        
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, nil);
        if (nil != fontRef)
        {
            [self addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:range];
            CFRelease(fontRef);
        }
    }
}

#pragma mark - 文本字符间隔属性
- (void)gx_addAttributeCharacterSpacing:(unichar)characterSpacing
{
    [self gx_addAttributeCharacterSpacing:characterSpacing range:NSMakeRange(0, self.length)];
}

- (void)gx_addAttributeCharacterSpacing:(unichar)characterSpacing range:(NSRange)range
{
    [self removeAttribute:(id)kCTKernAttributeName range:range];
    
    CFNumberRef num =  CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&characterSpacing);
    [self addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:range];
    CFRelease(num);
}

#pragma mark - 文本下划线属性
- (void)gx_addAttributeUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier
{
    [self gx_addAttributeUnderlineStyle:style
                   modifier:modifier
                      range:NSMakeRange(0, self.length)];
}

- (void)gx_addAttributeUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier
                    range:(NSRange)range
{
    [self removeAttribute:(NSString *)kCTUnderlineColorAttributeName range:range];
    
    if (style != kCTUnderlineStyleNone) {
        [self addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                     value:[NSNumber numberWithInt:(style|modifier)]
                     range:range];
    }
    
}

#pragma mark - 文本空心字及颜色

- (void)gx_addAttributeStrokeWidth:(unichar)strokeWidth
                    strokeColor:(UIColor *)strokeColor
{
    [self gx_addAttributeStrokeWidth:strokeWidth strokeColor:strokeColor range:NSMakeRange(0, self.length)];
}

- (void)gx_addAttributeStrokeWidth:(unichar)strokeWidth
                    strokeColor:(UIColor *)strokeColor
                          range:(NSRange)range
{
    [self removeAttribute:(id)kCTStrokeWidthAttributeName range:range];
    if (strokeWidth > 0) {
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&strokeWidth);
        
        [self addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)num range:range];
    }
    
    [self removeAttribute:(id)kCTStrokeColorAttributeName range:range];
    if (strokeColor) {
        [self addAttribute:(id)kCTStrokeColorAttributeName value:(id)strokeColor.CGColor range:range];
    }
    
}

#pragma mark - 文本段落样式属性
- (void)gx_addAttributeAlignmentStyle:(CTTextAlignment)textAlignment
                    lineSpaceStyle:(CGFloat)linesSpacing
               paragraphSpaceStyle:(CGFloat)paragraphSpacing
                    lineBreakStyle:(CTLineBreakMode)lineBreakMode
{
    [self gx_addAttributeAlignmentStyle:textAlignment lineSpaceStyle:linesSpacing paragraphSpaceStyle:paragraphSpacing lineBreakStyle:lineBreakMode range:NSMakeRange(0, self.length)];
}

- (void)gx_addAttributeAlignmentStyle:(CTTextAlignment)textAlignment
                    lineSpaceStyle:(CGFloat)linesSpacing
               paragraphSpaceStyle:(CGFloat)paragraphSpacing
                    lineBreakStyle:(CTLineBreakMode)lineBreakMode
                             range:(NSRange)range
{
    [self removeAttribute:(id)kCTParagraphStyleAttributeName range:range];
    
    // 创建文本对齐方式
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
    alignmentStyle.valueSize = sizeof(textAlignment);
    alignmentStyle.value = &textAlignment;
    
    // 创建文本行间距
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(linesSpacing);
    lineSpaceStyle.value = &linesSpacing;
    
    //段落间距
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.value = &paragraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(paragraphSpacing);
    
    //换行模式
    CTParagraphStyleSetting lineBreakStyle;
    lineBreakStyle.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakStyle.value = &lineBreakMode;
    lineBreakStyle.valueSize = sizeof(lineBreakMode);
    
    // 创建样式数组
    CTParagraphStyleSetting settings[] = {alignmentStyle ,lineSpaceStyle, paragraphSpaceStyle, lineBreakStyle};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));	// 设置样式
    
    // 设置段落属性
    [self addAttribute:(id)kCTParagraphStyleAttributeName value:(id)CFBridgingRelease(paragraphStyle) range:range];
}



- (NSMutableAttributedString *)gx_addDeletingLineWithText:(NSString *)text deletingLinecolor:(UIColor *)color
{
    
    NSString *oldPrice =text;
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length )];
    [attri addAttribute:NSStrikethroughColorAttributeName value:color range:NSMakeRange(0, length)];
    return attri;
}

@end
