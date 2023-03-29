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
/** iTunes 备份与恢复，存用户偏好设置 */
- (NSString *)gx_dirPathOfPreferences;
/**
 Get URL of Documents directory.
 @return Documents directory URL.
 */
+ (NSURL *)gx_documentsURL;
/**
 Get path of Documents directory.
 @return Documents directory path.
 iTunes 备份与恢复
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
 Preferences 和 Caches 的父目录
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
 iTunes 不会备份，存缓存文件
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
