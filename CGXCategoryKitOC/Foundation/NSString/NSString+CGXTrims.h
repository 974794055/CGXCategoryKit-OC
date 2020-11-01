//
//  NSString+CGXTrims.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CGXTrims)
/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)gx_stringByStrippingHTML;
/**
 *  @brief  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)gx_stringByRemovingScriptsAndStrippingHTML;
/**
 *  @brief  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)gx_trimmingWhitespace;
/**
 *  @brief  去除字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (NSString *)gx_trimmingWhitespaceAndNewlines;


/** 去除字符串两端的空格 */
+ (NSString *)gx_trimmingWipeBothEndsSpaceFromStr:(NSString *)str;

/**
 *  去除字符串中的特定符号
 *  @param str 需要去除指定字符的字符串
 *  @param appointSymbol  指定的字符,如#、!
 *  @param replacement  要替换的字符(可以为空)
 */
+ (NSString *)gx_wipeAppointSymbolFromStr:(NSString *)str AppointSymbol:(NSString *)appointSymbol WithStr:(NSString *)replacement;

/** 格式化HTML代码 */
+ (NSString *)gx_htmlEntityDecode:(NSString *)string;

+ (NSString *)gx_changeHTMLText:(NSString *)bbsContent;


@end
