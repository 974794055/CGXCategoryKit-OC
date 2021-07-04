//
//  UITextView+CGXPlaceholder.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UITextView+CGXPlaceholder.h"
#import <objc/runtime.h>

static char *needAdjust = "needAdjust";

@implementation UITextView (CGXPlaceholder)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self.class,NSSelectorFromString(@"dealloc") ),class_getInstanceMethod(self.class, NSSelectorFromString(@"gx_textViewswizzledDealloc")));
    });
}

- (void)gx_textViewswizzledDealloc {
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UILabel *label = objc_getAssociatedObject(self, @selector(gx_placeholdLabel));
    if (label) {
        for (NSString *key in self.class.observingKeys) {
            @try {
                [self removeObserver:self forKeyPath:key];
            }
            @catch (NSException *exception) {
                // Do nothing
            }
        }
    }
    [self gx_textViewswizzledDealloc];
}
#pragma mark - `observingKeys`

+ (NSArray *)observingKeys {
    return @[@"attributedText",
             @"bounds",
             @"font",
             @"frame",
             @"text",
             @"textAlignment",
             @"textContainerInset"];
}
/***  设置placeholderLabel */
- (UILabel *)gx_placeholdLabel
{
    UILabel *label = objc_getAssociatedObject(self, @selector(gx_placeholdLabel));
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        NSAttributedString *originalText = self.attributedText;
        self.text = @" ";
        self.attributedText = originalText;

        label = [[UILabel alloc] init];
        label.textColor = [self.class gx_defaultColor];
        label.numberOfLines = 0;
        label.textColor = [self.class gx_defaultColor];
        label.font = self.gx_placeholderFont ? self.gx_placeholderFont : self.font;
        
        label.userInteractionEnabled = NO;
        objc_setAssociatedObject(self, @selector(gx_placeholdLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        self.needAdjustFont = YES;
        [self updateLabel];
        self.needAdjustFont = NO;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateLabel)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];

        for (NSString *key in self.class.observingKeys) {
            [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
        }
        
    }
    return label;
}

/***  设置默认颜色 */
+ (UIColor *)gx_defaultColor{
    
    if (@available(iOS 13, *)) {
        SEL selector = NSSelectorFromString(@"placeholderTextColor");
        if ([UIColor respondsToSelector:selector]) {
            return [UIColor performSelector:selector];
        }
    }
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @" ";
        NSDictionary *attributes = [textField.attributedPlaceholder attributesAtIndex:0 effectiveRange:nil];
        color = attributes[NSForegroundColorAttributeName];
        if (!color) {
            color = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
        }
    });
    return color;
}

#pragma mark - set get methods
- (void)setGx_placeholder:(NSString *)gx_placeholder{
    
    self.gx_placeholdLabel.text = gx_placeholder;
    [self updateLabel];
}

- (NSString *)gx_placeholder
{
    return self.gx_placeholdLabel.text;
}

- (void)setGx_placeholderColor:(UIColor *)gx_placeholderColor
{
    self.gx_placeholdLabel.textColor = gx_placeholderColor;
    [self updateLabel];
}

- (UIColor *)gx_placeholderColor
{
    return self.gx_placeholdLabel.textColor;
}

- (void)setGx_attributePlaceholder:(NSAttributedString *)gx_attributePlaceholder
{
    self.gx_placeholdLabel.attributedText = gx_attributePlaceholder;
    [self updateLabel];
}

- (NSAttributedString *)gx_attributePlaceholder
{
    return self.gx_placeholdLabel.attributedText;
}
- (void)setGx_placeholderFont:(UIFont *)gx_placeholderFont{
    
    objc_setAssociatedObject(self, &@selector(gx_placeholderFont), gx_placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.gx_placeholdLabel.backgroundColor = [UIColor clearColor];
}

- (UIFont *)gx_placeholderFont {
    
    UIFont *obj = objc_getAssociatedObject(self, &@selector(gx_placeholderFont));
    return obj;
}


//是否需要调整字体
- (BOOL)needAdjustFont{
    
    return [objc_getAssociatedObject(self, needAdjust) boolValue ];
}

- (void)setNeedAdjustFont:(BOOL)needAdjustFont{
    
    objc_setAssociatedObject(self, needAdjust, @(needAdjustFont), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - observer font KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"font"]) {
        self.needAdjustFont = (change[NSKeyValueChangeNewKey] != nil);
    }
    [self updateLabel];
    
}
/**
 *  更新label信息
 */
- (void)updateLabel{
    
    if (self.text.length) {
        [self.gx_placeholdLabel removeFromSuperview];
    }else {
        [self insertSubview:self.gx_placeholdLabel atIndex:0];
    }

    
    //是否需要更新字体（NO 采用默认字体大小）
    if (self.needAdjustFont) {
        self.gx_placeholdLabel.font = self.font;
        self.needAdjustFont = NO;
    }
    self.gx_placeholdLabel.textAlignment = self.textAlignment;
    
    // `NSTextContainer` is available since iOS 7
    CGFloat lineFragmentPadding;
    UIEdgeInsets textContainerInset;

#pragma deploymate push "ignored-api-availability"
    // iOS 7+
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        lineFragmentPadding = self.textContainer.lineFragmentPadding;
        textContainerInset = self.textContainerInset;
    }
#pragma deploymate pop

    // iOS 6
    else {
        lineFragmentPadding = 5;
        textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
    }
    CGFloat x = lineFragmentPadding + textContainerInset.left;
    CGFloat y = textContainerInset.top;
    CGFloat width = CGRectGetWidth(self.bounds) - x - lineFragmentPadding - textContainerInset.right;
    CGFloat height = [self.gx_placeholdLabel sizeThatFits:CGSizeMake(width, 0)].height;
    self.gx_placeholdLabel.frame = CGRectMake(x, y, width, height);
}

@end
