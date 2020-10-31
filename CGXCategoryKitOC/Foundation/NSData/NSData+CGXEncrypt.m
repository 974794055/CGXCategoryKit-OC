//
//  NSData+CGXEncrypt.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "NSData+CGXEncrypt.h"


@implementation NSData (CGXEncrypt)
static void FixKeyLengths(CCAlgorithm algorithm, NSMutableData * keyData, NSMutableData * ivData)
{
    NSUInteger keyLength = [keyData length];
    switch ( algorithm )
    {
        case kCCAlgorithmAES128:
        {
            if (keyLength <= 16)
            {
                [keyData setLength:16];
            }
            else if (keyLength>16 && keyLength <= 24)
            {
                [keyData setLength:24];
            }
            else
            {
                [keyData setLength:32];
            }
            
            break;
        }
            
        case kCCAlgorithmDES:
        {
            [keyData setLength:8];
            break;
        }
            
        case kCCAlgorithm3DES:
        {
            [keyData setLength:24];
            break;
        }
            
        case kCCAlgorithmCAST:
        {
            if (keyLength <5)
            {
                [keyData setLength:5];
            }
            else if ( keyLength > 16)
            {
                [keyData setLength:16];
            }
            
            break;
        }
            
        case kCCAlgorithmRC4:
        {
            if ( keyLength > 512)
                [keyData setLength:512];
            break;
        }
            
        default:
            break;
    }
    
    [ivData setLength:[keyData length]];
}

/**
 *  利用AES加密数据
 *
 *  @param key key
 *  @param data  data description
 *
 *  @return data
 */
- (NSData*)gx_encryptedWithAESUsingKey:(NSString*)key andDtat:(NSData*)data {
    return [self gx_CCCryptData:self algorithm:kCCAlgorithmAES128 operation:kCCEncrypt key:key andDtat:data];
}
/**
 *  @brief  利用AES解密据
 *
 *  @param key key
 *  @param data  data
 *
 *  @return 解密后数据
 */
- (NSData*)gx_decryptedWithAESUsingKey:(NSString*)key andDtat:(NSData*)data {
    return [self gx_CCCryptData:self algorithm:kCCAlgorithmAES128 operation:kCCDecrypt key:key andDtat:data];
}
/**
 *  利用3DES加密数据
 *
 *  @param key key
 *  @param data  data description
 *
 *  @return data
 */
- (NSData*)gx_encryptedWith3DESUsingKey:(NSString*)key andDtat:(NSData*)data {
    return [self gx_CCCryptData:self algorithm:kCCAlgorithm3DES operation:kCCEncrypt key:key andDtat:data];
}
/**
 *  @brief   利用3DES解密数据
 *
 *  @param key key
 *  @param data  data
 *
 *  @return 解密后数据
 */
- (NSData*)gx_decryptedWith3DESUsingKey:(NSString*)key andDtat:(NSData*)data {
    return [self gx_CCCryptData:self algorithm:kCCAlgorithm3DES operation:kCCDecrypt key:key andDtat:data];
}

/**
 *  利用DES加密数据
 *
 *  @param key key
 *  @param data  data description
 *
 *  @return data
 */
- (NSData *)gx_encryptedWithDESUsingKey:(NSString*)key andDtat:(NSData*)data{
    return [self gx_CCCryptData:self algorithm:kCCAlgorithmDES operation:kCCEncrypt key:key andDtat:data];
}
/**
 *  @brief   利用DES解密数据
 *
 *  @param key key
 *  @param data  data
 *
 *  @return 解密后数据
 */
- (NSData *)gx_decryptedWithDESUsingKey:(NSString*)key andDtat:(NSData*)data{
    return [self gx_CCCryptData:self algorithm:kCCAlgorithmDES operation:kCCDecrypt key:key andDtat:data];
}
- (NSData *)gx_CCCryptData:(NSData *)data
              algorithm:(CCAlgorithm)algorithm
              operation:(CCOperation)operation
                    key:(NSString *)key
                     andDtat:(NSData*)data1
{
    NSMutableData *keyData = [[key dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    NSMutableData *ivData = [data mutableCopy];
    
    size_t dataMoved;
    
    int size = 0;
    if (algorithm == kCCAlgorithmAES128 ||algorithm == kCCAlgorithmAES) {
        size = kCCBlockSizeAES128;
    }else if (algorithm == kCCAlgorithmDES) {
        size = kCCBlockSizeDES;
    }else if (algorithm == kCCAlgorithm3DES) {
        size = kCCBlockSize3DES;
    }if (algorithm == kCCAlgorithmCAST) {
        size = kCCBlockSizeCAST;
    }
    
    NSMutableData *decryptedData = [NSMutableData dataWithLength:data.length + size];
    
    int option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    if (data) {
        option = kCCOptionPKCS7Padding;
    }
    FixKeyLengths(algorithm, keyData,ivData);
    CCCryptorStatus result = CCCrypt(operation,                    // kCCEncrypt or kCCDecrypt
                                     algorithm,
                                     option,                        // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     data1.bytes,
                                     data.bytes,
                                     data.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    return nil;
}
/**
 *  @brief  NSData 转成UTF8 字符串
 *
 *  @return 转成UTF8 字符串
 */
-(NSString *)gx_UTF8String
{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end
