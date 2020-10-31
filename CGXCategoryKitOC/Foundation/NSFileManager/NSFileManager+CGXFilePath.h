//
//  NSFileManager+CGXFilePath.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CGXFilePathTypeDocument, // 读写
    CGXFilePathTypeCaches, // 读写
    CGXFilePathTypePreferences, // 读写
    CGXFilePathTypeTemp, // 读写
    CGXFilePathTypeBundle // 读
} CGXFilePathType;

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (CGXFilePath)

/**
 快速返回沙盒中，你指定的系统文件的路径。tmp文件除外，tmp用系统的NSTemporaryDirectory()函数更加便捷
 
 @param directory NSSearchPathDirectory枚举
 @return 快速你指定的系统文件的路径
 */
+ (NSString *)gx_pathForSystemFile:(NSSearchPathDirectory)directory;
/**
 快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName，不创建文件
 
 @param directory NSSearchPathDirectory枚举
 @param fileName 子文件名
 @return 快速返回沙盒中，你指定的系统文件的中某个子文件的路径
 */
+ (NSString *)gx_filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName;

/**
 快速返回沙盒中选定文件夹的路径
 
 @return Documents文件的路径
 */
+ (NSString *)gx_directoryPathFor:(CGXFilePathType)pathType;

/**
 快速返回沙盒中选定文件的路径

 @param pathType 类型
 @param fileName 文件名称
 @param isCreat 没有文件是否创建
 @return 文件路径
 */
+ (NSString *)gx_filePathAt:(CGXFilePathType)pathType fileName:(NSString *)fileName isCreat:(BOOL)isCreat;
/**
 快速返回沙盒中选定文件夹的路径
 
 @param pathType 类型
 @param directoryName 文件夹名称
 @param isCreat 没有文件是否创建
 @return 文件路径
 */
+ (NSString *)gx_directoryPathAt:(CGXFilePathType)pathType directoryName:(NSString *)directoryName isCreat:(BOOL)isCreat;

@end

NS_ASSUME_NONNULL_END
