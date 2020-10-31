//
//  UIImage+CGXQrCode.h
//  CGXCategoryKit-OC-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CGXQrCode)


/**
 生成二维码图片
 @param url 二维码中的字符串
 @param size 二维码Size
 @param logo 水印图片
 @return 一个二维码图片，水印在二维码中央
 */
+ (UIImage *)gx_qrCodeImageForDataUrl:(NSString *)url size:(CGFloat)size logo:(UIImage *)logo;
/**
 生成二维码图片
 @param dataDic 二维码中的信息
 @param size 二维码Size
 @param logo 水印图片
 @return 一个二维码图片，水印在二维码中央
 */
+ (UIImage *)gx_qrCodeImageForDataDic:(NSDictionary *)dataDic size:(CGFloat)size logo:(UIImage *)logo;

/// 生成高清二维码图片（默认大小为430*430）
/// @param content 内容
+ (UIImage *)gx_qrImageByContent:(NSString *)content;

/// 生成高清二维码
/// @param content 内容
/// @param outputSize 输出尺寸
+ (UIImage *)gx_qrImageByContent:(NSString *)content outputSize:(CGFloat)outputSize;

/// 生成高清二维码
/// @param content 内容
/// @param outputSize 输出尺寸
/// @param color 颜色
+ (UIImage *)gx_qrImageByContent:(NSString *)content outputSize:(CGFloat)outputSize color:(nullable UIColor *)color;

/// 生成高清二维码
/// @param content 内容
/// @param logo logo，默认放在中间位置
+ (UIImage *)gx_qrImageWithContent:(NSString *)content outputSize:(CGFloat)outputSize logo:(nullable UIImage *)logo;

/// 生成二维码
/// @param content 内容
/// @param outputSize 生成尺寸
/// @param tintColor 颜色，设置颜色时背景会变为透明
/// @param logo logo图
/// @param logoFrame logo位置
/// @param isHighLevel 是否高清，设置颜色和logo默认高清
+ (UIImage *)gx_qrImageByContent:(NSString *)content outputSize:(CGFloat)outputSize tintColor:(nullable UIColor *)tintColor logo:(nullable UIImage *)logo logoFrame:(CGRect)logoFrame isCorrectionHighLevel:(BOOL)isHighLevel;

/// 修改二维码图片颜色
/// @param color 颜色
- (UIImage *)gx_modifyQRCodeImageTintColor:(UIColor *)color;
/**
 获取二维码内内容
 */
- (NSString *)gx_getQRCodeContentString;

@end

NS_ASSUME_NONNULL_END
