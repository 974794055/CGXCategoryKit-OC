//
//  NSDate+CGXTime.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+CGXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CGXTime)

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)gx_formatYMD;
- (NSString *)gx_formatYMDHMS;
- (NSString *)gx_formatYMDHMSFormat:(NSString *_Nonnull)format;

+ (NSString *)gx_formatYMD:(NSDate *)date;
+ (NSString *)gx_formatYMDHMS:(NSDate *)date;
+ (NSString *)gx_formatYMDHMS:(NSDate *)date Format:(NSString *_Nonnull)format;
/**
 *  从时间字符串得到时间
 * 日期格式  @"yyyy-MM-dd HH:mm:ss:SSS EEEE"
 *  @param dateString 时间字符串  "2020-05-23 12:24:39"
    @param format 格式                    "yyyy-MM-dd HH:mm:ss"
 *  @return NSDate
 */
+ (NSDate *_Nonnull)gx_dateFromString:(NSString *_Nonnull)dateString
                            format:(NSString *_Nonnull)format;
+ (NSDate *_Nonnull)gx_dateFromString:(NSString *_Nonnull)dateString
                            format:(NSString *_Nonnull)format
                  localeIdentifier:(nullable NSString *)identifier
                      timeZoneName:(nullable NSString *)timeZoneName;;
/**
 *  时间转换字符串
 *
 *  @param date 时间
 *  @param format 格式
 *  @return 时间字符串
 */
+ (NSString *)gx_dateStringFromDate:(NSDate *)date
                             format:(NSString *)format;
/**
 *  通过时间戳得出时间字符串
 *
 *  @param timestamp 时间戳，如：@"1447400310"   10位或者13位时间戳
 *  @param formatter 时间格式  "yyyy-MM-dd HH:mm:ss"
 *  @return 时间字符串
 */
+ (NSString *)gx_dateStringWithTimestamp:(NSTimeInterval)timestamp
                               formatter:(NSString*)formatter;


/**
 *  通过时间戳得出显示时间（NSCalendar方式）
 *
 *  @param timestamp 时间戳
 *  @return 例如：2017年5月14日
 */
+ (NSString *)gx_dateStringYMDWithTimestamp:(NSTimeInterval)timestamp;


/**
 *  日期转换成转13时间戳
 */
+ (NSTimeInterval)gx_timeIntervalSince1970FromString:(NSString *)dateString;


@end

NS_ASSUME_NONNULL_END
