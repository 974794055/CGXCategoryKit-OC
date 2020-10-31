//
//  NSDate+CGXLunarCalendar.m

//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
#import "NSDate+CGXLunarCalendar.h"
#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
//
////#define ChineseFestival @[@"除夕",@"春节",@"中秋",@"五一",@"国庆",@"儿童",@"圣诞",@"七夕",@"端午"]
//
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]
//
//#define ChineseWeatherFestival @[@"立春",@"雨水",@"惊蛰",@"春分",@"清明",@"谷雨",@"立夏",@"小满",@"忙种",@"夏至",@"小暑",@"大暑",@"立秋",@"处暑",@"寒露",@"霜降",@"白露",@"秋分",@"立冬",@"小雪",@"大雪",@"冬至",@"小寒",@"大寒"]


#define ChineseYears  @[@"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉", @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未", @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳", @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑", @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",  @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥"]

@implementation NSDate (CGXLunarCalendar)



+ (NSCalendar *)chineseCalendar
{
    static NSCalendar *chineseCalendar_sharedCalendar = nil;
    if (!chineseCalendar_sharedCalendar)
        chineseCalendar_sharedCalendar =[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    return chineseCalendar_sharedCalendar;
}
+ (NSString*)gx_currentMDDateString:(NSDate *)currentDate
{
    
    NSDate *date = currentDate;
    NSCalendar *chineseCalendar = [self chineseCalendar];
    
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSString *month = ChineseMonths[components.month -1];
    NSString *day  = ChineseDays[components.day -1];
    
    return [month stringByAppendingString:day];
}
+ (NSString*)gx_currentYMDDateString:(NSDate *)currentDate
{
    NSCalendar *chineseCalendar = [[currentDate class] chineseCalendar];
    NSDate *date = [NSDate date];

    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *localeComp = [chineseCalendar components:unitFlags fromDate:date];
    
    NSLog(@"%zd_%zd_%zd",localeComp.year,localeComp.month,localeComp.day);
    
    NSString *y_str = [ChineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [ChineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [ChineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat:@"%@%@%@",y_str,m_str,d_str];
    
    return chineseCal_str;
}

+ (NSString *)gx_currentWeekWithDateString:(NSString*)datestring{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:datestring];
    return [self gx_currentWeek:date];
}
+ (NSString *)gx_currentWeek:(NSDate*)date{
    NSArray *weeks =@[@"星期",@"星期日",@"星期一", @"星期二", @"星期三",@"星期四", @"星期五", @"星期六"];
    
    NSCalendar *gregorian = [self chineseCalendar];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    
    int week = (int)comps.weekday;
    
    return weeks[week];
}
+ (NSString*)currentCapitalDateString:(NSDate *)currentDate
{
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitMonth| NSCalendarUnitDay) fromDate:currentDate];
    
    
    NSArray *months = @[@"月",@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    
    NSArray *days = @[@"零",@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十",
                      @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                      @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十", @"三十一"];
    
    int day = (int)comps.day;
    int month = (int)comps.month;
    return [[months objectAtIndex:month] stringByAppendingString:[days objectAtIndex:day]];
}
@end
