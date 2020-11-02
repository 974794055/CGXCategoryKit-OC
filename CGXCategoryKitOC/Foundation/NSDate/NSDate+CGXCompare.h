//
//  NSDate+CGXCompare.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+CGXExtension.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CGXCompare)

/**
 *  早于当前日期
 */
- (BOOL)gx_isEarlierThanDate:(NSDate *_Nonnull)aDate;
/**
 *  晚于当前日期
 */
- (BOOL)gx_isLaterThanDate:(NSDate *_Nonnull)aDate;
///是否是未来
- (BOOL)gx_isInFuture;
///是否是过去
- (BOOL)gx_isInPast;
/**
 Returns a date representing the receiver date shifted later by the provided number of years.
 返回当前时间 相差的时间
 正数表示   xx之前
 正数表示   xx之后
 返回xx前或者后的日期
 */
- (NSDate *_Nonnull)gx_dateByAddingYears:(NSInteger)years;
- (NSDate *_Nonnull)gx_dateByAddingMonths:(NSInteger)months;
- (NSDate *_Nonnull)gx_dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *_Nonnull)gx_dateByAddingDays:(NSInteger)days;
- (NSDate *_Nonnull)gx_dateByAddingHours:(NSInteger)hours;
- (NSDate *_Nonnull)gx_dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *_Nonnull)gx_dateByAddingSeconds:(NSInteger)seconds;

/**
 // Retrieving intervals
 返回当前时间 相差的时间
 */
///比aDate晚多少分钟
- (NSInteger)gx_dateminutesAfterDate:(NSDate *_Nonnull)aDate;
///比aDate早多少分钟
- (NSInteger)gx_dateminutesBeforeDate:(NSDate *_Nonnull)aDate;
///比aDate晚多少小时
- (NSInteger)gx_datehoursAfterDate:(NSDate *_Nonnull)aDate;
///比aDate早多少小时
- (NSInteger)gx_datehoursBeforeDate:(NSDate *_Nonnull)aDate;
///比aDate晚多少天
- (NSInteger)gx_datedaysAfterDate:(NSDate *_Nonnull)aDate;
///比aDate早多少天
- (NSInteger)gx_datedaysBeforeDate:(NSDate *_Nonnull)aDate;
/** 获取两个日期之间的时间差(天) **/
+ (NSInteger)gx_getDayBetweenWithDateOne:(NSDate *_Nonnull)dateOne withdateTwo:(NSDate *_Nonnull)dateTwo;
// 计算两个日期之间相差天数
+ (NSDateComponents *_Nonnull)gx_calcDaysbetweenDate:(NSString *_Nonnull)startDateStr endDateStr:(NSString *_Nonnull)endDateStr;

///与anotherDate间隔几天
- (NSInteger)gx_distanceDaysToDate:(NSDate *)anotherDate;
///与anotherDate间隔几月
- (NSInteger)gx_distanceMonthsToDate:(NSDate *)anotherDate;
///与anotherDate间隔几年
- (NSInteger)gx_distanceYearsToDate:(NSDate *)anotherDate;


/*
 oneDay 相对于anotherDay的时间先后。
 return:  -1  oneDay比 anotherDay时间早
  return:  1  oneDay比 anotherDay时间晚
  return:  0  oneDay比 anotherDay时间相等
 */
+(NSString *)gx_compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

@end

NS_ASSUME_NONNULL_END
