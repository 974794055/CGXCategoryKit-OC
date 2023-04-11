//
//  UIImage+CGXRemoteSize.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "UIImage+CGXRemoteSize.h"
#import <objc/runtime.h>

@interface UIImage()<NSURLSessionDelegate>

@end

@implementation UIImage (RemoteSize)

+ (void)gx_requestSizeNoHeader:(NSURL*)imgURL completion:(CGXRemoteSizeRequestCompleted)completion{
    
    if(![imgURL isFileURL] ) {
        NSURLRequest* request = [NSURLRequest requestWithURL:imgURL];
        __block NSData* retultData;
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            retultData = data;
            UIImage *image = [UIImage imageWithData:data];
            CGSize imageSize = image.size;
            if(completion){
                completion(imgURL,imageSize);
            }
        }];
        [dataTask resume];
    }
}


+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];

   __block NSData* retultData;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        retultData = data;
    }];
    [dataTask resume];
    if(retultData.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [retultData getBytes:&w1 range:NSMakeRange(0, 0)];
        [retultData getBytes:&w2 range:NSMakeRange(1, 1)];
        [retultData getBytes:&w3 range:NSMakeRange(2, 1)];
        [retultData getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [retultData getBytes:&h1 range:NSMakeRange(4, 1)];
        [retultData getBytes:&h2 range:NSMakeRange(5, 1)];
        [retultData getBytes:&h3 range:NSMakeRange(6, 1)];
        [retultData getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+ (CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];

    __block NSData* retultData;
     NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         retultData = data;
     }];
     [dataTask resume];
    
    if(retultData.length == 4)
    {
        short w1 = 0, w2 = 0;
        [retultData getBytes:&w1 range:NSMakeRange(0, 1)];
        [retultData getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [retultData getBytes:&h1 range:NSMakeRange(2, 1)];
        [retultData getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

+ (CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    __block NSData* retultData;
     NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         retultData = data;
     }];
     [dataTask resume];
    if ([retultData length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([retultData length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [retultData getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [retultData getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [retultData getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [retultData getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [retultData getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [retultData getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [retultData getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [retultData getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [retultData getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [retultData getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [retultData getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [retultData getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [retultData getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [retultData getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

@end
