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

@end
