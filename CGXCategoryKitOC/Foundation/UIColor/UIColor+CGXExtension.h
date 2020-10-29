//
//  UIColor+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CGXExtension)

//从十六进制字符串获取颜色，

//默认alpha值为1
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)gx_colorWithHexString:(NSString *)color;
+ (UIColor *)gx_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)gx_colorWithCSS:(NSString*)css;

// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)gx_colorWithHex:(long)hex;
+ (UIColor *)gx_colorWithHex:(long)hex alpha:(CGFloat)alpha;

+ (UIColor *)gx_randomColor;

/** RGB颜色 */
+ (UIColor *)gx_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;


@end

NS_ASSUME_NONNULL_END
