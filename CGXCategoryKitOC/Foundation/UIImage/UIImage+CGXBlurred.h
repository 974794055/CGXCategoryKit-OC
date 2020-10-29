//
//  UIImage+CGXBlurred.h
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/9/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CGXBlurred)

/**
 *  生成一个毛玻璃效果的图片
 *
 *  @return 返回模糊化好的图片
 */
- (UIImage *)gx_blurredImage:(CGFloat)blurAmount;

/**
 *  生成毛玻璃效果的图片
 *
 *  @param image      要模糊化的图片
 *  @param blurAmount 模糊化指数
 *
 *  @return 返回模糊化之后的图片
 */
+ (UIImage *)gx_blurredImageWithImage:(UIImage *)image andBlurAmount:(CGFloat)blurAmount;

/**
 *  生成一个毛玻璃效果的图片
 *
 *  @param blurLevel 毛玻璃的模糊程度
 *
 *  @return 毛玻璃好的图片
 */
- (UIImage *)gx_blearImageWithBlurLevel:(CGFloat)blurLevel;

@end

NS_ASSUME_NONNULL_END
