//
//  NSDate+CGXMonth.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+CGXExtension.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CGXMonth)
/**
 *  是否是同一月
 */
- (BOOL)gx_isSameMonthAsDate:(NSDate *_Nonnull)aDate;
/**
 *  是否当月
 */
- (BOOL)gx_isThisMonth;
/**
 *  是否下月
 */
- (BOOL)gx_isNextMonth;
/**
 *  是否上月
 */
- (BOOL)gx_isLastMonth;
/**
 *  是否是闰月
 */
- (BOOL)gx_isLeapMonth;
/**
 * 获取该月的第一天的日期
 */
- (NSDate *_Nonnull)gx_monthOfbeginday;
+ (NSDate *_Nonnull)gx_monthOfbeginday:(NSDate *_Nonnull)date;
/**
 * 获取该月的最后一天的日期
 */
- (NSDate *_Nonnull)gx_monthOfEndday;
+ (NSDate *_Nonnull)gx_monthOfEndday:(NSDate *_Nonnull)date;
/**
 * 获取当前月份的天数
 */
- (NSUInteger)gx_monthInDays;
+ (NSUInteger)gx_monthInDays:(NSDate *_Nonnull)date;
/**
* 获取当月第一天周几
*/
+ (NSInteger)gx_monthInFirstDay:(NSDate *_Nonnull)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)gx_monthOfWeeks;
+ (NSUInteger)gx_monthOfWeeks:(NSDate *)date;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *_Nonnull)gx_monthWithMonthNumber:(NSInteger)month;


@end

NS_ASSUME_NONNULL_END
