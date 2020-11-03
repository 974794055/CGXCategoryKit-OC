//
//  NSData+CGXGzip.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSData (CGXGzip)
/// 如果数据经过gzip编码，则此方法将返回YES。
- (BOOL)gx_isGzippedData;
/// 如果数据经过zlib编码，则此方法将返回YES。
- (BOOL)gx_isZlibbedData;
/// 此方法将应用gzip deflate算法并返回压缩数据。 压缩级别是介于0.0和1.0之间的浮点值，其中0.0表示无压缩，而1.0表示最大压缩。 值0.1将提供最快的压缩率。 如果提供负值，这将应用默认的压缩级别，该值大约等于0.7。
/// @param level 0.0 ~ 1.0
- (nullable NSData *)gx_gzippedDataWithCompressionLevel:(float)level;
/// 默认压缩级别。
- (nullable NSData *)gx_gzippedData;
/// 此方法将解压缩使用deflate算法压缩的数据并返回结果。
- (nullable NSData *)gx_gunzippedData;
/// 此方法将应用zlib deflate算法并返回压缩数据。
/// @param level 压缩级别
- (nullable NSData *)gx_zlibbedDataWithCompressionLevel:(float)level;
/// 以默认压缩级别将数据压缩为zlib压缩。
- (nullable NSData *)gx_zlibbedData;
/// 从zlib压缩的数据中解压缩数据。
- (nullable NSData *)gx_unzlibbedData;
/// 从main bundle获取文件数据
/// @param name 文件名称（在main bundle）
+ (nullable NSData *)gx_dataNamed:(NSString *_Nonnull)name;
@end
