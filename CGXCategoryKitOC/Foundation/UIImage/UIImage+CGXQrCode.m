//
//  UIImage+CGXQrCode.m
//  CGXCategoryKit-OC-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UIImage+CGXQrCode.h"

#pragma mark - 私有
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

@implementation UIImage (CGXQrCode)

/**
 生成二维码图片
 
 @param url 二维码中的字符串
 @param size 二维码Size
 @param logo 水印图片
 @return 一个二维码图片，水印在二维码中央
 */
+ (UIImage *)gx_qrCodeImageForDataUrl:(NSString *)url size:(CGFloat)size logo:(UIImage *)logo
{
    return [self gx_qrCodeImageForDataObject:url size:size logo:logo];
}
+ (UIImage *)gx_qrCodeImageForDataDic:(NSDictionary *)dataDic size:(CGFloat)size logo:(UIImage *)logo {
    return [self gx_qrCodeImageForDataObject:dataDic size:size logo:logo];
}

+ (UIImage *)gx_qrCodeImageForDataObject:(id)object size:(CGFloat)size logo:(UIImage *)logo
{
    
    //创建名为"CIQRCodeGenerator"的CIFilter
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //将filter所有属性设置为默认值
    [filter setDefaults];
    
    NSData *data = [NSData data];
    if ([object isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)object;
        data = [string dataUsingEncoding:NSUTF8StringEncoding];
    } else{
        //将所需尽心转为UTF8的数据，并设置给filter
        NSDictionary *dict = (NSDictionary *)object;
        data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    }
    [filter setValue:data forKey:@"inputMessage"];
    //设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    /*
     * L: 7%
     * M: 15%
     * Q: 25%
     * H: 30%
     */
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    //拿到二维码图片，此时的图片不是很清晰，需要二次加工
    CIImage *outPutImage = [filter outputImage];
    
    //如果有水印图片，那么添加水印后在调整清晰度，
    //如果没有直接，直接调节清晰度
    if (!logo) {
        return [[[self alloc] init] getHDImageWithCIImage:outPutImage size:CGSizeMake(size, size)];
    } else {
        
        return [[[self alloc] init] getHDImageWithCIImage:outPutImage size:CGSizeMake(size, size) waterImage:logo];
    }
}

/**
 调整二维码清晰度
 
 @param image 模糊的二维码图片
 @param size 二维码的宽高
 @return 清晰的二维码图片
 */
- (UIImage *)getHDImageWithCIImage:(CIImage *)image size:(CGSize)size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    return outputImage;
}

/**
 调整二维码清晰度，添加水印图片
 
 @param image 模糊的二维码图片
 @param size 二维码的宽高
 @param waterImage 水印图片
 @return 添加水印图片后，清晰的二维码图片
 */
