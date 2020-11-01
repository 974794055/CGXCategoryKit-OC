//
//  NSString+CGXSecurity.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+CGXExtension.h"
@interface NSString (CGXSecurity)
/**
 *  当前字符串(明文)转成base64编码之后的字符串
 *  @return 当前字符串(明文)转成base64编码之后的字符串
 */
- (NSString *)gx_base64EncodeString;

/**
 *  当前字符串(base64编码过的)转成base64解码之后的字符串
 *  @return 当前字符串(base64编码过的)转成base64解码之后的字符串
 */
- (NSString *)gx_base64DecodeString;

@end
