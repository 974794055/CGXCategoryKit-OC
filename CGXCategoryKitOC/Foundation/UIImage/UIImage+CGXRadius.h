//
//  UIImage+CGXRadius.h
//  CGXCategoryKit-OC-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CGXRadius)

/** 圆角图片 */
- (UIImage *)gx_imageWithCornerRadius:(CGFloat)radius;

/** 圆角图片 */
- (UIImage*)gx_imageWithCornerRadius:(CGFloat)radius andSize:(CGSize)size;

/** 圆形图片 */
+ (UIImage *)gx_imageWithRoundImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
