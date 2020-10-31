//
//  NSString+CGXRegex.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

// 基本匹配 : 数字, 汉字, 字符, 空格, 下划线, 点, @
typedef NS_OPTIONS(NSUInteger, CGXRegexType) {
    CGXRegexTypeNone      = 0 << 0, // 未知
    CGXRegexTypeDigital   = 1 << 0, // 数字
    CGXRegexTypeChinese   = 1 << 1, // 汉字
    CGXRegexTypeCharacter = 1 << 2, // 字符
    CGXRegexTypeSpace     = 1 << 3, // 空格
    CGXRegexTypeUnderline = 1 << 4, // 下划线
    CGXRegexTypeDot       = 1 << 5, // 点
    CGXRegexTypeAT        = 1 << 6, // @
};

// 是否支持空字符串

@interface NSString (CGXRegex)

/**
 * 通过 pattern 进行匹配
 */
- (BOOL)gx_regexMatchWithPattern:(NSString*)pattern;

/**
 * 基本匹配: 默认支持空字符串返回为YES的情况
 */
- (BOOL)gx_regexMatchWithType:(CGXRegexType)rType;

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 */
- (BOOL)gx_regexMatchWithType:(CGXRegexType)rType returnWhenEmpty:(BOOL)empty;

/**
 * 基本匹配: 默认支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)gx_regexMatchWithType:(CGXRegexType)rType
                maxLimitLength:(NSUInteger)maxLimit;

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)gx_regexMatchWithType:(CGXRegexType)rType maxLimitLength:(NSUInteger)maxLimit returnWhenEmpty:(BOOL)empty ;

// 替换字符串
- (NSString*)gx_replaceStringInPattern:(NSString *)pattern withString:(NSString*)toString;

@end
