//
//  NSDate+CGXDay.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDate+CGXDay.h"

@implementation NSDate (CGXDay)


- (BOOL)gx_isSameDayAsDate:(NSDate *_Nonnull)aDate
{
    return self.day == aDate.day && self.month == aDate.month && self.year == aDate.year;
}


- (BOOL)gx_isToday
{
    return (self.year == [NSDate date].year) && (self.month == [NSDate date].month) && (self.day == [NSDate date].day);
}
- (BOOL)gx_isYesterday
{
    NSDate *nowDate = [[NSDate date] gx_dateWithYMD];
    NSDate *selfDate = [self gx_dateWithYMD];
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}
/**
 *  是否为明天
 */
- (BOOL)gx_isTomorrowDay
{
    NSDate *nowDate = [[NSDate date] gx_dateWithYMD];
    NSDate *selfDate = [self gx_dateWithYMD];
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == -1;
}

#pragma mark - Roles
- (BOOL)isTypicallyWeekend
{
    if ((self.weekday == 1) ||
        (self.weekday == 7))
        return YES;
    return NO;
}
- (BOOL)gx_isWorkday
{
    return ![self gx_isWeekEnd];
}
/**
 *  是否是周末
 */
- (BOOL)gx_isWeekEnd
{
        NSDate *date = [NSDate date];
        /**  < 消除警告宏 >  */
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    #pragma clang diagnostic pop
        comps = [calendar components:unitFlags fromDate:date];
    
    if (comps.weekday==1 || comps.weekday==7) {
        return YES;
    } else{
        return NO;
    }
}
- (NSDate *)gx_dayOfbegin {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
#endif
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)gx_dayOfend {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self gx_dayOfbegin] options:0] dateByAddingTimeInterval:-1];
}


+ (NSDate *)gx_dayTomorrow
{
    return [NSDate gx_dateWithDaysFromNow:1];
}
+ (NSDate *)gx_dayYesterday
{
    return [NSDate gx_dateWithDaysBeforeNow:1];
}
+ (NSDate *)gx_dateWithDaysFromNow:(NSInteger) days
{
    return [NSDate gx_dateWithDaysFromNow:days AsDate:[NSDate date]];
}

+ (NSDate *)gx_dateWithDaysBeforeNow: (NSInteger) days
{
    return [NSDate gx_dateWithDaysBeforeNow:-days AsDate:[NSDate date]];
}
///某天后几天
+ (NSDate *)gx_dateWithDaysFromNow:(NSInteger)days AsDate:(NSDate *_Nonnull)aDate
{
    return [aDate gx_dateByAddingDays:days];
}
///某天前几天
+ (NSDate *)gx_dateWithDaysBeforeNow:(NSInteger)days AsDate:(NSDate *_Nonnull)aDate
{
    return [aDate gx_dateByAddingDays:-days];
}

- (NSDate *)gx_dateByAddingDays:(NSInteger) dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}
@end