- (UIImage *)getHDImageWithCIImage:(CIImage *)image size:(CGSize)size waterImage:(UIImage *)waterImage {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    //给二维码加 logo 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //logo图
    //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    [waterImage drawInRect:CGRectMake((size.width-waterImage.size.width)/2.0, (size.height-waterImage.size.height)/2.0, waterImage.size.width, waterImage.size.height)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

/**
 遍历像素点，修改颜色
 
 @param rgbImageBuf rgbImageBuf
 @param pixelNum pixelNum
 @param red red
 @param green green
 @param blue blue
 */
+ (void)changeColorOnPixel: (uint32_t *)rgbImageBuf pixelNum: (int)pixelNum red: (NSUInteger)red green: (NSUInteger)green blue: (NSUInteger)blue {
    
    uint32_t * pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        
        if ((*pCurPtr & 0xffffff00) < 0xd0d0d000) {
            
            uint8_t * ptr = (uint8_t *)pCurPtr;
            ptr[3] = red;
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            //将白色变成透明色
            uint8_t * ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
}

+ (UIImage *)gx_qrImageByContent:(NSString *)content outputSize:(CGFloat)outputSize tintColor:(nullable UIColor *)tintColor logo:(nullable UIImage *)logo logoFrame:(CGRect)logoFrame isCorrectionHighLevel:(BOOL)isHighLevel
{
    if (content == nil || content.length == 0) {
        return nil;
    }
    UIImage *resultImage;
    BOOL openHighCorrection = isHighLevel;
    
    if (tintColor != nil || logo != nil) {
        openHighCorrection = true;
    }
    // 创建基础CIImage
    CIImage *ciImage = [UIImage qrByContent:content correctionHighLevel:openHighCorrection];
    // 根据尺寸返回image
    resultImage = [UIImage adjustHDQRCodeImageWith:ciImage output:outputSize];
    // 修改二维码颜色
    if (tintColor != nil) {
        resultImage = [resultImage gx_modifyQRCodeImageTintColor:tintColor];
    }
    // 添加logo
    if (logo != nil && CGRectEqualToRect(logoFrame, CGRectZero)) {
        resultImage = [resultImage addLogoImage:logo logoFrame:logoFrame];
    }
    
    return resultImage;
}

/// 生成二维码图片（默认大小为430*430）
/// @param content 内容
+ (UIImage *)gx_qrImageByContent:(NSString *)content
{
    return [UIImage gx_qrImageByContent:content outputSize:430 tintColor:nil logo:nil logoFrame:CGRectZero isCorrectionHighLevel:true];
}

/// 生成高清二维码
/// @param content 内容
/// @param outputSize 输出尺寸
+ (UIImage *)gx_qrImageByContent:(NSString *)content outputSize:(CGFloat)outputSize
{
    return [UIImage gx_qrImageByContent:content outputSize:outputSize tintColor:nil logo:nil logoFrame:CGRectZero isCorrectionHighLevel:true];
}

/// 生成高清二维码
/// @param content 内容
/// @param outputSize 输出尺寸
/// @param color 颜色
+ (UIImage *)gx_qrImageByContent:(NSString *)content outputSize:(CGFloat)outputSize color:(nullable UIColor *)color
{
    return [UIImage gx_qrImageByContent:content outputSize:outputSize tintColor:color logo:nil logoFrame:CGRectZero isCorrectionHighLevel:true];
}

/// 生成高清二维码
/// @param content 内容
/// @param logo logo，默认放在中间位置
+ (UIImage *)gx_qrImageWithContent:(NSString *)content outputSize:(CGFloat)outputSize logo:(nullable UIImage *)logo;
{
    CGSize logoSize = logo.size;
    if (logoSize.width > outputSize || logoSize.height > outputSize) {
        UIImage *resultImage = [UIImage gx_qrImageByContent:content outputSize:outputSize tintColor:nil logo:nil logoFrame:CGRectZero isCorrectionHighLevel:true];
        return resultImage;
    }
    CGRect frame = CGRectMake((logoSize.width - outputSize)/2, (logoSize.height - outputSize)/2, logoSize.width, logoSize.height);
    UIImage *resultImage = [UIImage gx_qrImageByContent:content outputSize:outputSize tintColor:nil logo:logo logoFrame:frame isCorrectionHighLevel:true];
    return resultImage;
}

/**
 获取二维码内内容
 */
- (NSString *)gx_getQRCodeContentString
{
    if (!self) {
        return nil;
    }
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:self.CGImage]];
    NSMutableString *contentString = [NSMutableString string];
    for (int index = 0 ; index<features.count; index++) {
        CIQRCodeFeature *feature = [features objectAtIndex:index];
        NSString *result = feature.messageString;
        [contentString appendString:result];
    }
    return contentString;
}



+ (CIImage *)qrByContent:(NSString *)content correctionHighLevel:(BOOL)isHighLevel
{
    // 创建滤镜类
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    // 输出值
    [qrFilter setValue:contentData forKey:@"inputMessage"];
    // 校正级别(L,M,Q,H)
    NSString *levelString = isHighLevel ? @"H":@"M";
    [qrFilter setValue:levelString forKey:@"inputCorrectionLevel"];
    CIImage *image = qrFilter.outputImage;
    return image;
}

/// 调整二维码图片尺寸
+ (UIImage *)adjustHDQRCodeImageWith:(CIImage *)ciImage output:(CGFloat)output
{
    // 将原矩形的值变成整数类型返回
    CGRect extent = CGRectIntegral(ciImage.extent);
    
    CGFloat scale = 5;
    if (output > 0) {
        scale = MIN(output/CGRectGetWidth(extent), output/CGRectGetHeight(extent));
    }
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    /**
     data#> 指向要渲染的绘制内存的地址
     width#> bitmap的宽度,单位为像素
     height#> bitmap的高度,单位为像素
     bitsPerComponent#> 内存中像素的每个组件的位数.例如，对于32位像素格式和RGB 颜色空间，你应该将这个值设为8.
     bytesPerRow#> bitmap的每一行在内存所占的比特数
     space#> bitmap上下文使用的颜色空间。
     bitmapInfo#> 指定bitmap是否包含alpha通道，像素中alpha通道的相对位置，像素组件是整形还是浮点型等信息的字符串。
     */
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    // 获取绘制上下文
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage *qrImage = [UIImage imageWithCGImage:scaledImage];
    return qrImage;
}

/// 修改二维码图片颜色
/// @param color 颜色
- (UIImage *)gx_modifyQRCodeImageTintColor:(UIColor *)color
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    const int imageWidth = self.size.width;
    const int imageHeight = self.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), self.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red*255; //0~255
            ptr[2] = green*255;
            ptr[1] = blue*255;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return resultImage;
}

/// 添加 logo 图像
/// @param logoImage logo图片
/// @param logoFrame logo位置
- (UIImage *)addLogoImage:(UIImage *)logoImage logoFrame:(CGRect)logoFrame
{
    // 添加logo
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [logoImage drawInRect:logoFrame];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
