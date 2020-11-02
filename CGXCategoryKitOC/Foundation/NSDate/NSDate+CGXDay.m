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


#pragma mark -- 获取当前后几天日期 周日
+ (NSMutableArray *)gx_currentDateLaterDate:(int)dayCount {
    NSMutableArray *dayMArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < dayCount; i++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24 * 60 * 60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *theWeek = [weekFormatter stringFromDate:curDate];
        
        //转换英文为中文
        NSString *chinaStr;
        if(theWeek){
            if ([theWeek isEqualToString:@"Monday"]||[theWeek isEqualToString:@"星期一"]) {
                chinaStr = @"周一";
            } else if ([theWeek isEqualToString:@"Tuesday"]||[theWeek isEqualToString:@"星期二"]){
                chinaStr = @"周二";
            } else if ([theWeek isEqualToString:@"Wednesday"]||[theWeek isEqualToString:@"星期三"]){
                chinaStr = @"周三";
            } else if ([theWeek isEqualToString:@"Thursday"]||[theWeek isEqualToString:@"星期四"]){
                chinaStr = @"周四";
            } else if ([theWeek isEqualToString:@"Friday"]||[theWeek isEqualToString:@"星期五"]){
                chinaStr = @"周五";
            } else if ([theWeek isEqualToString:@"Saturday"]||[theWeek isEqualToString:@"星期六"]){
                chinaStr = @"周六";
            } else if ([theWeek isEqualToString:@"Sunday"]||[theWeek isEqualToString:@"星期日"]){
                chinaStr = @"周日";
            }
        }
        
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@", chinaStr];
        [dayMArr addObject:strTime];
    }
    return dayMArr.copy;
}
#pragma  mark 获取未来几天日期
+ (NSMutableArray *)gx_getDateDurationWithLaterDate:(int)dayCount {
    NSArray *_array;
    NSInteger _day = 0;
    NSInteger _month = 0;
    NSInteger _year = 0;

    NSString *currentDate = [self gx_currentDateTimesWithFormat:@"yyyy-MM-dd"];
    
    //年月日
    _array = [currentDate componentsSeparatedByString:@"-"];
    _day = [[_array lastObject] integerValue];
    _month = [_array[1] integerValue];
    _year = [[_array firstObject] integerValue];
    
    NSMutableArray *dateMarr = [[NSMutableArray alloc] init];
    for (int i = 0; i < dayCount; i ++) {
        //取出当月的天数
        NSInteger day = [self gx_isAllDayWithYear:_year month:_month] - [self gx_isAllDayWithYear:_year month:_month+1];
        if (_day > day) {
            _day = 1;
            _month ++;
            _year = (_month > 12) ? (_year+1) : _year;
            _month = _month > 12 ? 1 : _month;
        }
        NSString * string;
        string = [NSString stringWithFormat:@"%02ld-%02ld", _month, _day++];
        [dateMarr addObject:string];
    }
    return dateMarr.copy;
}

#pragma  mark 获取未来几天 年月日
+ (NSMutableArray *)gx_getDateDurationYearMD:(int)dayCount {
    NSArray *_array;
    NSInteger _day = 0;
    NSInteger _month = 0;
    NSInteger _year = 0;
    
    NSString *currentDate = [self gx_currentDateTimesWithFormat:@"yyyy-MM-dd"];
    
    //年月日
    _array = [currentDate componentsSeparatedByString:@"-"];
    _day = [[_array lastObject] integerValue];
    _month = [_array[1] integerValue];
    _year = [[_array firstObject] integerValue];
    
    NSMutableArray *dateMarr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i ++) {
        //取出当月的天数
        NSInteger day = [self gx_isAllDayWithYear:_year month:_month] - [self gx_isAllDayWithYear:_year month:_month+1];
        if (_day > day) {
            _day = 1;
            _month ++;
            _year = (_month > 12) ? (_year + 1) : _year;
            _month = _month > 12 ? 1 : _month;
            
        }
        NSString * string;
        
        string = [NSString stringWithFormat:@"%ld-%02ld-%02ld", _year, _month, _day++];
        
        [dateMarr addObject:string];
    }
    return dateMarr.copy;
}
#pragma  mark 根据格式获取当前时间,年月日/星期/
+ (NSString*)gx_currentDateTimesWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *datenow = [NSDate date];
    NSString *currentTime = [formatter stringFromDate:datenow];
    return currentTime;
}
#pragma mark - 这一年的这个月有多少天
+ (NSInteger)gx_isAllDayWithYear:(NSInteger)year month:(NSInteger)month {
    int day=0;
    switch(month){
        case 1:
            day += 31;
        case 2:{
            if(((year%4==0)&&(year%100!=0))||(year%400==0)){
                day+=29;
            }
            else{
                day+=28;
            }
        }
        case 3:
            day += 31;
        case 4:
            day += 30;
        case 5:
            day += 31;
        case 6:
            day += 30;
        case 7:
            day += 31;
        case 8:
            day += 31;
        case 9:
            day += 30;
        case 10:
            day += 31;
        case 11:
            day += 30;
        case 12:
            day += 31;
            break;
        default:
            break;
    }
    return day;
}

@end
