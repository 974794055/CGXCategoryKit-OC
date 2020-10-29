//
//  NSDate+CGXTime.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDate+CGXTime.h"
#import "NSDate+CGXCompare.h"

#import "CGXCategoryDateFormatterPool.h"


#define NSDateCGXTimeYMDHMS    @"yyyy-MM-dd HH:mm:ss"
#define NSDateCGXTimeYMD       @"yyyy-MM-dd"


@implementation NSDate (CGXTime)


- (NSString *)gx_formatYMD
{
    return [self gx_formatYMDHMSFormat:NSDateCGXTimeYMD];
}
- (NSString *)gx_formatYMDHMS
{
    return [self gx_formatYMDHMSFormat:NSDateCGXTimeYMDHMS];
}
- (NSString *)gx_formatYMDHMSFormat:(NSString *_Nonnull)format
{
    return [[[CGXCategoryDateFormatterPool shareInstance] gx_dateFormatterWithFormat:format] stringFromDate:self];
}
+ (NSString *)gx_formatYMD:(NSDate *)date
{
    return [self gx_formatYMDHMS:date Format:NSDateCGXTimeYMD];
}
+ (NSString *)gx_formatYMDHMS:(NSDate *)date
{
    return [self gx_formatYMDHMS:date Format:NSDateCGXTimeYMDHMS];
}
+ (NSString *)gx_formatYMDHMS:(NSDate *)date Format:(NSString *_Nonnull)format
{
    return [[[CGXCategoryDateFormatterPool shareInstance] gx_dateFormatterWithFormat:format] stringFromDate:date];
}

+ (NSDate *_Nonnull)gx_dateFromString:(NSString *_Nonnull)dateString
                            format:(NSString *_Nonnull)format
{
    return [self gx_dateFromString:dateString format:format localeIdentifier:nil timeZoneName:nil];
}
+ (NSDate *_Nonnull)gx_dateFromString:(NSString *_Nonnull)dateString
                            format:(NSString *_Nonnull)format
                          localeIdentifier:(nullable NSString *)identifier
                          timeZoneName:(nullable NSString *)timeZoneName
{
    NSDateFormatter *formatter = [[CGXCategoryDateFormatterPool shareInstance] gx_dateFormatterWithFormat:format
                                                                                         localeIdentifier:identifier
                                                                                             timeZoneName:timeZoneName];;;
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

+ (NSString *)gx_dateStringFromDate:(NSDate *)date
                             format:(NSString *)format {
    NSDateFormatter * dateFormatter = [[CGXCategoryDateFormatterPool shareInstance] gx_dateFormatterWithFormat:format];;
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}


+ (NSString *)gx_dateStringWithTimestamp:(NSTimeInterval)timestamp
                               formatter:(NSString*)formatter
{
    if ([NSString stringWithFormat:@"%@", @(timestamp)].length == 13) {
        timestamp /= 1000.0f;
    }
    NSDate *timestampDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormatter = [[CGXCategoryDateFormatterPool shareInstance] gx_dateFormatterWithFormat:formatter];
    [dateFormatter setDateFormat:formatter];
    NSString *strDate = [dateFormatter stringFromDate:timestampDate];
    return strDate;
}

+ (NSString *)gx_dateStringYMDWithTimestamp:(NSTimeInterval)timestamp {
    NSDate *confromTimesp    = [NSDate dateWithTimeIntervalSince1970:timestamp / 1000];
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    NSInteger referenceYear  = referenceComponents.year;
    NSInteger referenceMonth = referenceComponents.month;
    NSInteger referenceDay   = referenceComponents.day;
    return [NSString stringWithFormat:@"%ld年%ld月%ld日",(long)referenceYear,(long)referenceMonth,(long)referenceDay];
}



//#pragma mark -- Timestamp
+ (NSTimeInterval)gx_timeIntervalSince1970FromString:(NSString *)dateString
{
    NSDate * date = [self gx_dateFromString:dateString format:NSDateCGXTimeYMDHMS];
    if (date) {
        NSTimeInterval time = [date timeIntervalSince1970] * 1000;
        return time;
    }
    return 0;
}

@end
