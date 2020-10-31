//
//  NSMutableAttributedString+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSMutableAttributedString+CGXExtension.h"
#include <objc/runtime.h>
@implementation NSMutableAttributedString (CGXExtension)

+ (NSMutableAttributedString *)gx_attributeWithStr:(NSString *)str {
    
    return [[NSMutableAttributedString alloc] initWithString:str];
}

- (void)setParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle {
    
    if(paragraphStyle == nil) {
        paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    }
    objc_setAssociatedObject(self, &@selector(paragraphStyle), paragraphStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableParagraphStyle *)paragraphStyle {
    
    NSMutableParagraphStyle *obj = objc_getAssociatedObject(self, &@selector(paragraphStyle));
    return obj;
}

- (void)gx_colorsOfRanges:(NSArray<NSDictionary *> *)gx_colorsOfRanges {
    
    if(gx_colorsOfRanges == nil) return;
    
    for (NSDictionary *dic in gx_colorsOfRanges) {
        
        UIColor *color = (UIColor *)[dic.allKeys firstObject];
        if([[dic.allValues firstObject] isKindOfClass:[NSString class]]) {
            
            NSString *rangeStr = (NSString *)[dic.allValues firstObject];
            [self addAttribute:NSForegroundColorAttributeName value:color range:[self.string rangeOfString:rangeStr]];
            
        }else {
            
            NSArray *rangeAry = (NSArray *)[dic.allValues firstObject];
            [self addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange([[rangeAry firstObject] integerValue], [[rangeAry lastObject] integerValue])];
        }
    }
}

- (void)gx_fontsOfRanges:(NSArray<NSDictionary *> *)gx_fontsOfRanges {
    
    if(gx_fontsOfRanges == nil) return;
    
    for (NSDictionary *dic in gx_fontsOfRanges) {
        
        UIFont *font = (UIFont *)[dic.allKeys firstObject];
        if([[dic.allValues firstObject] isKindOfClass:[NSString class]]) {
            
            NSString *rangeStr = (NSString *)[dic.allValues firstObject];
            [self addAttribute:NSFontAttributeName value:font range:[self.string rangeOfString:rangeStr]];
            
        }else {
            
            NSArray *rangeAry = (NSArray *)[dic.allValues firstObject];
            [self addAttribute:NSFontAttributeName value:font range:NSMakeRange([[rangeAry firstObject] integerValue], [[rangeAry lastObject] integerValue])];
        }
    }
}

- (void)gx_setLineSpacing:(CGFloat)lineSpacing string:(NSString *)string {
    
    if(self.paragraphStyle == nil) {
        self.paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    }
    [self.paragraphStyle setLineSpacing:lineSpacing];
    [self addAttribute:NSParagraphStyleAttributeName value:self.paragraphStyle range:[self.string rangeOfString:string]];
}

- (void)gx_setWordsSpacing:(CGFloat)wordsSpacing string:(NSString *)string {
    
    [self addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:wordsSpacing] range:[self.string rangeOfString:string]];
}

- (void)gx_addUnderlineWithString:(NSString *)string {
    
    [self addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:[self.string rangeOfString:string]];
}
- (void)gx_addUnderlineWithString:(NSString *)string TextColor:(UIColor *)color
{
    [self gx_addUnderlineWithString:string];
    [self addAttribute:NSForegroundColorAttributeName value:color range:[self.string rangeOfString:string]];
}
- (void)gx_addUnderlineWithString:(NSString *)string TextColor:(UIColor *)color Font:(UIFont *)font
{
    [self gx_addUnderlineWithString:string TextColor:color];
    [self addAttribute:NSFontAttributeName value:font range:[self.string rangeOfString:string]];
    
}
- (void)gx_addHorizontalLineWithString:(NSString *)string {
    
    [self addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:[self.string rangeOfString:string]];
}
- (void)gx_addHorizontalLineWithString:(NSString *)string TextColor:(UIColor *)color
{
    [self addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:[self.string rangeOfString:string]];
    [self addAttribute:NSForegroundColorAttributeName value:color range:[self.string rangeOfString:string]];
}
- (void)gx_addHorizontalLineWithString:(NSString *)string TextColor:(UIColor *)color Font:(UIFont *)font
{
    [self addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:[self.string rangeOfString:string]];
    [self addAttribute:NSForegroundColorAttributeName value:color range:[self.string rangeOfString:string]];
    [self addAttribute:NSFontAttributeName value:font range:[self.string rangeOfString:string]];
}


+ (NSMutableAttributedString *)gx_imageWithTitle:(NSString *)imageString
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:imageString];
    attach.bounds = CGRectMake(0, 0, attach.image.size.width, attach.image.size.height);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    [string appendAttributedString:attachString];
    return string;
}

@end
