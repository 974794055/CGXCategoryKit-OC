//
//  NSDate+CGXYear.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+CGXExtension.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CGXYear)
/**
 *  是否是同一年
 */
- (BOOL)gx_isSameYearAsDate:(NSDate *_Nonnull)aDate;
/**
 *  是否为今年
 */
- (BOOL)gx_isThisYear;
/**
 *  是否为明年
 */
- (BOOL)gx_isNextYear;
/**
 *  是否为去年
 */
- (BOOL)gx_isLastYear;

/**
 *  是否是闰年
 */
- (BOOL)gx_isLeapYear;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)gx_yearInDays;
+ (NSUInteger)gx_yearInDays:(NSDate *)date;

 /**
 * 获取一年开始的第一天
 */
- (NSDate *)gx_yearOfBegin;
/**
 * 获取一年开始的最后一天
*/
- (NSDate *)gx_yearOfEnd;

@end

NS_ASSUME_NONNULL_END
