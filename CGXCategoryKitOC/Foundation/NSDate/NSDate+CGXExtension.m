//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDate+CGXExtension.h"
#import "NSDate+CGXCompare.h"
#import "NSDate+CGXTime.h"
#import "CGXCategoryDateFormatterPool.h"

#import "NSCalendar+CGXExtension.h"
@implementation NSDate (CGXExtension)

///**
// *  当前时间
// */
+ (NSDate *_Nonnull)currentDate
{
    //设置源日期时区
//        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0900"];
    //或GMT
    NSTimeZone *sourceTimeZone = [NSTimeZone systemTimeZone];
    // 获得系统的时区 //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSTimeInterval sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:[NSDate date]];
    //目标日期与本地时区的偏移量
    NSTimeInterval destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:[NSDate date]];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate *destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:[NSDate date]];
    NSDate *nowdate  =[destinationDateNow dateByAddingTimeInterval:interval];
    return nowdate;
}

- (NSInteger)nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + 60 * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}
- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSUInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSUInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSUInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSUInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSUInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}


/**
 *  返回 年月日时分秒
 */
- (NSDate *_Nonnull)gx_dateWithYMDHMS
{
    return [self gx_dateWithFormatter:@"yyyy-MM-dd HH:mm:ss"];
}
/**
 *  返回 年月日时分
 */
- (NSDate *_Nonnull)gx_dateWithYMDHM
{
    return [self gx_dateWithFormatter:@"yyyy-MM-dd HH:mm"];
}
/**
 *  返回 年月日时
 */
- (NSDate *_Nonnull)gx_dateWithYMDH
{
    return [self gx_dateWithFormatter:@"yyyy-MM-dd HH"];
}
/**
 *  返回 年月日
 */
- (NSDate *_Nonnull)gx_dateWithYMD
{
    return [self gx_dateWithFormatter:@"yyyy-MM-dd"];
}
/**
 *  返回 年月
 */
- (NSDate *_Nonnull)gx_dateWithYM
{
    return [self gx_dateWithFormatter:@"yyyy-MM"];
}
/**
 *  返回 年月
 */
- (NSDate *_Nonnull)gx_dateWithY
{
    return [self gx_dateWithFormatter:@"yyyy"];
}
/**
 *  返回 时间格式
 */
- (NSDate *_Nonnull)gx_dateWithFormatter:(NSString *_Nonnull)dateFormat
{
    NSDateFormatter *formatter = [[CGXCategoryDateFormatterPool shareInstance] gx_dateFormatterWithFormat:dateFormat];;;
    NSString *selfStr = [formatter stringFromDate:self];
    return [formatter dateFromString:selfStr];
}

+ (NSDate *_Nonnull)gx_dateWithYear:(int)year month:(int)month day:(int)day
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    // Assign the year, month and day components.
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSCalendar *gregorianCalendar = [[self class] gx_gregorianCalendar_factory];
    return [gregorianCalendar dateFromComponents:components];
}

@end
