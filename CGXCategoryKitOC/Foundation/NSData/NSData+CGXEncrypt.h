//
//  NSData+CGXEncrypt.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (CGXEncrypt)

/**
 *  利用AES加密数据
 *
 *  @param key  key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param data  data description
 *
 *  @return data
 */
- (NSData *)gx_encryptedWithAESUsingKey:(NSString*)key andDtat:(NSData*)data;
/**
 *  @brief  利用AES解密据
 *
 *  @param key key 长度一般为16 （AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param data  data
 *
 *  @return 解密后数据
 */
- (NSData *)gx_decryptedWithAESUsingKey:(NSString*)key andDtat:(NSData*)data;
/**
 *  利用DES加密数据
 *
 *  @param key key 长度一般为8
 *  @param data  data description
 *
 *  @return data
 */
- (NSData *)gx_encryptedWithDESUsingKey:(NSString*)key andDtat:(NSData*)data;
/**
 *  @brief   利用DES解密数据
 *
 *  @param key key 长度一般为8
 *  @param data  data
 *
 *  @return 解密后数据
 */
- (NSData *)gx_decryptedWithDESUsingKey:(NSString*)key andDtat:(NSData*)data;
/**
 *  利用3DES加密数据
 *
 *  @param key key 长度一般为24
 *  @param data  data description
 *
 *  @return data
 */
- (NSData *)gx_encryptedWith3DESUsingKey:(NSString*)key andDtat:(NSData*)data;
/**
 *  @brief   利用3DES解密数据
 *
 *  @param key key 长度一般为24
 *  @param data  data
 *
 *  @return 解密后数据
 */
- (NSData *)gx_decryptedWith3DESUsingKey:(NSString*)key andDtat:(NSData*)data;


- (NSData *)gx_CCCryptData:(NSData *)data
              algorithm:(CCAlgorithm)algorithm
              operation:(CCOperation)operation
                    key:(NSString *)key
                andDtat:(NSData*)data1;
/**
 *  @brief  NSData 转成UTF8 字符串
 *
 *  @return 转成UTF8 字符串
 */
- (NSString *)gx_UTF8String;
@end
