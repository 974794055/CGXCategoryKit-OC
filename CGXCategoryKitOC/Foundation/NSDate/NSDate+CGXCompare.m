//
//  NSDate+CGXCompare.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDate+CGXCompare.h"

#import "CGXCategoryDateFormatterPool.h"
#define D_MINUTE    60
#define D_HOUR        3600
#define D_DAY        86400
#define D_WEEK        604800
#define D_YEAR        31556926


@implementation NSDate (CGXCompare)

- (BOOL)gx_isEarlierThanDate: (NSDate *_Nonnull) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)gx_isLaterThanDate: (NSDate *_Nonnull) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}
- (BOOL)gx_isInFuture
{
    return ([self compare:[NSDate date]] == NSOrderedDescending);
}
- (BOOL)gx_isInPast
{
    return ([self compare:[NSDate date]] == NSOrderedAscending);
}

- (NSDate *_Nonnull)gx_dateByAddingYears:(NSInteger)years {
    
    //    if (fromDate == nil) {
    //        return nil;
    //    }
    //
    //    NSCalendar *gregorian = [[NSCalendar alloc]
    //                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}
- (NSDate *_Nonnull)gx_dateByAddingMonths:(NSInteger)months {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}
- (NSDate *_Nonnull)gx_dateByAddingWeeks:(NSInteger)weeks {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *_Nonnull)gx_dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + 24 * 60 * 60 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *_Nonnull)gx_dateByAddingHours:(NSInteger)hours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + 60 * 60 * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *_Nonnull)gx_dateByAddingMinutes:(NSInteger)minutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + 60 * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *_Nonnull)gx_dateByAddingSeconds:(NSInteger)seconds {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}


- (NSInteger)gx_dateminutesAfterDate:(NSDate *_Nonnull)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)gx_dateminutesBeforeDate:(NSDate *_Nonnull)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)gx_datehoursAfterDate:(NSDate *_Nonnull)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)gx_datehoursBeforeDate:(NSDate *_Nonnull)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)gx_datedaysAfterDate:(NSDate *_Nonnull)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)gx_datedaysBeforeDate:(NSDate *_Nonnull)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}


/** 获取两个日期之间的时间差(天) **/
+ (NSInteger)gx_getDayBetweenWithDateOne:(NSDate *_Nonnull)dateOne withdateTwo:(NSDate *_Nonnull)dateTwo
{
    if(dateOne && dateTwo){
        NSInteger timediff = (NSInteger)[dateTwo timeIntervalSince1970]-[dateOne timeIntervalSince1970];
        NSInteger oneDaySecs = 24*60*60;
        NSInteger day = timediff/oneDaySecs;
        return day;
    }
    return 0;
}
//计算两个日期之间相差天数
+ (NSDateComponents *_Nonnull)gx_calcDaysbetweenDate:(NSString *_Nonnull)startDateStr endDateStr:(NSString *_Nonnull)endDateStr {
    NSDateFormatter *dateFormatter = [[CGXCategoryDateFormatterPool shareInstance] gx_dateFormatterWithFormat:@"yyyy-MM-dd"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate          *startDate     = [dateFormatter dateFromString:startDateStr];
    NSDate          *endDate       = [dateFormatter dateFromString:endDateStr];
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth;
    
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    
    return delta;
}


// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)gx_distanceDaysToDate:(NSDate *)anotherDate
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0]
#endif
    
    return components.day;
}
- (NSInteger)gx_distanceMonthsToDate:(NSDate *)anotherDate{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self toDate:anotherDate options:0];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self toDate:anotherDate options:0];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self toDate:anotherDate options:0]
#endif
    return components.month;
}
- (NSInteger)gx_distanceYearsToDate:(NSDate *)anotherDate{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self toDate:anotherDate options:0];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self toDate:anotherDate options:0];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self toDate:anotherDate options:0]
#endif
    return components.year;
}



+(NSString *)gx_compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSString *resultStr = @"0";
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        resultStr = @"1";
    } else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        resultStr = @"-1";
    }
    //NSLog(@"两者时间是同一个时间");
    return resultStr;
    
}

@end
