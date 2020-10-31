//
//  NSData+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSData+CGXExtension.h"

@implementation NSData (CGXExtension)


+ (NSData *)gx_arrayWithJsonData:(NSMutableArray *)array
{
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }
    return nil;
}
+ (NSData *)gx_dictionaryWithJsonData:(NSMutableDictionary *)dict
{
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }
    return nil;
}
+ (NSData *)gx_strWithJsonData:(NSString *)str
{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}
+ (NSData *)gx_redFileManagerFileName:(NSString *)name
{
     NSData* data = [[NSData alloc] init];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString* thepath = [paths lastObject];
    thepath = [thepath stringByAppendingPathComponent:name];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    data = [fm contentsAtPath:thepath];
    return data;
}
+ (NSData *)gx_redWithContentsFileName:(NSString *)name
{
    NSData* data = [[NSData alloc] init];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString* thepath = [paths lastObject];
    thepath = [thepath stringByAppendingPathComponent:name];
    data = [NSData dataWithContentsOfFile:thepath];
    return data;
}
+ (NSData *)gx_redFileHandleFileName:(NSString *)name
{
    NSData* data = [[NSData alloc] init];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString* thepath = [paths lastObject];
    thepath = [thepath stringByAppendingPathComponent:name];
    
    NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:thepath];
    data = [fh readDataToEndOfFile];
    return data;
}
- (NSArray *)gx_cutDataWithFragmentSize:(NSInteger)fragmentSize {
    if (self.length == 0) return nil;
    
    NSMutableArray *tempArray = @[].mutableCopy;
    NSInteger allLength = self.length;
    NSInteger index = 0;
    do {
        if (allLength > fragmentSize) {
            NSRange range = NSMakeRange(index * fragmentSize * (1000 * 1000), allLength);
            NSData *data = [self subdataWithRange:range];
            [tempArray addObject:data];
            
            index ++;
            allLength = allLength - fragmentSize * (1000 * 1000);
        }else {
            NSRange range = NSMakeRange(index * fragmentSize * (1000 * 1000), allLength);
            NSData *data = [self subdataWithRange:range];
            [tempArray addObject:data];
            allLength = 0;
        }
    } while (allLength > 0);
    
    return tempArray.copy;
}

@end
