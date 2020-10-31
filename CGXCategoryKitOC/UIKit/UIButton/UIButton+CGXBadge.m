//
//  UIBarButtonItem+CGXBadge.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//
#import <objc/runtime.h>
#import "UIButton+CGXBadge.h"

#import <objc/runtime.h>

static NSString *const IndicatorViewKey = @"indicatorView";
static NSString *const ButtonTextObjectKey = @"buttonTextObject";

NSString const *UIButton_badgeKey = @"UIButton_badgeKey";
NSString const *UIButton_badgeBGColorKey = @"UIButton_badgeBGColorKey";
NSString const *UIButton_badgeTextColorKey = @"UIButton_badgeTextColorKey";
NSString const *UIButton_badgeFontKey = @"UIButton_badgeFontKey";
NSString const *UIButton_badgePaddingKey = @"UIButton_badgePaddingKey";
NSString const *UIButton_badgeMinSizeKey = @"UIButton_badgeMinSizeKey";
NSString const *UIButton_badgeOriginXKey = @"UIButton_badgeOriginXKey";
NSString const *UIButton_badgeOriginYKey = @"UIButton_badgeOriginYKey";
NSString const *UIButton_shouldHideBadgeAtZeroKey = @"UIButton_shouldHideBadgeAtZeroKey";
NSString const *UIButton_shouldAnimateBadgeKey = @"UIButton_shouldAnimateBadgeKey";
NSString const *UIButton_badgeValueKey = @"UIButton_badgeValueKey";

@implementation UIButton (CGXBadge)

@dynamic gx_badgeValue, gx_badgeBGColor, gx_badgeTextColor, gx_badgeFont;
@dynamic gx_badgePadding, gx_badgeMinSize, gx_badgeOriginX, gx_badgeOriginY;
@dynamic gx_shouldHideBadgeAtZero, gx_shouldAnimateBadge;


- (void)badgeInit
{
    self.gx_badgeBGColor   = [UIColor redColor];
    self.gx_badgeTextColor = [UIColor whiteColor];
    self.gx_badgeFont      = [UIFont systemFontOfSize:9.0];
    self.gx_badgePadding   = 5;
    self.gx_badgeMinSize   = 4;
    self.gx_badgeOriginX   = self.frame.size.width - self.gx_badgeLabel.frame.size.width/2-3;
    self.gx_badgeOriginY   = -6;
    self.gx_shouldHideBadgeAtZero = YES;
    self.gx_shouldAnimateBadge = YES;
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

- (void)refreshBadge
{
    self.gx_badgeLabel.textColor        = self.gx_badgeTextColor;
    self.gx_badgeLabel.backgroundColor  = self.gx_badgeBGColor;
    self.gx_badgeLabel.font             = self.gx_badgeFont;
}

- (CGSize) badgeExpectedSize
{
    UILabel *frameLabel = [self duplicateLabel:self.gx_badgeLabel];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)updateBadgeFrame
{
    CGSize expectedLabelSize = [self badgeExpectedSize];
    
    CGFloat minHeight = expectedLabelSize.height;
    
    minHeight = (minHeight < self.gx_badgeMinSize) ? self.gx_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.gx_badgePadding;
    
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.gx_badgeLabel.frame = CGRectMake(self.gx_badgeOriginX, self.gx_badgeOriginY, minWidth + padding, minHeight + padding);
    self.gx_badgeLabel.layer.cornerRadius = (minHeight + padding) / 2;
    self.gx_badgeLabel.layer.masksToBounds = YES;
}

- (void)updateBadgeValueAnimated:(BOOL)animated
{
    if (animated && self.gx_shouldAnimateBadge && ![self.gx_badgeLabel.text isEqualToString:self.gx_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.gx_badgeLabel.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    self.gx_badgeLabel.text = self.gx_badgeValue;
    
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self updateBadgeFrame];
    }];
}

