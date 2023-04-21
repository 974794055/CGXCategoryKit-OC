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
- (NSDateFormatter *)gx_dateFormatterWithFormatType:(CGXDateFormatterType)format
{
    return [self gx_dateFormatterWithFormat:[self dateFormatStr:format]
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
- (NSDateFormatter *)gx_dateFormatterWithFormatType:(CGXDateFormatterType)format
                               localeIdentifier:(nullable NSString *)identifier
                                   timeZoneName:(nullable NSString *)timeZoneName
{
    return [self gx_dateFormatterWithFormat:[self dateFormatStr:format]
                           localeIdentifier:identifier
                               timeZoneName:timeZoneName];
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

- (NSString *)dateFormatStr:(CGXDateFormatterType)format
{
    NSString *dateFormatStr = @"yy年MM月dd日 HH:mm:ss";;
    switch (format) {
        case CGXDateFormatterType_YMDHMS:
            dateFormatStr = @"yy年MM月dd日 HH:mm:ss";
            break;
        case CGXDateFormatterType_YMDHM:
            dateFormatStr = @"yy年MM月dd日 HH:mm";
            break;
        case CGXDateFormatterType_YMDH:
            dateFormatStr = @"yy年MM月dd日 HH";
            break;
        case CGXDateFormatterType_YMD:
            dateFormatStr = @"yy年MM月dd日";
            break;
        case CGXDateFormatterType_YMDHMS1:
            dateFormatStr = @"yy/MM/dd HH:mm:ss";
            break;
        case CGXDateFormatterType_YMDHM1:
            dateFormatStr = @"yy/MM/dd HH:mm";
            break;
        case CGXDateFormatterType_YMDH1:
            dateFormatStr = @"yy/MM/dd HH";
            break;
        case CGXDateFormatterType_YMD1:
            dateFormatStr = @"yy/MM/dd";
            break;
        case CGXDateFormatterType_YMDHMS2:
            dateFormatStr = @"yy-MM-dd HH:mm:ss";
            break;
        case CGXDateFormatterType_YMDHM2:
            dateFormatStr = @"yy-MM-dd HH:mm";
            break;
        case CGXDateFormatterType_YMDH2:
            dateFormatStr = @"yy-MM-dd HH";
            break;
        case CGXDateFormatterType_YMD2:
            dateFormatStr = @"yy-MM-dd";
            break;
    }
    return  dateFormatStr;
}
@end
