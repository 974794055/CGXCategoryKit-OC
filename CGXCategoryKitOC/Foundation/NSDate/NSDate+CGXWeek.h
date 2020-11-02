//
//  NSDate+CGXWeek.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+CGXExtension.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CGXWeek)

/**
 *  是否是同一周
 */
- (BOOL)gx_isSameWeekAsDate:(NSDate *_Nonnull)aDate;
/**
 *  是不是本周
 *  @param aDate 日期
 *  @return NSDate类型
 */
+ (BOOL)gx_isThisWeek:(NSDate *)aDate;
- (BOOL)gx_isThisWeek;
/**
 *  是不是下一周
 *  @param aDate 日期
 *  @return 是否相等
 */
+ (BOOL)gx_isNextWeek:(NSDate *)aDate;
- (BOOL)gx_isNextWeek;
/**
 *  是不是上一周
 *  @param aDate 日期
 *  @return 是否相等
 */
+ (BOOL)gx_isLastWeek:(NSDate *)aDate;
- (BOOL)gx_isLastWeek;
/**
 *  获取星期几
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)gx_weekday;
+ (NSInteger)gx_weekday:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)gx_weekOfYear;
+ (NSUInteger)gx_weekOfYear:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *_Nonnull)gx_dayFromWeekday;
+ (NSString *_Nonnull)gx_dayFromWeekday:(NSDate *_Nonnull)date;
/**
 根据当前日期计算星期几
 @param inputDateString 系统当前时间  yyyy-MM-dd HH:mm:ss
 @return 星期
 */
+ (NSString*)gx_weekdayStringFromDate:(NSString *)inputDateString;

- (NSDate *)gx_weekOfBegin;
- (NSDate *)gx_weekOfEnd;
- (NSDate *)gx_weekOfPrevious;
- (NSDate *)gx_weekOfNext;

/**
 当前周的日期范围

 @param firstWeekday 星期起始日
 @param dateFormat 日期格式
 @return 结果字符串
 */
+ (NSString *)gx_currentWeekScope:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat;
+ (NSString *)gx_currentWeekScope:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat date:(NSDate *)adate;;
/**
当前周的日期开始时间

@param firstWeekday 星期起始日
@param dateFormat 日期格式
@return 时间
*/
+ (NSDate *)gx_currentWeekBegin:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat;
+ (NSDate *)gx_currentWeekBegin:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat date:(NSDate *)adate;
/**
当前周的日期结束时间

@param firstWeekday 星期起始日
@param dateFormat 日期格式
@return 时间
*/
+ (NSDate *)gx_currentWeekEnd:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat;
+ (NSDate *)gx_currentWeekEnd:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat date:(NSDate *)adate;
@end

NS_ASSUME_NONNULL_END
