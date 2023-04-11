//
//  UIImage+CGXQrCode.m
//  CGXCategoryKit-OC-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UIImage+CGXQrCode.h"
#import "UIImage+CGXCompress.h"
#pragma mark - 私有
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

@implementation UIImage (CGXQrCode)

/**
 生成二维码图片
 @param url 二维码中的字符串
 @param outputSize 二维码Size
 @param logo 水印图片
 @return 一个二维码图片，水印在二维码中央
 */
+ (UIImage *)gx_qrCodeImageForDataUrl:(NSString *)url size:(CGFloat)outputSize logo:(UIImage *)logo
{
    return [UIImage gx_qrCodeQRImageWithDataobject:url outputSize:outputSize Logo:logo QRColor:[UIColor blackColor] bkColor:[UIColor whiteColor] Level:0];
}
+ (UIImage *)gx_qrCodeImageForDataDic:(NSDictionary *)dataDic size:(CGFloat)outputSize logo:(UIImage *)logo {
    return [UIImage gx_qrCodeQRImageWithDataobject:dataDic outputSize:outputSize Logo:logo QRColor:[UIColor blackColor] bkColor:[UIColor whiteColor] Level:0];
}
/// 生成二维码图片（默认大小为400*400）
/// @param content 内容
+ (UIImage *)gx_qrImageByContent:(NSString *)content
{
    return [UIImage gx_qrCodeQRImageWithDataobject:content outputSize:400 Logo:nil QRColor:[UIColor blackColor] bkColor:[UIColor whiteColor] Level:0];
}
/// 生成高清二维码
/// @param content 内容
/// @param outputSize 输出尺寸
+ (UIImage *)gx_qrImageByContent:(NSString *)content outputSize:(CGFloat)outputSize
{
    return [UIImage gx_qrCodeQRImageWithDataobject:content outputSize:outputSize Logo:nil QRColor:[UIColor blackColor] bkColor:[UIColor whiteColor] Level:0];
}
/// 生成高清二维码
/// @param content 内容
/// @param outputSize 输出尺寸
/// @param color 颜色
+ (UIImage *)gx_qrImageByContent:(NSString *)content outputSize:(CGFloat)outputSize color:(nullable UIColor *)color
{
    return [UIImage gx_qrCodeQRImageWithDataobject:content outputSize:outputSize Logo:nil QRColor:color bkColor:[UIColor whiteColor] Level:0];
}
/// 生成高清二维码
/// @param content 内容
/// @param logo logo，默认放在中间位置
+ (UIImage *)gx_qrImageWithContent:(NSString *)content outputSize:(CGFloat)outputSize logo:(nullable UIImage *)logo;
{
    return [UIImage gx_qrCodeQRImageWithDataobject:content outputSize:outputSize Logo:logo QRColor:nil bkColor:[UIColor whiteColor] Level:0];
}
/// 生成高清二维码
/// @param content 内容
/// @param logo logo，默认放在中间位置
+ (UIImage *)gx_qrImageWithContent:(NSString *)content outputSize:(CGFloat)outputSize color:(nullable UIColor *)color logo:(nullable UIImage *)logo
{
    return [UIImage gx_qrCodeQRImageWithDataobject:content outputSize:outputSize Logo:logo QRColor:color bkColor:[UIColor whiteColor] Level:0];
}
+ (UIImage *)gx_qrImageByContent:(NSString *)content outputSize:(CGFloat)outputSize tintColor:(nullable UIColor *)tintColor logo:(nullable UIImage *)logo logoFrame:(CGRect)logoFrame isCorrectionHighLevel:(BOOL)isHighLevel
{
    // 校正级别(L,M,Q,H)
    NSInteger levelString = isHighLevel ? 0:2;
    return [UIImage gx_qrCodeQRImageWithDataobject:content outputSize:outputSize Logo:logo QRColor:tintColor bkColor:[UIColor whiteColor] Level:levelString];
}
+ (UIImage* )gx_qrCodeQRImageWithDataobject:(id)object outputSize:(CGFloat)outputSize Logo:(UIImage *)logo QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor Level:(NSInteger)level
{
    if(outputSize <= 0 && object == nil){
        return nil;
    }
    NSData *stringData = [NSData data];
    if ([object isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)object;
        stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    } else{
        //将所需尽心转为UTF8的数据，并设置给filter
        NSDictionary *dict = (NSDictionary *)object;
        stringData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    }
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setDefaults];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    //设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    /*
     * L: 7%
     * M: 15%
     * Q: 25%
     * H: 30%
     */
    NSString *inputCorrectionLevel = @"H";
    if (level == 0) {
        inputCorrectionLevel = @"H";
    } else if (level == 1){
        inputCorrectionLevel = @"Q";
    }  else if (level == 2){
        inputCorrectionLevel = @"M";
    } else if (level == 3){
        inputCorrectionLevel = @"L";
    }else{
        inputCorrectionLevel = @"H";
    }
    [qrFilter setValue:inputCorrectionLevel forKey:@"inputCorrectionLevel"];
    
    UIColor *qrCodeColor = qrColor ? qrColor :[UIColor blackColor];
    UIColor *bkCodeColor = bkColor ? bkColor :[UIColor whiteColor];
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:qrCodeColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:bkCodeColor.CGColor],
                             nil];
    CIImage *qrImage = [colorFilter outputImage];
    
    //绘制
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(CGSizeMake(outputSize, outputSize));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);

