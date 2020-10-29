//
//  NSObject+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CGXExtension)
/**
 *  转换成JSON串字符串（没有可读性）
 *  @return JSON字符串
 */
- (NSString *)gx_toJSONString;
/**
 *  转换成JSON串字符串（有可读性）
 *  @return JSON字符串
 */
- (NSString *)gx_toReadableJSONString;

/**
 *    过滤所有nil和null对象。
 *    @param object    The object to be filtered.
 */
+ (id)gx_tofilterNullNilFromObject:(id)object;
/**
 *    将对象转换为json数据。
 *    @param object    Any kind of object.
 *    @return json data object if transform successfully, otherwise return nil.
 */
+ (NSMutableData *)gx_toJSONDataWithObject:(id)object;
/**
 *    将对象转换为json字符串。
 *    @param object    Any kind of object
 *    @return json string if transform successfully, otherwise return nil.
 */
+ (NSString *)gx_toJSONStringWithObject:(id)object;
/**
 *  转换成JSON数据
 *  @return JSON数据
 */
- (NSData *)gx_toJSONData;


@end

NS_ASSUME_NONNULL_END
