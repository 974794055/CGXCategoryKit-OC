//
//  UIFont+CGXDynamicFontControl.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIFont (CGXDynamicFontControl)


+(UIFont *)gx_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName scale:(CGFloat)scale;

+(UIFont *)gx_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName;



-(UIFont *)gx_adjustFontForTextStyle:(NSString *)style;

-(UIFont *)gx_adjustFontForTextStyle:(NSString *)style scale:(CGFloat)scale;



@end