//    CGRect extent = CGRectIntegral(qrImage.extent);
//    CGFloat scale = MIN(outputSize/CGRectGetWidth(extent), outputSize/CGRectGetHeight(extent));
//
//    // 1.创建bitmap;
//    size_t width = CGRectGetWidth(extent) * scale;
//    size_t height = CGRectGetHeight(extent) * scale;
//    //创建一个DeviceGray颜色空间
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
//    //width：图片宽度像素
//    //height：图片高度像素
//    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
//    //bitmapInfo：指定的位图应该包含一个alpha通道。
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    CIContext *context = [CIContext contextWithOptions:nil];
//    //创建CoreGraphics image
//    CGImageRef bitmapImage = [context createCGImage:qrImage fromRect:extent];
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//    // 2.保存bitmap到图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
//    //原图
//    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
//    outputImage = [outputImage gx_modifyQRCodeImageTintColor:qrColor];
    
    // 添加logo
    if (logo != nil) {
        CGSize logoSize = logo.size;
        if (logoSize.width > outputSize || logoSize.height > outputSize) {
            // 对图片进行压缩
            UIImage *logoImage = [UIImage gx_compressWithImage:logo scaledToSize:CGSizeMake(outputSize*0.2, outputSize*0.2)];
            logoSize = CGSizeMake(logoImage.size.width, logoImage.size.height);
        }
        //给二维码加 logo 图
        UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
        [outputImage drawInRect:CGRectMake(0, 0, outputSize, outputSize)];
        //logo图
        //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
        [logo drawInRect:CGRectMake((outputSize-logoSize.width)/2.0, (outputSize-logoSize.height)/2.0, logoSize.width, logoSize.height)];
        outputImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return outputImage;
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
/*
 1.先对画布进行裁切
 2.填充背景颜色
 3.执行绘制logo
 4.添加并绘制白色边框
 5.白色边框的基础上进行绘制黑色分割线
 */
+ (UIImage *)gx_qrClipCornerRadius:(UIImage *)image withSize:(CGSize)size Radius:(CGFloat)radius  FillColor:(UIColor *)fillColor
{
    // 白色border的宽度
    CGFloat outerWidth = size.width/15.0;
    // 黑色border的宽度
    CGFloat innerWidth = outerWidth/10.0;
    // 设置圆角
    CGFloat corenerRadius = radius;
    // 为context创建一个区域
    CGRect areaRect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *areaPath = [UIBezierPath bezierPathWithRoundedRect:areaRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corenerRadius, corenerRadius)];
    // 因为UIBezierpath划线是双向扩展的 初始位置就不会是（0，0）
    // origin position
    CGFloat outerOrigin = outerWidth/2.0;
    CGFloat innerOrigin = innerWidth/2.0 + outerOrigin/1.2;
    CGRect outerRect = CGRectInset(areaRect, outerOrigin, outerOrigin);
    CGRect innerRect = CGRectInset(outerRect, innerOrigin, innerOrigin);
    //  外层path
    UIBezierPath *outerPath = [UIBezierPath bezierPathWithRoundedRect:outerRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(outerRect.size.width/5.0, outerRect.size.width/5.0)];
    //  内层path
    UIBezierPath *innerPath = [UIBezierPath bezierPathWithRoundedRect:innerRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(innerRect.size.width/5.0, innerRect.size.width/5.0)];
    // 创建上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);{
        // 翻转context
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1, -1);
        // 1.先对画布进行裁切
        CGContextAddPath(context, areaPath.CGPath);
        CGContextClip(context);
        // 2.填充背景颜色
        CGContextAddPath(context, areaPath.CGPath);
        UIColor *fillColorRR = fillColor ? fillColor:[UIColor whiteColor];
        CGContextSetFillColorWithColor(context, fillColorRR.CGColor);
        CGContextFillPath(context);
        // 3.执行绘制logo
        CGContextDrawImage(context, innerRect, image.CGImage);
        // 4.添加并绘制白色边框
        CGContextAddPath(context, outerPath.CGPath);
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, outerWidth);
        CGContextStrokePath(context);
        // 5.白色边框的基础上进行绘制黑色分割线
        CGContextAddPath(context, innerPath.CGPath);
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, innerWidth);
        CGContextStrokePath(context);
    }CGContextRestoreGState(context);
    UIImage *radiusImage  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return radiusImage;
}


@end
