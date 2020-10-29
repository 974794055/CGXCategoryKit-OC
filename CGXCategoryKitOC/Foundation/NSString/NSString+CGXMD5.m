//
//  NSString+CGXMD5.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/19.
//

#import "NSString+CGXMD5.h"
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (CGXMD5)

- (NSString *)gx_toMD5
{
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

@end
