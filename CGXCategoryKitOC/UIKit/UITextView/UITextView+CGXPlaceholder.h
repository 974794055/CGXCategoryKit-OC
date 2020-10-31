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

@property(nonatomic,readonly)  UILabel *placeholdLabel;

@property(nonatomic,strong) IBInspectable NSString *placeholder;

@property(nonatomic,strong) IBInspectable UIColor *placeholderColor;

@property (nonatomic,strong) IBInspectable UIFont *placeholderFont;

@property(nonnull,strong) NSAttributedString *attributePlaceholder;

@property(nonatomic,assign) CGPoint location;

+ (UIColor *)defaultColor;

@end

NS_ASSUME_NONNULL_END
