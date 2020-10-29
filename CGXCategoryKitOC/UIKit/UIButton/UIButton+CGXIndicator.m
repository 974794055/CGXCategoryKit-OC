//
//  UIButton+CGXIndicator.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UIButton+CGXIndicator.h"
#import <objc/runtime.h>

// Associative reference keys.
static NSString *const CGXIndicatorIndicatorViewKey = @"CGXIndicatorIndicatorViewKey";
static NSString *const CGXIndicatorButtonTextObjectKey = @"CGXIndicatorButtonTextObjectKey";


@implementation UIButton (CGXIndicator)
- (void)gx_showIndicator {
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [indicator startAnimating];
    
    NSString *currentButtonText = self.titleLabel.text;
    
    objc_setAssociatedObject(self, &CGXIndicatorButtonTextObjectKey, currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &CGXIndicatorIndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTitle:@"" forState:UIControlStateNormal];
    self.enabled = NO;
    [self addSubview:indicator];
    
    
}

- (void)gx_hideIndicator {
    
    NSString *currentButtonText = (NSString *)objc_getAssociatedObject(self, &CGXIndicatorButtonTextObjectKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &CGXIndicatorIndicatorViewKey);
    
    [indicator removeFromSuperview];
    [self setTitle:currentButtonText forState:UIControlStateNormal];
    self.enabled = YES;
    
}

@end
