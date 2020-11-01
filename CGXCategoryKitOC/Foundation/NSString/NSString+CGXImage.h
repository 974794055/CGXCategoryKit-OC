//
//  NSString+CGXImage.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (CGXImage)
/** 图片转字符串 */
+ (NSString *)gx_ImageToStr:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
