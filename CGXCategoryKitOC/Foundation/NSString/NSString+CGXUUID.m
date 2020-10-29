//
//  NSString+CGXUUID.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSString+CGXUUID.h"
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>

#import <AdSupport/AdSupport.h>


@implementation NSString (CGXUUID)
/**
 *  @brief  获取随机 UUID 例如 E621E1F8-C36C-495A-93FC-0C247A3E6E5F
 *
 *  @return 随机 UUID
 */
+ (NSString *)gx_UUID
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0)
    {
       return  [[NSUUID UUID] UUIDString];
    }
    else
    {
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        return (__bridge_transfer NSString *)uuid;
    }
}
+ (NSString *)gx_UUIDString{
    if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled)
        return [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    else
        return [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
}

@end
