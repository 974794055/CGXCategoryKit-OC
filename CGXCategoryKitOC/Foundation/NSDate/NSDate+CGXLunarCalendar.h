//
//  NSDate+CGXLunarCalendar.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
///农历大写日期
@interface NSDate (CGXLunarCalendar)

//例如 五月初一
+ (NSString*)gx_currentMDDateString:(NSDate *)currentDate;
//例如 乙未年五月初一
+ (NSString*)gx_currentYMDDateString:(NSDate *)currentDate;
//例如 星期一
+ (NSString *)gx_currentWeek:(NSDate*)date;
//例如 星期一
+ (NSString *)gx_currentWeekWithDateString:(NSString*)datestring;
//例如 五月一
+ (NSString*)currentCapitalDateString:(NSDate *)currentDate;;
@end
