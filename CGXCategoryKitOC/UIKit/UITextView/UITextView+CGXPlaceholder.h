//
//  UITextView+CGXPlaceholder.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CGXPlaceholder)

@property(nonatomic,readonly)  UILabel *gx_placeholdLabel;

@property(nonatomic,strong) IBInspectable NSString *gx_placeholder;

@property(nonatomic,strong) IBInspectable UIColor *gx_placeholderColor;

@property (nonatomic,strong) IBInspectable UIFont *gx_placeholderFont;

@property(nonnull,strong) NSAttributedString *gx_attributePlaceholder;


+ (UIColor *)gx_defaultColor;

@end

NS_ASSUME_NONNULL_END
