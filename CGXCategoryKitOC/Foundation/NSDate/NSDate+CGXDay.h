//
//  NSDate+CGXDay.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+CGXExtension.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CGXDay)

/**
 *  是否是同一天
 */
- (BOOL)gx_isSameDayAsDate:(NSDate *_Nonnull)aDate;
/**
 *  是否为今天
 */
- (BOOL)gx_isToday;
/**
 *  是否为昨天
 */
- (BOOL)gx_isYesterday;
/**
 *  是否为明天
 */
- (BOOL)gx_isTomorrowDay;

/**
 *  是否是工作日
 */
- (BOOL)gx_isWorkday;
/**
 *  是否是周末
 */
- (BOOL)gx_isWeekEnd;

- (NSDate *)gx_dayOfbegin;

- (NSDate *)gx_dayOfend;

///明天
+ (NSDate *)gx_dayTomorrow;
///昨天
+ (NSDate *)gx_dayYesterday;
///今天后几天
+ (NSDate *)gx_dateWithDaysFromNow:(NSInteger)days;
///今天前几天
+ (NSDate *)gx_dateWithDaysBeforeNow:(NSInteger)days;

///某天后几天
+ (NSDate *)gx_dateWithDaysFromNow:(NSInteger)days AsDate:(NSDate *_Nonnull)aDate;;
///某天前几天
+ (NSDate *)gx_dateWithDaysBeforeNow:(NSInteger)days AsDate:(NSDate *_Nonnull)aDate;;


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

#pragma mark - 这一年的这个月有多少天
+ (NSInteger)gx_isAllDayWithYear:(NSInteger)year month:(NSInteger)month;



@end

NS_ASSUME_NONNULL_END
