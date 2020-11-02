//
//  NSDate+CGXWeek.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDate+CGXWeek.h"
#import "NSDate+CGXMonth.h"
#import "NSDate+CGXCompare.h"
#define CGX_WEEK        604800

@implementation NSDate (CGXWeek)
// This hard codes the assumption that a week is 7 days
- (BOOL)gx_isSameWeekAsDate:(NSDate *_Nonnull)aDate
{
    return [NSDate gx_isSameWeekAsDate:aDate andSecDate:self];
}
+ (BOOL)gx_isSameWeekAsDate:(NSDate *_Nonnull)aDate andSecDate:(NSDate *_Nonnull)bDate
{
        // 日历对象
        NSCalendar *calendar = [NSCalendar currentCalendar];
        // 一周开始默认为星期天=1。
        calendar.firstWeekday = 2;
        
        unsigned unitFlag = NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear;
        NSDateComponents *comp1 = [calendar components:unitFlag fromDate:aDate];
        NSDateComponents *comp2 = [calendar components:unitFlag fromDate:bDate];
        /// 年份和周数相同，即判断为同一周
        /// NSCalendarUnitYearForWeekOfYear已经帮转换不同年份的周所属了，比如2019.12.31是等于2020的。这里不使用year，使用用yearForWeekOfYear
        return (([comp1 yearForWeekOfYear] == [comp2 yearForWeekOfYear]) && ([comp1 weekOfYear] == [comp2 weekOfYear]));
}
- (BOOL)gx_isThisWeek
{
    return [NSDate gx_isThisWeek:self];
}
+ (BOOL)gx_isThisWeek:(NSDate *)aDate{
    return [self gx_isSameWeekAsDate:aDate andSecDate:[NSDate date]];
}
- (BOOL)gx_isNextWeek
{
    return [NSDate gx_isNextWeek:self];
}
+ (BOOL)gx_isNextWeek:(NSDate *)aDate {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + CGX_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self gx_isSameWeekAsDate:aDate andSecDate:newDate];
}
- (BOOL)gx_isLastWeek
{
    return [NSDate gx_isLastWeek:self];
}
+ (BOOL)gx_isLastWeek:(NSDate *)aDate {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - CGX_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self gx_isSameWeekAsDate:aDate andSecDate:newDate];;
}


- (NSInteger)gx_weekday {
    return [NSDate gx_weekday:self];
}

+ (NSInteger)gx_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}
- (NSUInteger)gx_weekOfYear {
    return [NSDate gx_weekOfYear:self];
}

+ (NSUInteger)gx_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date year];
    
    NSDate *lastdate = [date gx_monthOfEndday];
    
    for (i = 1;[[lastdate gx_dateByAddingDays:-7 * i] year] == year; i++) {
        
    }
    
    return i;
}

- (NSString *_Nonnull)gx_dayFromWeekday {
    return [NSDate gx_dayFromWeekday:self];
}

+ (NSString *_Nonnull)gx_dayFromWeekday:(NSDate *_Nonnull)date {
    switch(date.weekday) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}
+ (NSString*)gx_weekdayStringFromDate:(NSString *)inputDateString
{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate = [inputFormatter dateFromString:inputDateString];
    
    
    NSArray *weekdays = [NSArray arrayWithObjects: @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday - 1];
}
- (NSDate *)gx_weekOfBegin {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.firstWeekday = 1;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:self];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:self];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit |NSWeekdayCalendarUnit| NSDayCalendarUnit fromDate:self];
#endif

    NSUInteger offset = ([components weekday] == [calendar firstWeekday]) ? 7 : [components weekday] - 2;
    [components setDay:[components day] - offset];

    return [calendar dateFromComponents:components];
}

- (NSDate *)gx_weekOfEnd {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.firstWeekday = 1;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfMonth:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self gx_weekOfBegin] options:0] dateByAddingTimeInterval:-1];
}
- (NSDate*)gx_weekOfPrevious {
    return [self dateByAddingTimeInterval:-(86400*7)];
}

- (NSDate*)gx_weekOfNext {
    return [self dateByAddingTimeInterval:+(86400*7)];
}


