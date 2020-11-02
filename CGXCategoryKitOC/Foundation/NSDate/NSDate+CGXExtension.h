//
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CGXExtension)

+ (NSDate *_Nonnull)currentDate;

#pragma mark 时间分隔单位
@property (nonatomic, readonly) NSInteger nearestHour; ///近一小时内
@property (nonatomic, readonly) NSInteger year; ///< Year component
@property (nonatomic, readonly) NSInteger month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user setting)

@property (nonatomic, readonly) NSUInteger weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSUInteger weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSUInteger weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSUInteger yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSUInteger quarter; ///< Quarter component
/**
 *  返回 年月日时分秒
 */
- (NSDate *_Nonnull)gx_dateWithYMDHMS;
/**
 *  返回 年月日时分
 */
- (NSDate *_Nonnull)gx_dateWithYMDHM;
/**
 *  返回 年月日时
 */
- (NSDate *_Nonnull)gx_dateWithYMDH;
/**
 *  返回 年月日
 */
- (NSDate *_Nonnull)gx_dateWithYMD;
/**
 *  返回 年月
 */
- (NSDate *_Nonnull)gx_dateWithYM;
/**
 *  返回 年
 */
- (NSDate *_Nonnull)gx_dateWithY;


/*
 设置年月日
 */
+ (NSDate *_Nonnull)gx_dateWithYear:(int)year month:(int)month day:(int)day;

@end
