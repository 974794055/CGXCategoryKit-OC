//
//  NSFileManager+CGXData.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSFileManager+CGXData.h"

@implementation NSFileManager (CGXData)

+ (double)gx_fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        double theSize = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        return theSize;
    }
    return 0;
}

+ (NSString *)gx_fileSizeStringAtPath:(NSString*)filePath
{
    
    double fileSize = [NSFileManager gx_fileSizeAtPath:filePath];
    if (fileSize == 0) {
        return nil;
    }else
    {
        NSString *ret = nil;
        if (fileSize<=0) {
            ret = @"0.00B";
        } else if (fileSize < 1024) {
            ret = [NSString stringWithFormat:@"%.2fB", fileSize];
        } else if (fileSize < 1024*1024) {
            ret = [NSString stringWithFormat:@"%.2fKB", fileSize/1024];
        } else if (fileSize < 1024*1024*1024) {
            ret = [NSString stringWithFormat:@"%.2fMB", fileSize/(1024*1024)];
        } else {
            ret = [NSString stringWithFormat:@"%.2fGB", fileSize/(1024*1024*1024)];
        }
        return ret;
    }
}

+ (void)gx_writeDataToSharedDocumentsWith:(NSData *)data directoryName:(NSString *)directory fileName:(NSString *)file result:(void(^)(BOOL isSuccess))resultBlock
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath;
    if (directory != nil) {
        filePath = [NSString stringWithFormat:@"%@/%@/",documentsPath,directory];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            // 如果没有创建一个文件夹
            [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        } else {
            NSLog(@"%@已存在.",filePath);
        }
    } else {
        filePath = [NSString stringWithString:documentsPath];
    }
    if (file != nil) {
        filePath = [filePath stringByAppendingPathComponent:file];
    }
    if (resultBlock) {
        resultBlock([data writeToFile:filePath atomically:YES]);
    }
}

+ (void)gx_writeDataToFile:(NSString *)filePath data:(NSData *)data
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        BOOL flag = [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        if (!flag) {
            return;
        }
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
        [fileHandle writeData:data]; //追加写入数据
        [fileHandle closeFile];
    });
}

#pragma mark 统计文件夹大小，指定忽略的文件扩展名，extensions = @[@"txt", @"mp4"]
- (NSUInteger)gx_sizeOfBitWithFolderPath :(NSString *)path ignore:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self gx_sizeOfByteWithFolderPath:path ignore:extensions error:error] * 8;
}
- (NSUInteger)gx_sizeOfByteWithFolderPath:(NSString *)path ignore:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    NSString *filePath;
    NSDictionary *fileDict;
    BOOL isExist = NO;
    BOOL isDirectory = NO;
    BOOL isIgnore = NO;
    NSUInteger byteSize = 0;
    
    for ( NSString *subPath in [self subpathsAtPath:path] ) {
        
        // 忽略某些扩展名的文件
        for ( NSString *igonreExtension in extensions ) {
            isIgnore = [subPath hasSuffix:igonreExtension];
            if ( isIgnore ) break; // 找到-跳出
        }
        if ( isIgnore ) continue; // 略过
        
        // 继续
        filePath = [path stringByAppendingPathComponent:subPath];
        isExist = [self fileExistsAtPath:filePath isDirectory:&isDirectory];
        if ( isExist && isDirectory == NO ) {
            
            fileDict = [self attributesOfItemAtPath:filePath error:error];
            if ( nil == error ) {
                byteSize += [[fileDict objectForKey:NSFileSize] unsignedIntegerValue];
            }
        }
    }
    return byteSize;
}
- (double)gx_sizeOfKiloByteWithFolderPath:(NSString *)path ignore:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self gx_sizeOfByteWithFolderPath:path ignore:extensions error:error] / 1000.f;
}
- (double)gx_sizeOfMegaByteWithFolderPath:(NSString *)path ignore:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self gx_sizeOfKiloByteWithFolderPath:path ignore:extensions error:error] / 1000.f;
}
- (double)gx_sizeOfGigaByteWithFolderPath:(NSString *)path ignore:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self gx_sizeOfMegaByteWithFolderPath:path ignore:extensions error:error] / 1000.f;
}


