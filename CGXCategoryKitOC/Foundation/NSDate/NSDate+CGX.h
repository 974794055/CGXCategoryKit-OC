//
//  NSDate+CGX.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import "NSDate+CGXExtension.h"

@interface NSDate (CGX)

/**
 * 根据TimeInterval获取时间字符串,带有时区偏移
 */
+(NSString *)gx_stringWithTimeInterval:(unsigned int)time Formatter:(NSString *)format;
/**
 * 根据字符串和格式获取TimeInterval时间,带有时区偏移
 */
+(NSTimeInterval)gx_timeIntervalFromString:(NSString *)timeStr Formatter:(NSString *)format;

/**
 * 当前TimeInterval时间,带有时区偏移
 */
+(NSTimeInterval)gx_timeNow;
/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)gx_timeInfo;
+ (NSString *)gx_timeInfoWithDate:(NSDate *)date;
+ (NSString *)gx_timeInfoWithDateString:(NSString *)dateString;

@end
