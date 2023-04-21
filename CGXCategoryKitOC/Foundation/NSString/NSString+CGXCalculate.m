//
//  NSString+CGXCalculate.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSString+CGXCalculate.h"

/// 计算类型
typedef enum : NSUInteger {
    /// 加法计算
    CalculateAdding,
    /// 减法计算
    CalculateSubtracting,
    /// 乘法计算
    CalculateMultiplying,
    /// 除法计算
    CalculateDividing
} CalculateType;

@implementation NSString (CGXCalculate)

- (NSComparisonResult)gx_stringCompare:(NSString *)compareString{
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *compareNumber = [NSDecimalNumber decimalNumberWithString:compareString];
    
    return [selfNumber compare:compareNumber];
}

- (NSString *)gx_adding:(NSString *)string{
    return [self gx_adding:string
           RoundingMode:NSRoundPlain];
}

- (NSString *)gx_adding:(NSString *)string
        RoundingMode:(NSRoundingMode)mode{
    return [self gx_adding:string
           RoundingMode:mode
                  Scale:2];
}

- (NSString *)gx_adding:(NSString *)string
        RoundingMode:(NSRoundingMode)mode
               Scale:(NSInteger)scale{
    return [self gx_stringByCalculateType:(CalculateAdding)
                                String:string
                                  Mode:mode
                                 scale:scale];
}

- (NSString *)gx_subtracting:(NSString *)string{
    return [self gx_subtracting:string
                RoundingMode:NSRoundPlain];
}

- (NSString *)gx_subtracting:(NSString *)string
             RoundingMode:(NSRoundingMode)mode{
    return [self gx_subtracting:string
                RoundingMode:mode
                       Scale:2];
}

- (NSString *)gx_subtracting:(NSString *)string
             RoundingMode:(NSRoundingMode)mode
                    Scale:(NSInteger)scale{
    return [self gx_stringByCalculateType:(CalculateSubtracting)
                                String:string
                                  Mode:mode
                                 scale:scale];
}

- (NSString *)gx_multiplying:(NSString *)string{
    return [self gx_multiplying:string
                RoundingMode:NSRoundPlain];
}

- (NSString *)gx_multiplying:(NSString *)string
             RoundingMode:(NSRoundingMode)mode{
    return [self gx_multiplying:string
                RoundingMode:mode
                       Scale:2];
}

- (NSString *)gx_multiplying:(NSString *)string
             RoundingMode:(NSRoundingMode)mode
                    Scale:(NSInteger)scale{
    return [self gx_stringByCalculateType:(CalculateMultiplying)
                                String:string
                                  Mode:mode
                                 scale:scale];
}

- (NSString *)gx_dividing:(NSString *)string{
    return [self gx_dividing:string
             RoundingMode:NSRoundPlain];
}

- (NSString *)gx_dividing:(NSString *)string
          RoundingMode:(NSRoundingMode)mode{
    return [self gx_dividing:string
             RoundingMode:mode
                    Scale:2];
}

- (NSString *)gx_dividing:(NSString *)string
          RoundingMode:(NSRoundingMode)mode
                 Scale:(NSInteger)scale{
    return [self gx_stringByCalculateType:(CalculateDividing)
                                String:string
                                  Mode:mode
                                 scale:scale];
}

//MARK: 数字运算

/**
 字符串计算
 
 @param type 运算符类型
 @param string 被运算内容
 @param mode 四舍五入的方式
 @param scale 保留小数位数
 
 @return 计算后结果
 */
- (NSString *)gx_stringByCalculateType:(CalculateType)type
                             String:(NSString *)string
                               Mode:(NSRoundingMode)mode
                              scale:(NSUInteger)scale{
    
    NSDecimalNumber *selfNumber;
    if (self.length == 0) {
        selfNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
    } else {
        selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    NSDecimalNumber *calculateNumber = [NSDecimalNumber decimalNumberWithString:string];
    NSDecimalNumberHandler *behavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:mode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *result = nil;
    switch (type) {
        case CalculateAdding:
            result = [selfNumber decimalNumberByAdding:calculateNumber withBehavior:behavior];
            break;
        case CalculateSubtracting:
            result =  [selfNumber decimalNumberBySubtracting:calculateNumber withBehavior:behavior];
            break;
        case CalculateMultiplying:
            result = [selfNumber decimalNumberByMultiplyingBy:calculateNumber withBehavior:behavior];
            break;
        case CalculateDividing:
            result =[selfNumber decimalNumberByDividingBy:calculateNumber withBehavior:behavior];
            break;
    }
    
    //  使用formatter
    NSNumberFormatter *numberFormatter = [self gx_stringFormatterWithScale:scale];
    NSString *resultString = [numberFormatter stringFromNumber:result];
    
    if ([resultString isEqualToString:@"NaN"]) {
        resultString = 0;
    }
    
    return resultString;
}

/**
 字符串格式化
 
 @param scale 保留小数位数
 */
- (NSNumberFormatter *)gx_stringFormatterWithScale:(NSInteger)scale{
    static NSNumberFormatter *numberFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.minimumIntegerDigits = 1;
        numberFormatter.numberStyle = NSNumberFormatterNoStyle;
    });
    numberFormatter.alwaysShowsDecimalSeparator = !(scale == 0);
    numberFormatter.minimumFractionDigits = scale;
    
    return numberFormatter;
}

@end
