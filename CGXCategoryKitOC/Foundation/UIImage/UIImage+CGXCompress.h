//
//  UIImage+CGXCompress.h
//  CGXCategoryKit-OC
//
//  CGXCategoryKit-OC
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CGXCompress)
/**
 *  压缩上传图片到指定字节
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *  @return 压缩后图片的二进制
 */
+ (NSData *)gx_compressWithImage:(UIImage *)image toMaxLength:(NSInteger)maxLength maxWidth:(NSInteger)maxWidth;
/**
 *  获得指定size的图片
 *  @param image   原始图片
 *  @param newSize 指定的size
 *  @return 调整后的图片
 */
+ (UIImage *)gx_resizeImage:(UIImage *)image withNewSize:(CGSize)newSize;
/**
 *  拉伸图片
 *  @param name 图片名字
 *  @return 拉伸好的图片
 */
+ (UIImage *)gx_resizedImageWithImageName:(NSString *)name;
/**
 *  拉伸图片
 *
 *  @param image 要拉伸的图片
 *
 *  @return 拉伸好的图片
 */
+ (UIImage *)gx_resizedImageWithImage:(UIImage *)image;
/**
 *  通过指定图片最长边，获得等比例的图片size
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *  @return 获得等比例的size
 */
+ (CGSize)gx_scaleImage:(UIImage *)image withLength:(CGFloat)imageLength;
/**
 *  图片进行压缩
 *  @param image   要压缩的图片
 *  @param percent 要压缩的比例(建议在0.3以上)
 *  @return 压缩之后的图片
 *  @exception 压缩之后为image/jpeg 格式
 */
+ (UIImage *)gx_compressWithImage:(UIImage *)image percent:(float)percent;
/**
 *  对图片进行压缩
 *  @param image   要压缩的图片
 *  @param newSize 压缩后的图片的像素尺寸
 *  @return 压缩好的图片
 */
+ (UIImage *)gx_compressWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
/**
 *  对图片进行压缩
 *  @param image   要压缩的图片
 *  @param kb 压缩后的图片的内存大小
 *  @return 压缩好的图片
 */
+ (UIImage *)gx_compressWithImage:(UIImage*)image scaledToKB:(NSInteger)kb;
/**
 *  对图片进行压缩
 *  @param image   要压缩的图片
 *  @param maxLength 压缩后的图片的内存大小
 *  @return 压缩好的图片
 */
+ (UIImage *)gx_compressWithImage:(UIImage *)image toByte:(NSInteger)maxLength;



@end

NS_ASSUME_NONNULL_END
