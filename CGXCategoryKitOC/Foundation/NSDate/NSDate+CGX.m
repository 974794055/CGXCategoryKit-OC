//
//  NSDate+CGX.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDate+CGX.h"
#import "NSDate+CGXMonth.h"
#import "NSDate+CGXTime.h"
#import "CGXCategoryDateFormatterPool.h"
@implementation NSDate (CGX)

+(NSString *)gx_stringWithTimeInterval:(unsigned int)time Formatter:(NSString *)format {
    NSDateFormatter *formatter=[[CGXCategoryDateFormatterPool shareInstance] gx_dateFormatterWithFormat:format];
    [formatter setDateFormat:format];
    NSTimeZone *localtimezone=[NSTimeZone systemTimeZone];
    NSInteger offset=[localtimezone secondsFromGMT];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:(time-offset)];
    NSString *timeStr=[formatter stringFromDate:date];
    return timeStr;
}
+(NSTimeInterval)gx_timeNow {
    NSDate *now = [NSDate date];
    NSTimeZone *zone=[NSTimeZone systemTimeZone];
    NSInteger offset=[zone secondsFromGMT];
    return  [now timeIntervalSince1970]+offset;
}
+(NSTimeInterval)gx_timeIntervalFromString:(NSString *)timeStr Formatter:(NSString *)format {
    NSDateFormatter *formatter= [[CGXCategoryDateFormatterPool shareInstance] gx_dateFormatterWithFormat:format];
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:timeStr];
    NSTimeZone *zone=[NSTimeZone systemTimeZone];
    NSInteger offset=[zone secondsFromGMT];
    return  ([date timeIntervalSince1970]+offset);
}
- (NSString *)gx_timeInfo {
    return [NSDate gx_timeInfoWithDate:self];
}
+ (NSString *)gx_timeInfoWithDate:(NSDate *)date
{
    NSDateFormatter *outputFormatter = [[CGXCategoryDateFormatterPool shareInstance] gx_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *retStr = [outputFormatter stringFromDate:date];
    return [self gx_timeInfoWithDateString:retStr];
}

+ (NSString *)gx_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [NSDate gx_dateFromString:dateString format:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate month] - [date month]);
    int year = (int)([curDate year] - [date year]);
    int day = (int)([curDate day] - [date day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate month] == 1 && [date month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self gx_monthInDays:date];
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate day] + (totalDays - (int)[date day]);
        }
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            // 隔年
            int month = (int)[curDate month];
            int preMonth = (int)[date month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    return @"1小时前";
}

@end
