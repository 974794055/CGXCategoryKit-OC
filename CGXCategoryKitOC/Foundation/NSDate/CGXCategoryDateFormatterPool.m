//
//  CGXCategoryDateFormatterPool.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXCategoryDateFormatterPool.h"

/** < 信号量，保证NSDateFormatter线程安全 >  */
static dispatch_semaphore_t _cahcePoolLook;

@implementation CGXCategoryDateFormatterPool

+ (instancetype)shareInstance {
    static CGXCategoryDateFormatterPool *instache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instache = [[self alloc]init];
        _cahcePoolLook = dispatch_semaphore_create(1);
    });
    return instache;
}

#pragma mark < Public Method >
- (NSDateFormatter *)gx_dateFormatterWithFormat:(NSString *)format {
    return [self gx_dateFormatterWithFormat:format
                           localeIdentifier:@"zh_CN"
                               timeZoneName:@"Asia/Beijing"];
}
#pragma mark < Basic Method >
- (NSDateFormatter *)gx_dateFormatterWithFormat:(NSString *)format
                               localeIdentifier:(nullable NSString *)identifier
                                   timeZoneName:(nullable NSString *)timeZoneName
{
    if (![format isKindOfClass:[NSString class]] || format.length == 0){
        return nil;
    }
    NSDateFormatter *formatter = [self creatBeijingformatter];
    formatter.dateFormat = format;
    if (identifier && identifier.length>0){
        formatter.locale = [NSLocale localeWithLocaleIdentifier:identifier];
    }
    if (timeZoneName && timeZoneName.length>0){
        formatter.timeZone = [NSTimeZone timeZoneWithName:timeZoneName];
    }
    return formatter;
}

- (NSDateFormatter *)creatBeijingformatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    return formatter;;
}

@end
