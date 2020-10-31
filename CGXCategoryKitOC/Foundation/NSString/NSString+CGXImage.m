//
//  NSString+CGXImage.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/8/5.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSString+CGXImage.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/utsname.h>
@implementation NSString (CGXImage)

/** 图片转字符串 */
+ (NSString *)gx_ImageToStr:(UIImage *)image {
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return encodedImageStr;
}

@end
