//
//  UIFont+CGXDynamicFontControl.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIFont+CGXDynamicFontControl.h"

@implementation UIFont (CGXDynamicFontControl)

+(UIFont *)gx_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName{
    return [UIFont gx_preferredFontForTextStyle:style withFontName:fontName scale:1.0f];
}

+(UIFont *)gx_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName scale:(CGFloat)scale{
    
    
    UIFont * font = nil;
    if([[UIFont class] resolveClassMethod:@selector(preferredFontForTextStyle:)]){
        font = [UIFont preferredFontForTextStyle:fontName];
    }else{
        font = [UIFont fontWithName:fontName size:14 * scale];
    }
    
    
    return [font gx_adjustFontForTextStyle:style];

}

-(UIFont *)gx_adjustFontForTextStyle:(NSString *)style{
    return [self gx_adjustFontForTextStyle:style scale:1.0f];
}

-(UIFont *)gx_adjustFontForTextStyle:(NSString *)style scale:(CGFloat)scale{
    
    UIFontDescriptor * fontDescriptor = nil;
    
    if([[UIFont class] resolveClassMethod:@selector(preferredFontForTextStyle:)]){
        
        fontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:style];
        
    }else{
        
        fontDescriptor = self.fontDescriptor;
        
    }
    
    float dynamicSize = [fontDescriptor pointSize] * scale + 3;
    
    return [UIFont fontWithName:self.fontName size:dynamicSize];
    
}

@end
