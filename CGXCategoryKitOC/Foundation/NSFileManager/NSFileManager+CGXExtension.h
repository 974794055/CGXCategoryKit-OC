//
//  NSFileManager+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (CGXExtension)
/**
 Get URL of Documents directory.
 @return Documents directory URL.
 */
+ (NSURL *)gx_documentsURL;
/**
 Get path of Documents directory.
 @return Documents directory path.
 */
+ (NSString *)gx_documentsPath;
/**
 Get URL of Library directory.
 @return Library directory URL.
 */
+ (NSURL *)gx_libraryURL;
/**
 Get path of Library directory.
 @return Library directory path.
 */
+ (NSString *)gx_libraryPath;
/**
 Get URL of Caches directory.
 @return Caches directory URL.
 */
+ (NSURL *)gx_cachesURL;
/**
 Get path of Caches directory.
 @return Caches directory path.
 */
+ (NSString *)gx_cachesPath;
/**
 Adds a special filesystem flag to a file to avoid iCloud backup it.
 @param path Path to a file to set an attribute.
 */
+ (BOOL)gx_addSkipBackupAttributeToFile:(NSString *)path;
/**
 Get available disk space.
 @return An amount of available disk space in Megabytes.
 */
+ (double)gx_availableDiskSpace;

@end

NS_ASSUME_NONNULL_END
