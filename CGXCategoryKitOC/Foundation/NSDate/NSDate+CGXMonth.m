//
//  NSDate+CGXMonth.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
#import "NSDate+CGXMonth.h"
#import "NSDate+CGXCompare.h"
#import "NSDate+CGXYear.h"
#import "NSCalendar+CGXExtension.h"
@implementation NSDate (CGXMonth)
- (BOOL)gx_isLeapMonth
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}
- (BOOL)gx_isSameMonthAsDate:(NSDate *_Nonnull)aDate
{
    return ((self.month == aDate.month) &&(self.year == aDate.year));
}
- (BOOL)gx_isThisMonth
{
    return [self gx_isSameMonthAsDate:[NSDate date]];
}

- (BOOL)gx_isLastMonth
{
    return [self gx_isSameMonthAsDate:[[NSDate date] gx_dateByAddingMonths:-1]];
}
- (BOOL)gx_isNextMonth
{
    return [self gx_isSameMonthAsDate:[[NSDate date] gx_dateByAddingMonths:1]];
}
- (NSDate *_Nonnull)gx_monthOfbeginday {
    return [NSDate gx_monthOfbeginday:self];
}
+ (NSDate *_Nonnull)gx_monthOfbeginday:(NSDate *_Nonnull)date
{
        NSCalendar *calendar = [NSCalendar currentCalendar];
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        NSDateComponents *components;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
            components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth  fromDate:date];
        }else{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
            components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
    #pragma clang diagnostic pop
        }
    #else
        NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
    #endif
        return [calendar dateFromComponents:components];
}

- (NSDate *_Nonnull)gx_monthOfEndday {
    return [NSDate gx_monthOfEndday:self];
}
+ (NSDate *_Nonnull)gx_monthOfEndday:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    return [[calendar dateByAddingComponents:components toDate:[date gx_monthOfbeginday] options:0] dateByAddingTimeInterval:-1];
}

- (NSUInteger)gx_endOfMonth:(NSUInteger)month {
    return [NSDate gx_endOfMonth:self month:month];
}
+ (NSUInteger)gx_endOfMonth:(NSDate *_Nonnull)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return date.gx_isLeapYear ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)gx_monthInDays {
    return [NSDate gx_monthInDays:self];
}

+ (NSUInteger)gx_monthInDays:(NSDate *_Nonnull)date {
      NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
      
      return daysInLastMonth.length;
}

+ (NSInteger)gx_monthInFirstDay:(NSDate *_Nonnull)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //设置每周的第一天从周几开始,默认为1,从周日开始
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate     *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday         = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    //若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
    return firstWeekday - 1;
}

- (NSUInteger)gx_monthOfWeeks {
    return [NSDate gx_monthOfWeeks:self];
}

+ (NSUInteger)gx_monthOfWeeks:(NSDate *)date {
    return [[date gx_monthOfEndday] weekOfYear] - [[date gx_monthOfbeginday] weekOfYear] + 1;
}

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
+ (NSString *_Nonnull)gx_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}


@end
