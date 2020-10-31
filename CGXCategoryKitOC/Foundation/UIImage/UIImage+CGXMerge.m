//
//  UIImage+CGXMerge.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "UIImage+CGXMerge.h"

@implementation UIImage (CGXMerge)
/**
 *  @brief  合并两个图片
 *
 *  @param firstImage  一个图片
 *  @param secondImage 二个图片
 *
 *  @return 合并后图片
 */
+ (UIImage*)gx_mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage
{
    CGImageRef firstImageRef = firstImage.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [firstImage drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [secondImage drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)gx_spliceFirstImage:(UIImage *)firstImage secondImage:(UIImage *)secondImage {
    
    CGSize size1 = firstImage.size;
    
    UIGraphicsBeginImageContextWithOptions(firstImage.size, NO, [[UIScreen mainScreen] scale]);
    [firstImage drawInRect:CGRectMake(0, 0, firstImage.size.width, firstImage.size.height)];
    
    //    [img2 drawInRect:CGRectMake((size1.width-size2.width)/2.0, (size1.height-size2.height)/2.0, size2.width, size2.height)];
    [secondImage drawInRect:CGRectMake(size1.width/4.0, size1.height/2.5, size1.width/2, size1.width/2)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}
/**
 *  给图片添加水印
 *
 *  @param bgName         云图的名字
 *  @param waterImageName 水印的名字
 *
 *  @return 添加完水印的图片
 */
+ (UIImage *)gx_waterImageWithName:(NSString *)bgName WaterImageName:(NSString *)waterImageName
{
    UIImage *bgImage = [UIImage imageNamed:bgName];
    CGSize imageViewSize = bgImage.size;
    UIGraphicsBeginImageContextWithOptions(imageViewSize, NO, 0.0);
    [bgImage drawInRect:CGRectMake(0, 0, imageViewSize.width, imageViewSize.height)];
    UIImage *waterImage = [UIImage imageNamed:waterImageName];
    CGFloat scale = 0.2;
    CGFloat margin = 5;
    CGFloat waterW = imageViewSize.width * scale;
    CGFloat waterH = imageViewSize.height * scale;
    CGFloat waterX = imageViewSize.width - waterW - margin;
    CGFloat waterY = imageViewSize.height - waterH - margin;
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
