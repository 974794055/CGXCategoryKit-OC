//
//  NSString+CGXCalculate.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CGXCalculate)
/**
 字符串比较
 
 @param compareString 待比较字符串
 
 @return 比较结果 小于、等于、大于
 */
- (NSComparisonResult)gx_stringCompare:(NSString *)compareString;

/**
 加法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果,
 
 @param string 被加数
 
 @return 加后结果
 */
- (NSString *)gx_adding:(NSString *)string;

/**
 加法计算，默认保留两位小数
 
 @param string 被加数
 @param mode 四舍五入的方式
 
 @return 加后结果
 */
- (NSString *)gx_adding:(NSString *)string
        RoundingMode:(NSRoundingMode)mode;
/**
 加法计算
 
 @param string 被加数
 @param mode 四舍五入的方式
 @param scale 保留小数位数
 
 @return 加后结果
 */
- (NSString *)gx_adding:(NSString *)string
        RoundingMode:(NSRoundingMode)mode
               Scale:(NSInteger)scale;

/**
 减法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果,
 
 @param string 被减数
 
 @return 减后结果
 */
- (NSString *)gx_subtracting:(NSString *)string;

/**
 减法计算，默认保留两位小数
 
 @param string 被减数
 @param mode 四舍五入的方式
 
 @return 减后结果
 */
- (NSString *)gx_subtracting:(NSString *)string
             RoundingMode:(NSRoundingMode)mode;
/**
 减法计算
 
 @param string 被减数
 @param mode 四舍五入的方式
 @param scale 保留小数位数
 
 @return 减后结果
 */
- (NSString *)gx_subtracting:(NSString *)string
             RoundingMode:(NSRoundingMode)mode
                    Scale:(NSInteger)scale;

/**
 乘法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果,
 
 @param string 被乘数
 
 @return 乘后结果
 */
- (NSString *)gx_multiplying:(NSString *)string;

/**
 乘法计算，默认保留两位小数
 
 @param string 被乘数
 @param mode 四舍五入的方式
 
 @return 乘后结果
 */
- (NSString *)gx_multiplying:(NSString *)string
             RoundingMode:(NSRoundingMode)mode;
/**
 乘法计算
 
 @param string 被乘数
 @param mode 四舍五入的方式
 @param scale 保留小数位数
 
 @return 乘后结果
 */
- (NSString *)gx_multiplying:(NSString *)string
             RoundingMode:(NSRoundingMode)mode
                    Scale:(NSInteger)scale;

/**
 除法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果,
 
 @param string 被除数
 
 @return 除后结果
 */
- (NSString *)gx_dividing:(NSString *)string;

/**
 除法计算，默认保留两位小数
 
 @param string 被除数
 @param mode 四舍五入的方式
 
 @return 除后结果
 */
- (NSString *)gx_dividing:(NSString *)string
          RoundingMode:(NSRoundingMode)mode;
/**
 除法计算
 
 @param string 被除数
 @param mode 四舍五入的方式
 @param scale 保留小数位数
 
 @return 除后结果
 */
- (NSString *)gx_dividing:(NSString *)string
          RoundingMode:(NSRoundingMode)mode
                 Scale:(NSInteger)scale;
@end

NS_ASSUME_NONNULL_END
