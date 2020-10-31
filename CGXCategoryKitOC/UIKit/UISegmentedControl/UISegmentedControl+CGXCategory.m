//
//  UISegmentedControl+CGXCategory.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UISegmentedControl+CGXCategory.h"
#import <objc/runtime.h>
@implementation UISegmentedControl (CGXCategory)

- (void)gx_segmentedIOS13Style
{
    if (@available(iOS 13, *)) {
        UIColor *tintColor = [self tintColor];
        UIImage *tintColorImage = [self imageWithColor:tintColor];
        // Must set the background image for normal to something (even clear) else the rest won't work
        [self setBackgroundImage:[self imageWithColor:self.backgroundColor ? self.backgroundColor : [UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:tintColorImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:[self imageWithColor:[tintColor colorWithAlphaComponent:0.2]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:tintColorImage forState:UIControlStateSelected|UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName: tintColor, NSFontAttributeName: [UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
        [self setDividerImage:tintColorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [tintColor CGColor];
        self.selectedSegmentTintColor = tintColor;
    }
}
- (UIImage *)imageWithColor: (UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 变化方法实现
        [self gx_swizzleMethod:[self class] orgSel:@selector(layoutSubviews) swizzSel:@selector(gx_SegmentedControllayoutSubviews)];
    });
}
+ (void)gx_swizzleMethod:(Class)class orgSel:(SEL)originalSelector swizzSel:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    char *swizzledTypes = (char *)method_getTypeEncoding(swizzledMethod);
    
    IMP originalImp = method_getImplementation(originalMethod);
    char *originalTypes = (char *)method_getTypeEncoding(originalMethod);
    
    BOOL success = class_addMethod(class, originalSelector, swizzledImp, swizzledTypes);
    if (success) {
        class_replaceMethod(class, swizzledSelector, originalImp, originalTypes);
    }else {
        // 添加失败，表明已经有这个方法，直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
#pragma mark -
- (void)gx_SegmentedControllayoutSubviews
{
    // 调用本身的实现
    [self gx_SegmentedControllayoutSubviews];
    [self gx_segmentedIOS13Style];
}
@end
