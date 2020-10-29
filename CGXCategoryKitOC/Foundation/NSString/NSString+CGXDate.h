//
//  NSString+CGXDate.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CGXDate)
/*    在当前时间之前多少时间
 timeStampString : 服务器时间戳 13位
 newDate: 格式 yyyy-MM-dd HH:mm:ss
 timeStr：日期格式 默认 2018-12-15 13:18:36
 */
+ (NSString *)gx_compareCurrentBeforeTimeStampString:(NSString *)timeStampString;
+ (NSString *)gx_compareCurrentBeforeTimeDate:(NSDate *)newDate;
+ (NSString *)gx_compareCurrentBeforeTimeDateFromString:(NSString *)timeStr;

/*    在当前时间之后多少时间
 timeStampString : 服务器时间戳 13位
 newDate: 格式 yyyy-MM-dd HH:mm:ss
 timeStr：日期格式 默认 2018-12-15 13:18:36
 */
+ (NSString *)gx_compareCurrentAfterTimeStampString:(NSString *)timeStampString;
+ (NSString *)gx_compareCurrentAfterTimeDate:(NSDate *)newDate;
+ (NSString *)gx_compareCurrentAfterTimeDateFromString:(NSString *)timeStr;
/*    在当前时间  多少天之后
 timeStampString : 服务器时间戳 13位
 newDate: 格式 yyyy-MM-dd HH:mm:ss
 timeStr：日期格式 默认 2018-12-15 13:18:36
 */
+ (NSString *)gx_compareCurrentAfterDayDateTimeStampString:(NSString *)timeStampString;
+ (NSString *)gx_compareCurrentAfterDayDateFromString:(NSString *)dateFromString;
+ (NSString *)gx_compareCurrentAfterDayDate:(NSDate *)newDate;
/*   倒计时 x年x月x天x时x分x秒
  timeStampString : 服务器时间戳 13位
 dateFromString：日期格式 默认 2018-12-15 13:18:36
 */
+ (NSString *)gx_compareCurrentAfterCountdownTimeStampString:(NSString *)timeStampString;
+ (NSString *)gx_compareCurrentAfterCountdownDateFromString:(NSString *)dateFromString;
/*
 oneDay 相对于anotherDay的时间先后。
 return:  -1  oneDay比 anotherDay时间早
  return:  1  oneDay比 anotherDay时间晚
  return:  0  oneDay比 anotherDay时间相等
 */
+(NSString *)gx_compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
/*   时间戳转换成时间显示
 timeStampString : 服务器时间戳 13位
 dateFromString：日期格式 默认 2018-12-15 13:18:36
 */
+ (NSString *)gx_stringWithDataTimeStampString:(NSString *)timeStampString dateFormat:(NSString *)dateFormatString;
/*   时间戳转换成时间显示
 formatTime : 13位YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时
 dateFromString：日期格式 默认 2018-12-15 13:18:36
 
   北京时间 Asia/Beijing"
 */
+(NSString *)gx_stringWithTimeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
/** 时间戳--->年月日 小时-分 */
+ (NSString *)gx_convertToDateTime:(NSString *)timestamp;
/** 时间戳--->年月日 小时-分-秒 */
+ (NSString *)gx_convertToDateTimer:(NSString *)timestamp;
/** 时间戳--->日期 */
+ (NSString *)gx_convertToDate:(NSString *)timestamp;
#pragma mark --** 时间戳--->时间 */
+ (NSString *)gx_convertToTime:(NSString *)timestamp;
/** 时间---->时间戳 */
+ (NSString *)gx_convertTotimeSp:(NSString *)timeStr;
/**
 *  获得与当前时间的差距
 */
+ (NSString *)gx_timeDifferenceWithNowTimer:(NSString *)timerSp;
/** 时间戳转时间 */
+ (NSString *)gx_timestampToConstellation:(NSString *)timerSp;
/** 根据时间戳算年龄 */
+ (NSString *)gx_timestampToAge:(NSString *)timerSp;
/**
 计算年龄
 @param bornString 出生年月日
 @return 当前年龄
 */
+(NSString *)gx_dateToAge:(NSString *)bornString;
/** 获取手机时间戳 */
+ (NSString *)gx_getCurrentTimeSp;
/** 获取网络时间戳*/
+ (NSString *)gx_getNetworkTimeSp;
// -- 获取当前日期时间 2018-09-18 16:13:55
+ (NSString *)gx_currentDateTime;
// 根据格式获取当前时间,年月日/星期/
+ (NSString*)gx_currentDateTimesWithFormat:(NSString *)format;
// -- 获取当前后几天日期 周日
/**
 获取当前后几天日期 周日
 @param dayCount 后几天
 @return 周几数组
 */
+ (NSMutableArray *)gx_currentDateLaterDate:(int)dayCount;
/**
 获取未来几天日期
 @param dayCount 后几天
 @return 09-16 数组
 */
+ (NSMutableArray *)gx_getDateDurationWithLaterDate:(int)dayCount;
/**
 获取未来几天 年月日
 @param dayCount 后几天
 @return 2018-09-18 数组
 */
+ (NSMutableArray *)gx_getDateDurationYearMD:(int)dayCount;
/**
 这一年的这个月有多少天
 @param year 哪一年
 @param month 那个月 不超过 12
 @return 天数
 */
+ (NSInteger)gx_isAllDayWithYear:(NSInteger)year month:(NSInteger)month;
/**
 根据当前日期计算星期几
 @param inputDateString 系统当前时间  yyyy-MM-dd HH:mm:ss
 @return 星期
 */
+ (NSString*)gx_weekdayStringFromDate:(NSString *)inputDateString;

@end
