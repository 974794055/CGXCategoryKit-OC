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


#pragma mark 统计文件夹大小，指定忽略的文件扩展名，extensions = @[@"txt", @"mp4"]
- (NSUInteger)gx_sizeOfBitWithFolderPath:(NSString *)path
                                   ignore:(nullable NSArray<NSString *> *)extensions
                                    error:(NSError **)error; // bit

- (NSUInteger)gx_sizeOfByteWithFolderPath:(NSString *)path
                                    ignore:(nullable NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // byte

- (double)gx_sizeOfKiloByteWithFolderPath:(NSString *)path
                                    ignore:(nullable NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // KB

- (double)gx_sizeOfMegaByteWithFolderPath:(NSString *)path
                                    ignore:(nullable NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // MB

- (double)gx_sizeOfGigaByteWithFolderPath:(NSString *)path
                                    ignore:(nullable NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // GB


#pragma mark 统计文件夹大小，指定包含的文件扩展名，extensions = @[@"txt", @"mp4"]
- (NSUInteger)gx_sizeOfBitWithFolderPath:(NSString *)path
                                  contain:(NSArray<NSString *> *)extensions
                                    error:(NSError **)error; // bit

- (NSUInteger)gx_sizeOfByteWithFolderPath:(NSString *)path
                                   contain:(NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // byte

- (double)gx_sizeOfKiloByteWithFolderPath:(NSString *)path
                                   contain:(NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // KB

- (double)gx_sizeOfMegaByteWithFolderPath:(NSString *)path
                                   contain:(NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // MB

- (double)gx_sizeOfGigaByteWithFolderPath:(NSString *)path
                                   contain:(NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // GB


#pragma mark 统计文件夹大小
- (NSUInteger)gx_sizeOfBitWithFolderPath :(NSString *)path error:(NSError **)error; // bit
- (NSUInteger)gx_sizeOfByteWithFolderPath:(NSString *)path error:(NSError **)error; // byte
- (double)gx_sizeOfKiloByteWithFolderPath:(NSString *)path error:(NSError **)error; // KB
- (double)gx_sizeOfMegaByteWithFolderPath:(NSString *)path error:(NSError **)error; // MB
- (double)gx_sizeOfGigaByteWithFolderPath:(NSString *)path error:(NSError **)error; // GB


#pragma mark 删除文件夹
- (void)gx_clearFolderWithPath:(NSString *)path error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
