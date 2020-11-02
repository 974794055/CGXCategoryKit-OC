//
//  NSDate+CGXTransTime.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CGXTransTime)
/**
 *  将0时区的时间转成0时区的时间戳(10位数)
 */
+ (NSString *)gx_transformToTimestampWithDate:(NSDate *)date;

/**
 *  将0时区的时间戳(10位数)转成0时区的时间
 */
+ (NSDate *)gx_transformToDateWithTimestamp:(NSString *)timestamp;

/**
 *  将0时区的时间戳(10位数)转成8时区的时间文本格式（"yyyy-MM-dd HH:mm:ss"）
 */
+ (NSString *)gx_transformToStringWithTimestamp:(NSString *)timestamp;

/**
 *  将0时区的时间戳(10位数)转成8时区的时间文本格式（"yyyy-MM-dd HH:mm:ss"）,带有只有时分的
 */
+ (NSString *)gx_transformToHourMiniteFormatWithTimestamp:(NSString *)timestamp;

/**
 *  将8时区的时间文本格式（"yyyy-MM-dd HH:mm:ss”）转成 0时区的时间戳(10位数)
 */
+ (NSString *)gx_transformToTimestampWithString:(NSString *)string;

/**
 *  将8时区的时间文本格式（“yyyy-MM-dd HH:mm:ss”）转成 0时区的NSDate
 */
+ (NSDate *)gx_transformToDateWithString:(NSString *)string;

/**
 *  将0时区的NSDate转成 8时区的时间文本格式（“yyyy-MM-dd HH:mm:ss”）
 */
+ (NSString *)gx_transformToStringWithDate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
