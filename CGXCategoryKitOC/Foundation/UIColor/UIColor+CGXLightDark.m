//
//  UIColor+LightDark.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIColor+CGXLightDark.h"

@implementation UIColor (CGXLightDark)

+ (UIColor *)gx_colorWithLight:(UIColor *)lightColor Dark:(UIColor *)darkColor
{
    UIColor *dyColor = [UIColor whiteColor];
    if (@available(iOS 13.0, *)) {
         dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return lightColor;
            }else {
                return darkColor;
            }
        }];
    }else{
        dyColor = lightColor;
    }
    return dyColor;
}
@end
