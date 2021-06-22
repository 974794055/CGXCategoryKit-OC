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


/** 时间戳--->年月日 小时-分-秒 */
+ (NSString *)gx_convertToDateTime:(NSString *)timestamp;
/** 时间戳--->年月日 小时-分-秒  format :yyyy-MM-dd HH:mm:ss */
+ (NSString *)gx_convertToDateTime:(NSString *)timestamp Format:(NSString *)format;
/** 时间戳--->日期 */
+ (NSString *)gx_convertToDate:(NSString *)timestamp;
/** 时间---->时间戳   2018-12-15 13:18:36   */
+ (NSString *)gx_convertTotimeSp:(NSString *)timeStr;

/**
 *  获得与当前时间的差距
 */
+ (NSString *)gx_timeDifferenceWithNowTimer:(NSString *)timerSp;
/** 时间戳转星座
 摩羯座 12月22日------1月19日
 水瓶座 1月20日-------2月18日
 双鱼座 2月19日-------3月20日
 白羊座 3月21日-------4月19日
 金牛座 4月20日-------5月20日
 双子座 5月21日-------6月21日
 巨蟹座 6月22日-------7月22日
 狮子座 7月23日-------8月22日
 处女座 8月23日-------9月22日
 天秤座 9月23日------10月23日
 天蝎座 10月24日-----11月21日
 射手座 11月22日-----12月21日
 */
+ (NSString *)gx_timestampToConstellation:(NSString *)timerSp;
/** 根据时间戳算年龄 */
+ (NSString *)gx_timestampToAge:(NSString *)timerSp;
/** 根据出生年月日算年龄 */
+(NSString *)gx_dateToAge:(NSString *)bornString;
/** 获取手机时间戳 */
+ (NSString *)gx_getCurrentTimeSp;
/** 获取网络时间戳*/
+ (NSString *)gx_getNetworkTimeSp;
// -- 获取当前日期时间 2018-09-18 16:13:55
+ (NSString *)gx_currentDateTime;


@end
