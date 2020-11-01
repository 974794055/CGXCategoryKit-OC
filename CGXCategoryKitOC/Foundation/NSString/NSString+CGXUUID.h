//
//  NSString+CGXUUID.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CGXUUID)
/**
 *  @brief  获取随机 UUID 例如 E621E1F8-C36C-495A-93FC-0C247A3E6E5F
 *  @return 随机 UUID
 */
+ (NSString *)gx_UUID;
/** 不会因为应用卸载改变
 * 但是用户在设置-隐私-广告里面限制广告跟踪后会变成@"00000000-0000-0000-0000-000000000000"
 * 重新打开后会变成另一个，还原广告标识符也会变
 */
+ (NSString *)gx_UUIDString;



@end
