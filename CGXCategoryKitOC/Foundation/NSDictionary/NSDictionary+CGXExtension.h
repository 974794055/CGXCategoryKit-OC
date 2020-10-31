//
//  NSDictionary+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (CGXExtension)
/**
 *  判断是否为空或为空格
 *
 *  @return YES OR NOT
 */
- (BOOL)gx_isEmpty;

/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)gx_JSONString;
/**
 *  @brief  将NSDictionary转换成XML 字符串
 *
 *  @return XML 字符串
 */
- (NSString *)gx_XMLString;

- (NSDictionary *)gx_removeNulls;

//获得一般模型属性
-(void)gx_createProperty;

//获得网络模型属性
-(void)gx_createNetProperty;

/**
 *  json的二进制数据NSData通过NSJSONSerialization转换为NSDictionary
 *
 *  @param jsonData json的二进制数据NSData
 *
 *  @return NSDictionary，失败时返回nil
 */
+ (NSDictionary *)gx_dictionaryWithJsonData:(NSData *)jsonData;

/**
 *  json的字符串数据NSString通过NSJSONSerialization转换为NSDictionary
 *
 *  @param jsonString json的字符串数据NSString
 *
 *  @return NSDictionary，失败时返回nil
 */
+ (NSDictionary *)gx_dictionaryWithJsonString:(NSString *)jsonString;



@end

NS_ASSUME_NONNULL_END
