//
//  NSFileManager+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSFileManager+CGXExtension.h"

@implementation NSFileManager (CGXExtension)

+ (NSURL *)gx_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)gx_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)gx_documentsURL
{
    return [self gx_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)gx_documentsPath
{
    return [self gx_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)gx_libraryURL
{
    return [self gx_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)gx_libraryPath
{
    return [self gx_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)gx_cachesURL
{
    return [self gx_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)gx_cachesPath
{
    return [self gx_pathForDirectory:NSCachesDirectory];
}

+ (BOOL)gx_addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)gx_availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.gx_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

@end