- (UILabel *)duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)removeBadge
{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.gx_badgeLabel.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.gx_badgeLabel removeFromSuperview];
        self.gx_badgeLabel = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*)gx_badgeLabel {
    return objc_getAssociatedObject(self, &UIButton_badgeKey);
}
-(void)setGx_badgeLabel:(UILabel *)gx_badgeLabel
{
    objc_setAssociatedObject(self, &UIButton_badgeKey, gx_badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSString *)gx_badgeValue {
    return objc_getAssociatedObject(self, &UIButton_badgeValueKey);
}
-(void)setGx_badgeValue:(NSString *)gx_badgeValue
{
    objc_setAssociatedObject(self, &UIButton_badgeValueKey, gx_badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!gx_badgeValue || [gx_badgeValue isEqualToString:@""] || ([gx_badgeValue isEqualToString:@"0"] && self.gx_shouldHideBadgeAtZero)) {
        [self removeBadge];
    } else if (!self.gx_badgeLabel) {
        // Create a new badge because not existing
        self.gx_badgeLabel                      = [[UILabel alloc] initWithFrame:CGRectMake(self.gx_badgeOriginX, self.gx_badgeOriginY, 20, 20)];
        self.gx_badgeLabel.textColor            = self.gx_badgeTextColor;
        self.gx_badgeLabel.backgroundColor      = self.gx_badgeBGColor;
        self.gx_badgeLabel.font                 = self.gx_badgeFont;
        self.gx_badgeLabel.textAlignment        = NSTextAlignmentCenter;
        [self badgeInit];
        [self addSubview:self.gx_badgeLabel];
        [self updateBadgeValueAnimated:NO];
    } else {
        [self updateBadgeValueAnimated:YES];
    }
}

-(UIColor *)gx_badgeBGColor {
    return objc_getAssociatedObject(self, &UIButton_badgeBGColorKey);
}
-(void)setGx_badgeBGColor:(UIColor *)gx_badgeBGColor
{
    objc_setAssociatedObject(self, &UIButton_badgeBGColorKey, gx_badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.gx_badgeLabel) {
        [self refreshBadge];
    }
}

-(UIColor *)gx_badgeTextColor {
    return objc_getAssociatedObject(self, &UIButton_badgeTextColorKey);
}
-(void)setGx_badgeTextColor:(UIColor *)gx_badgeTextColor
{
    objc_setAssociatedObject(self, &UIButton_badgeTextColorKey, gx_badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.gx_badgeLabel) {
        [self refreshBadge];
    }
}

-(UIFont *)gx_badgeFont {
    return objc_getAssociatedObject(self, &UIButton_badgeFontKey);
}
-(void)setGx_badgeFont:(UIFont *)gx_badgeFont
{
    objc_setAssociatedObject(self, &UIButton_badgeFontKey, gx_badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.gx_badgeLabel) {
        [self refreshBadge];
    }
}

-(CGFloat)gx_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgePaddingKey);
    return number.floatValue;
}
-(void)setGx_badgePadding:(CGFloat)gx_badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:gx_badgePadding];
    objc_setAssociatedObject(self, &UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.gx_badgeLabel) {
        [self updateBadgeFrame];
    }
}

-(CGFloat)gx_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgeMinSizeKey);
    return number.floatValue;
}
-(void)setGx_badgeMinSize:(CGFloat)gx_badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:gx_badgeMinSize];
    objc_setAssociatedObject(self, &UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.gx_badgeLabel) {
        [self updateBadgeFrame];
    }
}


-(CGFloat)gx_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgeOriginXKey);
    return number.floatValue;
}
-(void)setGx_badgeOriginX:(CGFloat)gx_badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:gx_badgeOriginX];
    objc_setAssociatedObject(self, &UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.gx_badgeLabel) {
        [self updateBadgeFrame];
    }
}

-(CGFloat)gx_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgeOriginYKey);
    return number.floatValue;
}
-(void)setGx_badgeOriginY:(CGFloat)gx_badgeOriginY\
{
    NSNumber *number = [NSNumber numberWithDouble:gx_badgeOriginY];
    objc_setAssociatedObject(self, &UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.gx_badgeLabel) {
        [self updateBadgeFrame];
    }
}

-(BOOL)gx_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setGx_shouldHideBadgeAtZero:(BOOL)gx_shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:gx_shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)gx_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setGx_shouldAnimateBadge:(BOOL)gx_shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:gx_shouldAnimateBadge];
    objc_setAssociatedObject(self, &UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
