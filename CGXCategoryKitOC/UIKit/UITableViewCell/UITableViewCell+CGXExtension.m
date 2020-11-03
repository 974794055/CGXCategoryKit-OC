//
//  UITableViewCell+CGXExtension.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/11/3.
//

#import "UITableViewCell+CGXExtension.h"

@implementation UITableViewCell (CGXExtension)

- (void)gx_showScaleAnimation
{
    CATransform3D transform = CATransform3DMakeScale(0.68, 0.68, 1.0);
    self.layer.transform = transform;
    // 不透明度
    self.layer.opacity = 0;
    [UIView beginAnimations:@"s" context:nil];
    [UIView setAnimationDuration:0.5];
    self.layer.transform = CATransform3DIdentity;
    self.layer.opacity = 1;
    [UIView commitAnimations];
    
}

- (void)gx_showIndentAnimationWithCell
{
    CGRect originalRect = self.frame;
    CGRect newRect = self.frame;
    newRect.origin.x = CGRectGetWidth([UIScreen mainScreen].bounds);
    self.frame = newRect;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = originalRect;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)gx_showRoatationAnimation
{
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( M_PI/6, 0.0, 0.5, 0.4);
    rotation.m34 = 1.0/ -600;
    
    self.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.alpha = 0;
    self.layer.transform = rotation;
    
    [UIView beginAnimations:@"rotation" context:nil];
    [UIView setAnimationDuration:0.5];
    self.layer.transform = CATransform3DIdentity;
    self.alpha = 1;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

/**
 分割线左边距,右边距
 */
- (void)gx_setCellBottomLineLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace
{
    self.layoutMargins = UIEdgeInsetsMake(0, leftSpace, 0, rightSpace);
    self.separatorInset = UIEdgeInsetsMake(0, leftSpace, 0, rightSpace);
}

- (void)gx_setCellBottomLineLeftSpace:(CGFloat)leftSpace
{
    [self gx_setCellBottomLineLeftSpace:leftSpace rightSpace:0];
}

- (void)gx_setCellBottomLineZeroSpace
{
    [self gx_setCellBottomLineLeftSpace:0 rightSpace:0];
}

/// 隐藏分割线
- (void)gx_hiddenCellBottomLine
{
    self.layoutMargins = UIEdgeInsetsMake(0, CGRectGetWidth([UIScreen mainScreen].bounds), 0, 0);
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth([UIScreen mainScreen].bounds), 0, 0);
}


@end
