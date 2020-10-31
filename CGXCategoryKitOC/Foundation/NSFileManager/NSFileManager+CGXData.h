//
//  NSFileManager+CGXData.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (CGXData)

/// 获取单个文件的大小
/// @param filePath 文件路径
+ (double)gx_fileSizeAtPath:(NSString*)filePath;
/**
 获取单个文件的大小
 @param filePath 文件路径
 @return 文件大小 B,KB,MB,GB 保留两位
 */
+ (NSString *)gx_fileSizeStringAtPath:(NSString*)filePath;
/**
 向itunes共享文件夹中写入文件，即NSDocumentDirectory
 @param data 数据
 @param directory 文件夹名称
 @param file 文件名称
 */
+ (void)gx_writeDataToSharedDocumentsWith:(NSData *)data directoryName:(NSString *)directory fileName:(NSString *)file result:(void(^)(BOOL isSuccess))resultBlock;
/**
 向文件写入数据
 @param filePath 文件路径
 */
+ (void)gx_writeDataToFile:(NSString *)filePath data:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
