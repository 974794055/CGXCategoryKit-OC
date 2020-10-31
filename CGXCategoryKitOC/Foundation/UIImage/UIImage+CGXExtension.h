//
//  UIImage+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CGXExtension)
/**
 *  获取图片宽
 */
- (CGFloat)gx_width;
/**
 *  获取图片高
 */
- (CGFloat)gx_height;
/**
 *  获取启动页图片
 *  @return 启动页图片
 */
+ (UIImage *)gx_launchImage;
/**
 *  加载非.Bound文件下图片，单张、或2x、3x均适用(若加载非png图片需要拼接后缀名)
 *  @param image 图片名
 */
+ (UIImage *)gx_loadImage:(NSString *)image;
/**
 *  加载.Bound文件下图片(无子文件夹，若加载非png图片需要拼接后缀名)
 *  @param image 图片名
 */
+ (UIImage *)gx_bundleImage:(NSString *)image BundleName:(NSString *)bundle;
/**
 *  加载.Bound文件下子文件夹图片(若加载非png图片需要拼接后缀名)
 *  @param fileName 图片文件夹名
 *  @param fileImage 图片名
 */
+ (UIImage *)gx_fileImage:(NSString *)fileImage fileName:(NSString *)fileName BundleName:(NSString *)bundle;
/** 字符串转图片 */
+ (UIImage *)gx_strToImage:(NSString *)encodedImageStr;

/** 根据视频url获取第一帧图片*/
+ (UIImage *)gx_videoFirstImage:(NSURL *)path;
/**
 对比两张图片是否相同
 @param image 原图
 @param anotherImage 需要比较的图片

 */
+ (BOOL)gx_imageEqualToImage:(UIImage*)image anotherImage:(UIImage *)anotherImage;

/**
 *  保存图片在沙盒，仅仅支持PNG、JPG、JPEG
 *
 *  @param image         传入的图片
 *  @param imgName       图片的命名
 *  @param imgType       图片格式
 *  @param directoryPath 图片存放的路径
 */
+(void)gx_saveImg:(UIImage *)image withImageName:(NSString *)imgName imgType:(NSString *)imgType inDirectory:(NSString *)directoryPath;

@end

NS_ASSUME_NONNULL_END