#pragma mark 统计文件夹大小，指定包含的文件扩展名，extensions = @[@"txt", @"mp4"]
- (NSUInteger)gx_sizeOfBitWithFolderPath :(NSString *)path contain:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self gx_sizeOfByteWithFolderPath:path contain:extensions error:error] * 8;
}
- (NSUInteger)gx_sizeOfByteWithFolderPath:(NSString *)path contain:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    NSString *filePath;
    NSDictionary *fileDict;
    BOOL isExist = NO;
    BOOL isDirectory = NO;
    BOOL isIgnore = YES;
    NSUInteger byteSize = 0;
    
    for ( NSString *subPath in [self subpathsAtPath:path] ) {
        
        // 统计指定扩展名的文件
        for ( NSString *containExtension in extensions ) {
            isIgnore = ! [subPath hasSuffix:containExtension];
            if ( NO == isIgnore ) break; // 找到-跳出
        }
        if ( isIgnore ) continue; // 略过
        
        // 继续
        filePath = [path stringByAppendingPathComponent:subPath];
        isExist = [self fileExistsAtPath:filePath isDirectory:&isDirectory];
        if ( isExist && isDirectory == NO ) {
            
            fileDict = [self attributesOfItemAtPath:filePath error:error];
            if ( nil == error ) {
                byteSize += [[fileDict objectForKey:NSFileSize] unsignedIntegerValue];
            }
        }
    }
    return byteSize;
}
- (double)gx_sizeOfKiloByteWithFolderPath:(NSString *)path contain:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self gx_sizeOfByteWithFolderPath:path contain:extensions error:error] / 1000.f;
}
- (double)gx_sizeOfMegaByteWithFolderPath:(NSString *)path contain:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self gx_sizeOfKiloByteWithFolderPath:path contain:extensions error:error] / 1000.f;
}
- (double)gx_sizeOfGigaByteWithFolderPath:(NSString *)path contain:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self gx_sizeOfMegaByteWithFolderPath:path contain:extensions error:error] / 1000.f;
}


#pragma mark 统计文件夹大小
- (NSUInteger)gx_sizeOfBitWithFolderPath:(NSString *)path error:(NSError **)error
{
    return [self gx_sizeOfBitWithFolderPath:path ignore:nil error:error];
}
- (NSUInteger)gx_sizeOfByteWithFolderPath:(NSString *)path error:(NSError **)error
{
    return [self gx_sizeOfByteWithFolderPath:path ignore:nil error:error];
}
- (double)gx_sizeOfKiloByteWithFolderPath:(NSString *)path error:(NSError **)error
{
    return [self gx_sizeOfKiloByteWithFolderPath:path ignore:nil error:error];
}
- (double)gx_sizeOfMegaByteWithFolderPath:(NSString *)path error:(NSError **)error
{
    return [self gx_sizeOfMegaByteWithFolderPath:path ignore:nil error:error];
}
- (double)gx_sizeOfGigaByteWithFolderPath:(NSString *)path error:(NSError **)error
{
    return [self gx_sizeOfGigaByteWithFolderPath:path ignore:nil error:error];
}


#pragma mark 删除文件夹
- (void)gx_clearFolderWithPath:(NSString *)path error:(NSError **)error
{
    NSString *dirPath;
    BOOL success = YES;
    
    NSArray *dirs = [self contentsOfDirectoryAtPath:path error:error];
    if ( error ) return;
    
    for ( NSString *dir in dirs ) {
        dirPath = [path stringByAppendingPathComponent:dir];
        success = [self removeItemAtPath:dirPath error:error];
        if ( success == NO || error ) return;
    }
}

@end
