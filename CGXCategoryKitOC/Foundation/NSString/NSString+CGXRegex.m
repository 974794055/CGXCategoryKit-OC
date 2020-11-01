//
//  NSString+CGXRegex.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//
#import "NSString+CGXRegex.h"

@implementation NSString (CGXRegex)

/**
 * 通过 regexTEXT 进行匹配
 */
- (BOOL)gx_regexMatchWithPattern:(NSString*)pattern {
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}

/**
 * 基本匹配
 */
- (BOOL)gx_regexMatchWithType:(CGXRegexType)rType {
    // 默认支持空字符串返回为YES的情况
    return [self gx_regexMatchWithType:rType returnWhenEmpty:YES];
}

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 */
- (BOOL)gx_regexMatchWithType:(CGXRegexType)rType returnWhenEmpty:(BOOL)empty {
    if (rType == CGXRegexTypeNone) {
        // 没有任何的限制
        return YES;
    }
    
    if (self.length == 0) {
        return empty;
    }
    
    // 非空, 进行基本匹配
    NSString *regex = [self p_regexMatchesWithType:rType];
    return [self gx_regexMatchWithPattern:regex];
}

/**
 * 基本匹配: 默认支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)gx_regexMatchWithType:(CGXRegexType)rType maxLimitLength:(NSUInteger)maxLimit {
    return [self gx_regexMatchWithType:rType maxLimitLength:maxLimit returnWhenEmpty:YES ];
}

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)gx_regexMatchWithType:(CGXRegexType)rType maxLimitLength:(NSUInteger)maxLimit returnWhenEmpty:(BOOL)empty {
    if (self.length > maxLimit) {
        return NO;
    }
    
    return [self gx_regexMatchWithType:rType returnWhenEmpty:empty];
}

#pragma mark -
#pragma mark - private
- (NSString*)p_regexMatchesWithType:(CGXRegexType)rType {
    
    NSString *regex = @"";
    if (rType & CGXRegexTypeDigital) {
        // 数字
        regex = [NSString stringWithFormat:@"%@\\d", regex];
    }
    
    if (rType & CGXRegexTypeChinese) {
        // 中文
        regex = [NSString stringWithFormat:@"➋➌➍➎➏➐➑➒%@\u4e00-\u9fa5", regex];
    }
    
    if (rType & CGXRegexTypeCharacter) {
        // 字符
        regex = [NSString stringWithFormat:@"%@a-zA-Z", regex];
    }
    
    if (rType & CGXRegexTypeSpace) {
        // 空格
        regex = [NSString stringWithFormat:@"%@ ", regex];
    }
    
    if (rType & CGXRegexTypeUnderline) {
        // 下划线
        regex = [NSString stringWithFormat:@"%@_", regex];
    }
    
    if (rType & CGXRegexTypeDot) {
        // 点
        regex = [NSString stringWithFormat:@"%@.", regex];
    }
    
    if (rType & CGXRegexTypeAT) {
        // @
        regex = [NSString stringWithFormat:@"%@@", regex];
    }
    
    regex = [NSString stringWithFormat:@"^[%@]+$", regex];
    return regex;
}

- (NSString *)gx_replaceStringInPattern:(NSString *)pattern withString:(NSString *)toString {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSString *retStr = [self copy];
    if (result) {
        for (int i = 0; i<result.count; i++) {
            NSTextCheckingResult *res = result[i];
            retStr = [retStr stringByReplacingOccurrencesOfString:[self substringWithRange:res.range]
                                                       withString:toString];
        }
    }
    return retStr;
}

@end
