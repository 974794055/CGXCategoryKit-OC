//
//  UILabel+CGXAdaptive.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (CGXAdaptive)

// General method. If minSize is set to CGSizeZero then
// it is ignored
// =====================================================
- (void)gx_adjustMaximumSize:(CGSize)maxSize
                     minimumSize:(CGSize)minSize 
                 minimumFontSize:(int)minFontSize;

// Adjust label using only the maximum size and the 
// font size as constraints
// =====================================================
- (void)gx_adjustMaximumSize:(CGSize)maxSize
                 minimumFontSize:(int)minFontSize;

// Adjust the size of the label using only the font
// size as a constraint (the maximum size will be
// calculated automatically based on the screen size)
// =====================================================
- (void)gx_adjustSizeWithMinimumFontSize:(int)minFontSize;

// Adjust label without any constraints (the maximum 
// size will be calculated automatically based on the
// screen size)
// =====================================================
- (void)gx_adjustLabel;

@end
