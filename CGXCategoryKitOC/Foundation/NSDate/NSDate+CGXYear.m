//
//  NSDate+CGXYear.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDate+CGXYear.h"
#import <UIKit/UIKit.h>
@implementation NSDate (CGXYear)

- (BOOL)gx_isThisYear
{
    return self.year == [NSDate date].year;
}
- (BOOL)gx_isNextYear
{
    return self.year == ([NSDate date].year+1);
}

- (BOOL)gx_isLastYear
{
    return self.year == ([NSDate date].year-1);
}
- (BOOL)gx_isSameYearAsDate:(NSDate *_Nonnull)aDate
{
    return self.year == aDate.year;
}
- (BOOL)gx_isLeapYear
{
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}
- (NSUInteger)gx_yearInDays {
    return [NSDate gx_yearInDays:self];
}

+ (NSUInteger)gx_yearInDays:(NSDate *)date {
    return [date gx_isLeapYear] ? 366 : 365;
}
- (NSDate *)gx_yearOfBegin {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [calendar components:NSCalendarUnitYear   fromDate:self];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [calendar components:NSYearCalendarUnit  fromDate:self];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [calendar components:NSYearCalendarUnit  fromDate:self];
#endif
    return [calendar dateFromComponents:components];
}

- (NSDate *)gx_yearOfEnd {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self gx_yearOfBegin] options:0] dateByAddingTimeInterval:-1];
}

@end
