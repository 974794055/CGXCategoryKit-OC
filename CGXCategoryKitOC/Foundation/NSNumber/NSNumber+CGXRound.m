//
//  NSNumber+CGX.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSNumber+CGXRound.h"

@implementation NSNumber (CGXRound)


- (BOOL)isEmpty {
    
    if (self != nil && [self isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    else if (self != nil && [self isNotEmptyNSString]) {
        return YES;
    }
    return NO;
}
- (BOOL)isNotEmptyNSString {
    
    if (self != nil && [self isKindOfClass:[NSString class]] && [(NSString *)self length] > 0) {
        return YES;
    }
    return NO;
}


- (NSString *)gx_romanNumeral
{
    NSInteger n = [self integerValue];
    
    NSArray *numerals = [NSArray arrayWithObjects:@"M", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I", nil];
    
    NSUInteger valueCount = 13;
    NSUInteger values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    
    NSMutableString *numeralString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < valueCount; i++)
    {
        while (n >= values[i])
        {
            n -= values[i];
            [numeralString appendString:[numerals objectAtIndex:i]];
        }
    }
    return numeralString;
}



#pragma mark - Display
- (NSString*)gx_toDisplayNumberWithDigit:(NSInteger)digit
{
    NSString *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    result = [formatter  stringFromNumber:self];
    if (result == nil)
        return @"";
    return result;
    
}

- (NSString*)gx_toDisplayPercentageWithDigit:(NSInteger)digit
{
    NSString *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    result = [formatter  stringFromNumber:self];
    return result;
}

#pragma mark - round, ceil, floor
- (NSNumber*)gx_doRoundWithDigit:(NSUInteger)digit
{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    [formatter setMinimumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}


- (NSNumber*)gx_doCeilWithDigit:(NSUInteger)digit
{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    [formatter setMaximumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}

- (NSNumber*)gx_doFloorWithDigit:(NSUInteger)digit
{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundFloor];
    [formatter setMaximumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}

- (NSComparisonResult)gx_numberCompare:(NSNumber *)number{
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self.stringValue];
    NSDecimalNumber *compareNumber = [NSDecimalNumber decimalNumberWithString:number.stringValue];
    
    return [selfNumber compare:compareNumber];
}

- (NSNumber *)gx_adding:(NSNumber *)number{
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self.stringValue];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:number.stringValue];
    
    return [number1 decimalNumberByAdding:number2];
}

- (NSNumber *)gx_subtracting:(NSNumber *)number{
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self.stringValue];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:number.stringValue];
    
    return [number1 decimalNumberBySubtracting:number2];
}

- (NSNumber *)gx_multiplying:(NSNumber *)number{
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self.stringValue];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:number.stringValue];
    
    return [number1 decimalNumberByMultiplyingBy:number2];
}

- (NSNumber *)gx_dividing:(NSNumber *)number{
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self.stringValue];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:number.stringValue];
    
    return [number1 decimalNumberByDividingBy:number2];
}

- (NSString *)gx_decimalDigit:(int)digit{
    return  [self gx_decimalHasDigit:digit Mode:NSNumberFormatterRoundHalfUp HasComma:true];
}

- (NSString *)gx_decimalDigitParam:(int)digit{
    return  [self gx_decimalHasDigit:digit Mode:NSNumberFormatterRoundHalfUp HasComma:false];
}

- (NSString *)gx_decimalHasDigit:(int)digit
                         Mode:(NSNumberFormatterRoundingMode)mode
                     HasComma:(BOOL)hasComma{
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = hasComma == true? NSNumberFormatterDecimalStyle : NSNumberFormatterNoStyle;
    format.minimumFractionDigits = digit;
    format.maximumFractionDigits = digit;
    format.formatterBehavior = NSNumberFormatterBehaviorDefault;
    format.roundingMode = mode;
    
    return  [format stringFromNumber:self];
}
@end


































