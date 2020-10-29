//
//  NSMutableAttributedString+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (CGXExtension)

/** 返回AttributedString属性 */
+ (NSMutableAttributedString *)gx_attributeWithStr:(NSString *)str;

@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

/**
 
 *  需要修改的字符颜色数组及量程，由字典组成  key = 颜色   value = 量程或需要修改的字符串
 *  例：NSArray *gx_colorsOfRanges = @[@{color:@[@"0",@"1"]},@{color:@[@"1",@"2"]}]
 *  或：NSArray *gx_colorsOfRanges = @[@{color:str},@{color:str}]
 */
- (void)gx_colorsOfRanges:(NSArray <NSDictionary *>*)gx_colorsOfRanges;

/**
 
 *  需要修改的字符字体数组及量程，由字典组成  key = 颜色   value = 量程或需要修改的字符串
 *  例：NSArray *gx_fontsOfRanges = @[@{font:@[@"0",@"1"]},@{font:@[@"1",@"2"]}]
 *  或：NSArray *gx_fontsOfRanges = @[@{font:str},@{font:str}]
 */
- (void)gx_fontsOfRanges:(NSArray <NSDictionary *>*)gx_fontsOfRanges;

/** 设置行间距 */
- (void)gx_setLineSpacing:(CGFloat)lineSpacing string:(NSString *)string;

/** 设置字间距 */
- (void)gx_setWordsSpacing:(CGFloat)wordsSpacing string:(NSString *)string;

/** 添加下划线 */
- (void)gx_addUnderlineWithString:(NSString *)string;
- (void)gx_addUnderlineWithString:(NSString *)string TextColor:(UIColor *)color;
- (void)gx_addUnderlineWithString:(NSString *)string TextColor:(UIColor *)color Font:(UIFont *)font;

/** 添加中划线 */
- (void)gx_addHorizontalLineWithString:(NSString *)string;
- (void)gx_addHorizontalLineWithString:(NSString *)string TextColor:(UIColor *)color;
- (void)gx_addHorizontalLineWithString:(NSString *)string TextColor:(UIColor *)color Font:(UIFont *)font;



+ (NSMutableAttributedString *)gx_imageWithTitle:(NSString *)imageString;

@end

NS_ASSUME_NONNULL_END
