//
//  UIColor+CGXLightDark.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/29.
//  Copyright © 2020 CGX. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CGXLightDark)

+ (UIColor *)gx_colorWithLight:(UIColor *)lightColor Dark:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
