//
//  NSString+CGXSecurity.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSString+CGXSecurity.h"

@implementation NSString (CGXSecurity)

- (NSString *)gx_base64EncodeString
{
    if(![self gx_isEmpty])
    {
        // 将“源字符串”转成二进制(因base64的编解码都是针对二进制的)
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        
        // 返回二进制编码后的字符串
        return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    else
    {
        return @"";
    }
}

- (NSString *)gx_base64DecodeString
{
    if(![self gx_isEmpty])
    {
        // 编码后的字符串转成二进制
        NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        // 返回二进制解码后的字符串
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else
    {
        return @"";
    }
}
@end
