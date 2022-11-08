//
//  NSString+CGX.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CGX)

//赞的数量
+ (NSString *)gx_likeStringWithNum:(NSString *)string;

// 早安、午安、晚安
+ (NSString *)gx_helloStringByLocalTime;

- (NSUInteger)gx_charactorNumber;

@end




