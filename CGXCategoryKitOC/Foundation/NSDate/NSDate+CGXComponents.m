//
//  NSDate+CGXComponents.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDate+CGXComponents.h"

@implementation NSDate (CGXComponents)

#pragma mark - public

- (NSDateComponents *)gx_dateComponentsTime
{
    NSUInteger components = (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    return [self dateComponents:components];
}

- (NSDateComponents *)gx_dateComponentsDate
{
    NSUInteger components = (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear);
    return [self dateComponents:components];
}

- (NSDateComponents *)gx_dateComponentsWeek
{
    NSUInteger components = (NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth |
                             NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitYear |
                             NSCalendarUnitYearForWeekOfYear);
    return [self dateComponents:components];
}

- (NSDateComponents *)gx_dateComponentsWeekday
{
    NSUInteger components = (NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitWeekday |
                             NSCalendarUnitMonth | NSCalendarUnitYear);
    return [self dateComponents:components];
}

- (NSDateComponents *)gx_dateComponentsDateTime
{
    NSUInteger components = (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |
                             NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    return [self dateComponents:components];
}

- (NSDateComponents *)gx_dateComponentsWeekTime
{
    NSUInteger components = (NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear |
                             NSCalendarUnitWeekday | NSCalendarUnitYear |
                             NSCalendarUnitYearForWeekOfYear | NSCalendarUnitHour |
                             NSCalendarUnitMinute | NSCalendarUnitSecond);
    return [self dateComponents:components];
}

#pragma mark - private

- (NSDateComponents *)dateComponents:(NSUInteger)components
{
    return [[NSCalendar currentCalendar] components:components fromDate:self];
}


- (NSDateComponents *)gx_components
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *com = [calendar components:NSCalendarUnitYear | NSCalendarUnitQuarter | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitNanosecond | NSCalendarUnitWeekday fromDate:self];
    
    return com;
}
- (NSDateComponents *)gx_obtainCurrentDate
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    
    return comps;
}

@end
