//
//  CGXCategoryDateFormatterPool.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryDateFormatterPool : NSObject
+ (instancetype)new NS_UNAVAILABLE;

/**
 单例管理

 @return instance WBDateFormatterPool.
 */
+ (instancetype)shareInstance;

/**
 Get date formatter by format string, the default locale is [NSLocale currentLocale]

 @param format date format string, example: @"yyyy-MM-dd hh:mm:ss"
 @return NSDateFormatter
 */
- (NSDateFormatter *)gx_dateFormatterWithFormat:(NSString *)format;

/**
 Get date formatter by format string, localeIdentifier, timeZoneName.

 @param format date format.
 @param identifier locale identifier.
 @param timeZoneName timeZone name string.
 @return NSDateFormatter.
 */
- (NSDateFormatter *)gx_dateFormatterWithFormat:(NSString *)format
                               localeIdentifier:(nullable NSString *)identifier
                                   timeZoneName:(nullable NSString *)timeZoneName;
@end

NS_ASSUME_NONNULL_END


/*
格式化参数如下：
G: 公元时代，例如AD公元
yy: 年的后2位
yyyy: 完整年
MM: 月，显示为1-12
MMM: 月，显示为英文月份简写,如 Jan
MMMM: 月，显示为英文月份全称，如 Janualy
dd: 日，2位数表示，如02
d: 日，1-2位显示，如 2
EEE: 简写星期几，如Sun
EEEE: 全写星期几，如Sunday
aa: 上下午，AM/PM
H: 时，24小时制，0-23
K：时，12小时制，0-11
m: 分，1-2位
mm: 分，2位
s: 秒，1-2位
ss: 秒，2位

S: 毫秒

常用日期结构：
yyyy-MM-dd HH:mm:ss.SSS
yyyy-MM-dd HH:mm:ss
yyyy-MM-dd
MM dd yyyy
 
 zzz表示时区
 
 *  //常用日期结构：yyyy-MM-dd HH:mm:ss.SSS EEEE zzz
 * localeIdentifier:  默认 @"en_US"
 *    @"en_US"  美国英语
 *    @"zh_CN" 简体中文
 */
