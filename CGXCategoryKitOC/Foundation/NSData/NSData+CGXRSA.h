//
//  NSData+CGXRSA.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 构造公钥，私钥，证书
 
 openssl genrsa -out private_key.pem 1024
 openssl req -new -key private_key.pem -out rsaCertReq.csr
 openssl x509 -req -days 3650 -in rsaCertReq.csr -signkey private_key.pem -out rsaCert.crt
 openssl x509 -outform der -in rsaCert.crt -out public_key.der　　　　　　　　　　　　　　　// Create public_key.der For IOS
 openssl pkcs12 -export -out private_key.p12 -inkey private_key.pem -in rsaCert.crt　　// Create private_key.p12 For IOS. 这一步，请记住你输入的密码，IOS代码里会用到
 openssl rsa -in private_key.pem -out rsa_public_key.pem -pubout　　　　　　　　　　　　　// Create rsa_public_key.pem For Java
 openssl pkcs8 -topk8 -in private_key.pem -out pkcs8_private_key.pem -nocrypt　　　　　// Create pkcs8_private_key.pem For Java
 */

/**
 *  rsa加密
 *
 *  NSString *rsaPublicKeyPath = [[NSBundle mainBundle] pathForResource:@"rsa_public_key" ofType:@"der"];
 *  NSData *rsaPublicKeyData = [NSData dataWithContentsOfFile:rsaPublicKeyPath];
 *
 *  rsa解密
 *
 *  NSString *rsaPrivateKeyPath = [[NSBundle mainBundle] pathForResource:@"rsa_private_key" ofType:@"p12"];
 *  NSData *rsaPrivateKeyData = [NSData dataWithContentsOfFile:rsaPrivateKeyPath];
 */
@interface NSData (CGXRSA)

- (NSData *)gx_RSAEncryptWithPublicKey:(NSString *)publicKey;
- (NSData *)gx_RSAEncryptWithPublicKeyData:(NSData *)publicKeyData;

- (NSData *)gx_RSADecryptWithPrivateKey:(NSString *)privateKey password:(NSString *)password;
- (NSData *)gx_RSADecryptWithPrivateKeyData:(NSData *)privateKeyData password:(NSString *)password;

@end
