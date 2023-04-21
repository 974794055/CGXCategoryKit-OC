//
//  NSNumber+CGX.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (CGXRound)

- (BOOL)isEmpty; // 判断是否为空Number或字符串
/** 返回自己对应的罗马数字 */
- (NSString *)gx_romanNumeral;

/* 展示 */
- (NSString*)gx_toDisplayNumberWithDigit:(NSInteger)digit;
- (NSString*)gx_toDisplayPercentageWithDigit:(NSInteger)digit;

/*　四舍五入 */
/**
 *  @brief  四舍五入
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)gx_doRoundWithDigit:(NSUInteger)digit;

/**
 *  @brief  取上整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)gx_doCeilWithDigit:(NSUInteger)digit;

/**
 *  @brief  取下整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)gx_doFloorWithDigit:(NSUInteger)digit;


/**
 NSNumber比较
 
 @param number 待比较Number
 
 @return 比较结果 小于、等于、大于
 */
- (NSComparisonResult)gx_numberCompare:(NSNumber *)number;

/**
 加法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果,
 
 @param number 被加数
 
 @return 加后结果
 */
- (NSNumber *)gx_adding:(NSNumber *)number;

/**
 减法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果,
 
 @param number 被减数
 
 @return 减后结果
 */
- (NSNumber *)gx_subtracting:(NSNumber *)number;

/**
 乘法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果,
 
 @param number 被乘数
 
 @return 乘后结果
 */
- (NSNumber *)gx_multiplying:(NSNumber *)number;

/**
 除法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果,
 
 @param number 被除数
 
 @return 除后结果
 */
- (NSNumber *)gx_dividing:(NSNumber *)number;

/**
 小数位展示使用，带逗号
 
 @param digit 小数位数, 默认四舍五入
 */
- (NSString *)gx_decimalDigit:(int)digit;

/**
 小数位展示使用，不带逗号
 
 @param digit 小数位数, 默认四舍五入
 */
- (NSString *)gx_decimalDigitParam:(int)digit;

@end
