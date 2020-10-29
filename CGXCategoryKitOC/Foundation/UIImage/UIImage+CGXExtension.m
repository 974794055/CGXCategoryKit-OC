//
//  UIImage+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "UIImage+CGXExtension.h"
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVAsset.h>
#import <CoreImage/CoreImage.h>
@implementation UIImage (CGXExtension)
/**
 *  获取图片宽
 */
- (CGFloat)gx_width {
    
    return self.size.width;
}

/**
 *  获取图片高
 */
- (CGFloat)gx_height {
    
    return self.size.height;
}

/**
 *  获取启动页图片
 *
 *  @return 启动页图片
 */
+ (UIImage *)gx_launchImage {
    
    UIImage               *lauchImage      = nil;
    NSString              *viewOrientation = nil;
    CGSize                 viewSize        = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation     = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        
        viewOrientation = @"Landscape";
        
    } else {
        
        viewOrientation = @"Portrait";
    }
    
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    
    return lauchImage;
}

/**
 *  加载非.Bound文件下图片，单张、或2x、3x均适用(若加载非png图片需要拼接后缀名)
 *
 *  @param image 图片名
 */
+ (UIImage *)gx_loadImage:(NSString *)image {
    
    return [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:image]];
}

/**
 *  加载.Bound文件下图片(无子文件夹，若加载非png图片需要拼接后缀名)
 *
 *  @param image 图片名
 *
 *  images  bundle名：images.bundle
 */
+ (UIImage *)gx_bundleImage:(NSString *)image BundleName:(NSString *)bundle
{
    
    return [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:bundle ofType:@"bundle"] stringByAppendingPathComponent:image]];
}

/**
 *  加载.Bound文件下子文件夹图片(若加载非png图片需要拼接后缀名)
 *
 *  @param fileName 图片文件夹名
 *
 *  @param fileImage 图片名
 *
 *  images bundle名：images.bundle
 */
+ (UIImage *)gx_fileImage:(NSString *)fileImage fileName:(NSString *)fileName BundleName:(NSString *)bundle
{
    
    return [UIImage imageWithContentsOfFile:[[[[NSBundle mainBundle] pathForResource:bundle ofType:@"bundle"] stringByAppendingPathComponent:fileName] stringByAppendingPathComponent:fileImage]];
}

//字符串转图片
+ (UIImage *)gx_strToImage:(NSString *)encodedImageStr {
    
    NSData *decodedImageData = [[NSData alloc]initWithBase64EncodedString:encodedImageStr options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    
    return decodedImage;
}




+ (UIImage *)gx_videoFirstImage:(NSURL *)path {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}




+ (BOOL)gx_imageEqualToImage:(UIImage *)image anotherImage:(UIImage *)anotherImage {
    
    NSData *orginalData = UIImagePNGRepresentation(image);
    NSData *anotherData = UIImagePNGRepresentation(anotherImage);
    if ([orginalData isEqual:anotherData]) {
        return YES;
    }
    return NO;
}













/**
 *  保存图片在沙盒，仅仅支持PNG、JPG、JPEG
 *
 *  @param image         传入的图片
 *  @param imgName       图片的命名
 *  @param imgType       图片格式
 *  @param directoryPath 图片存放的路径
 */
+(void)gx_saveImg:(UIImage *)image withImageName:(NSString *)imgName imgType:(NSString *)imgType inDirectory:(NSString *)directoryPath
{
    if ([[imgType lowercaseString] isEqualToString:@"png"]) {
        NSString *path = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",imgName,imgType]];
        //返回一个PNG图片
        [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    }else if ([[imgType lowercaseString] isEqualToString:@"jpg"]
              || [[imgType lowercaseString] isEqualToString:@"jpeg"])
    {
        NSString *path = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",imgName,imgType]];
        //第二个参数压缩质量（0最大的压缩  1最小的压缩质量）
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
    }
    else
    {
        NSLog(@"不支持该图片格式");
    }
}


@end