/**
当前周的日期开始时间

@param firstWeekday 星期起始日
@param dateFormat 日期格式
@return 时间
*/
+ (NSDate *)gx_currentWeekBegin:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat
{
    return [NSDate gx_currentWeekBegin:firstWeekday dateFormat:dateFormat date:[NSDate date]];
}
+ (NSDate *)gx_currentWeekBegin:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat date:(NSDate *)adate
{
    NSCalendar *calendar = [self gx_currentDayCalendarWeek:firstWeekday];;
    // 获取这周的第一天日期
    NSDateComponents *firstComponents = [self gx_currentComponentsWeek:firstWeekday dateFormat:dateFormat date:adate];
    NSDate *firstDate = [calendar dateFromComponents:firstComponents];
    return firstDate;
}
/**
当前周的日期结束时间

@param firstWeekday 星期起始日
@param dateFormat 日期格式
@return 时间
*/
+ (NSDate *)gx_currentWeekEnd:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat
{
    return [NSDate gx_currentWeekEnd:firstWeekday dateFormat:dateFormat date:[NSDate date]];
}
+ (NSDate *)gx_currentWeekEnd:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat date:(NSDate *)adate
{
    NSCalendar *calendar = [self gx_currentDayCalendarWeek:firstWeekday];
    NSDateComponents *firstComponents = [self gx_currentComponentsWeek:firstWeekday dateFormat:dateFormat date:adate];
    // 获取这周的最后一天日期
    NSDateComponents *lastComponents = firstComponents;
    [lastComponents setDay:firstComponents.day + 6];
    
    [lastComponents setHour:23];
    [lastComponents setMinute:59];
    [lastComponents setSecond:59];
    
    NSDate *lastDate = [calendar dateFromComponents:lastComponents];
    return lastDate;
}
+ (NSCalendar *)gx_currentDayCalendarWeek:(NSUInteger)firstWeekday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    // 1.周日 2.周一 3.周二 4.周三 5.周四 6.周五  7.周六
    calendar.firstWeekday = firstWeekday;
    return calendar;
}

+ (NSDateComponents *)gx_currentComponentsWeek:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat date:(NSDate *)nowDate
{
    NSCalendar *calendar = [self gx_currentDayCalendarWeek:firstWeekday];
    // 日历单元
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    unsigned unitNewFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowComponents = [calendar components:unitFlag fromDate:nowDate];
    // 获取今天是周几，需要用来计算
    NSInteger weekDay = [nowComponents weekday];
    // 获取今天是几号，需要用来计算
    NSInteger day = [nowComponents day];
    // 计算今天与本周第一天的间隔天数
    NSInteger countDays = 0;
    // 特殊情况，本周第一天firstWeekday比当前星期weekDay小的，要回退7天
    if (calendar.firstWeekday > weekDay) {
        countDays = 7 + (weekDay - calendar.firstWeekday);
    } else {
        countDays = weekDay - calendar.firstWeekday;
    }
    // 获取这周的第一天日期
    NSDateComponents *firstComponents = [calendar components:unitNewFlag fromDate:nowDate];
    [firstComponents setDay:day - countDays];
    return firstComponents;
}
/**
 当前周的日期范围

 @param firstWeekday 星期起始日
 @param dateFormat 日期格式
 @return 结果字符串
 */
+ (NSString *)gx_currentWeekScope:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat
{
 return [NSDate gx_currentWeekScope:firstWeekday dateFormat:dateFormat date:[NSDate date]];
}
+ (NSString *)gx_currentWeekScope:(NSUInteger)firstWeekday dateFormat:(NSString *)dateFormat date:(NSDate *)adate
{
    NSDate *firstDate = [self gx_currentWeekBegin:firstWeekday dateFormat:dateFormat date:adate];
    NSDate *lastDate = [self gx_currentWeekEnd:firstWeekday dateFormat:dateFormat date:adate];
    // 输出
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *firstDay = [formatter stringFromDate:firstDate];
    NSString *lastDay = [formatter stringFromDate:lastDate];
    
    return [NSString stringWithFormat:@"%@ - %@",firstDay,lastDay];
}

@end
