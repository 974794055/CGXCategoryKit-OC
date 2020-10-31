//
//  NSString+CGXURLEncode.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (CGXURLEncode)
/**
 *  @brief  urlEncode
 *
 *  @return urlEncode 后的字符串
 */
- (NSString *)gx_urlEncode;
/**
 *  @brief  urlEncode
 *
 *  @param encoding encoding模式
 *
 *  @return urlEncode 后的字符串
 */
- (NSString *)gx_urlEncodeUsingEncoding:(NSStringEncoding)encoding;
/**
 *  @brief  urlDecode
 *
 *  @return urlDecode 后的字符串
 */
- (NSString *)gx_urlDecode;
/**
 *  @brief  urlDecode
 *
 *  @param encoding encoding模式
 *
 *  @return urlDecode 后的字符串
 */
- (NSString *)gx_urlDecodeUsingEncoding:(NSStringEncoding)encoding;

/**
 *  @brief  url query转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)gx_dictionaryFromURLParameters;

//将字典转化为json字符串
- (NSString *)gx_dictionaryToJson:(NSDictionary *)dic;
/**
 *  @brief  JSON字符串转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)gx_dictionaryValue;

@end
