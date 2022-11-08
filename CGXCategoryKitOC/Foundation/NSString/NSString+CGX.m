//
//  NSString+CGX.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSString+CGX.h"

#import <AdSupport/AdSupport.h>

@implementation NSString (CGX)

//赞的数量
+ (NSString *)gx_likeStringWithNum:(NSString *)string
{
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                           decimalNumberHandlerWithRoundingMode:NSRoundDown
                                           scale:1
                                           raiseOnExactness:NO
                                           raiseOnOverflow:NO
                                           raiseOnUnderflow:NO
                                           raiseOnDivideByZero:YES];
    NSDecimalNumber *a = [NSDecimalNumber decimalNumberWithString:string];
    if ([string length] >= 5 && [string length] < 9) {
        NSDecimalNumber *b = [NSDecimalNumber decimalNumberWithString:@"10000"];
        NSDecimalNumber *c = [a decimalNumberByDividingBy:b];
        NSDecimalNumber *d = [c decimalNumberByRoundingAccordingToBehavior:roundUp];
        return [NSString stringWithFormat:@"%@万",d];
    } else  if (string.length >= 9){
        NSDecimalNumber *b = [NSDecimalNumber decimalNumberWithString:@"100000000"];
        NSDecimalNumber *c = [a decimalNumberByDividingBy:b];
        NSDecimalNumber *d = [c decimalNumberByRoundingAccordingToBehavior:roundUp];
        return [NSString stringWithFormat:@"%@亿",d];
    } else {
        return string;
    }
}

+ (NSString *)gx_helloStringByLocalTime
{
    NSDateFormatter *formatter = [self creatDateFormatter];;
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSArray *resultArr = [dateString componentsSeparatedByString:@":"];
    if(resultArr.count == 0) return nil;
    NSInteger hour = [resultArr.firstObject integerValue];
    if(hour > 0 && hour < 11) {
        return @"早安";
    }else if(hour >= 11 && hour <= 4) {
        return @"午安";
    }else{
        return @"晚安";
    }
}

+ (NSDateFormatter *)creatDateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    return formatter;
}
 
+ (NSString *)dataStringWithTimeInterval:(NSTimeInterval)time {
    NSString *result = @"";
    NSDateFormatter *formatter = [self creatDateFormatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%f",time]];
    NSTimeInterval seconds = fabs([date timeIntervalSinceNow])/60;
    if (seconds < 60) {
        result = [NSString stringWithFormat:@"%@分钟前", @(ceil(seconds))];
    }else {
        NSUInteger duration = ceil(seconds/60);
        if (duration <= 24) {
            result = [NSString stringWithFormat:@"%@小时前", @(duration)];
        }else {
            duration = ceil(duration/24.f);
            if (duration < 30) {
                result = [NSString stringWithFormat:@"%@天前", @(duration)];
            }else {
                duration = ceil(duration/30.0f);
                
                if (duration < 12) {
                    result = [NSString stringWithFormat:@"%@个月前",@(duration)];
                } else{
                    result = @"1年前";
                }
            }
        }
    }
    return result;
}

- (NSUInteger)gx_charactorNumber
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self gx_charactorNumberWithEncoding:encoding];
}
- (NSUInteger)gx_charactorNumberWithEncoding:(NSStringEncoding)encoding
{
    NSUInteger strLength = 0;
    char *p = (char *)[self cStringUsingEncoding:encoding];
    
    NSUInteger lengthOfBytes = [self lengthOfBytesUsingEncoding:encoding];
    for (int i = 0; i < lengthOfBytes; i++) {
        if (*p) {
            p++;
            strLength++;
        }
        else {
            p++;
        }
    }
    return strLength;
}

@end
