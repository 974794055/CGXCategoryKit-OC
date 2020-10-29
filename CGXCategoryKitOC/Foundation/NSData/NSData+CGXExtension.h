//
//  NSData+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (CGXExtension)

//数组转json数据
+ (NSData *)gx_arrayWithJsonData:(NSMutableArray *)array;
//字典转json数据
+ (NSData *)gx_dictionaryWithJsonData:(NSMutableDictionary *)dict;
+ (NSData *)gx_strWithJsonData:(NSString *)str;
//NSFileManager实例方法读取数据
+ (NSData *)gx_redFileManagerFileName:(NSString *)name;
//NSData类方法读取数据
+ (NSData *)gx_redWithContentsFileName:(NSString *)name;
//NSFileHandle实例方法读取内容
+ (NSData *)gx_redFileHandleFileName:(NSString *)name;

/**
 Data 数据切片

 @param fragmentSize 切片大小，单位：MB
 @return 分片数组
 */
- (NSArray *)gx_cutDataWithFragmentSize:(NSInteger)fragmentSize;

@end

NS_ASSUME_NONNULL_END
