//
//  NSFileManager+CGXFilePath.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSFileManager+CGXFilePath.h"

@implementation NSFileManager (CGXFilePath)

/**
 快速返回沙盒中，你指定的系统文件的路径。tmp文件除外，tmp用系统的NSTemporaryDirectory()函数更加便捷
 
 @param directory NSSearchPathDirectory枚举
 @return 快速你指定的系统文件的路径
 */
+ (NSString *)gx_pathForSystemFile:(NSSearchPathDirectory)directory
{
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) lastObject];
}
/**
 快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName
 
 @param directory 你指的的系统文件
 @param fileName 子文件名
 @return 快速返回沙盒中，你指定的系统文件的中某个子文件的路径
 */
+ (NSString *)gx_filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName
{
    return [[self gx_pathForSystemFile:directory] stringByAppendingPathComponent:fileName];
}

+ (NSString *)gx_directoryPathFor:(CGXFilePathType)pathType
{
    switch (pathType) {
        case CGXFilePathTypeDocument:
        case CGXFilePathTypeCaches:
        case CGXFilePathTypePreferences:
        {
            NSSearchPathDirectory searchPath = 0;
            switch (pathType) {
                case CGXFilePathTypeDocument:
                    /*
                     NSDocumentDirectory 是指程序中对应的Documents路径，而NSDocumentionDirectory对应于程序中的Library/Documentation路径，这个路径是没有读写权限的，所以看不到文件生成。
                     */
                    searchPath = NSDocumentDirectory;
                    break;
                case CGXFilePathTypeCaches:
                    searchPath = NSCachesDirectory;
                    break;
                case CGXFilePathTypePreferences:
                    searchPath = NSPreferencePanesDirectory;
                    break;
                default:
                    break;
            }
            return [NSFileManager gx_pathForSystemFile:searchPath];
        }
            break;
        case CGXFilePathTypeTemp:
        {
            return NSTemporaryDirectory();
        }
            break;
        case CGXFilePathTypeBundle:
        {
            return [NSBundle mainBundle].bundlePath;
        }
            break;
        default:
            break;
    }
}

+ (NSString *)gx_filePathAt:(CGXFilePathType)pathType fileName:(NSString *)fileName isCreat:(BOOL)isCreat
{
    NSString *filePath = [[self gx_directoryPathFor:pathType] stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath] && isCreat) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    return filePath;
}

+ (NSString *)gx_directoryPathAt:(CGXFilePathType)pathType directoryName:(NSString *)directoryName isCreat:(BOOL)isCreat
{
    NSString *directoryPath = [[self gx_directoryPathFor:pathType] stringByAppendingPathComponent:directoryName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath] && isCreat) {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:true attributes:nil error:nil];
    }
    return directoryPath;
}


@end
