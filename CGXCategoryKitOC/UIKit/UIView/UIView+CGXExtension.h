//
//  UIView+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGXExtension)

@property (nonatomic) CGPoint viewOrigin;
@property (nonatomic) CGSize  viewSize;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint middlePoint;


@property (assign,nonatomic) IBInspectable NSInteger cornerRadius;
@property (assign,nonatomic) IBInspectable NSInteger borderWidth;
@property (strong,nonatomic) IBInspectable UIColor   *borderColor;
@property (assign,nonatomic) IBInspectable BOOL masksToBounds;
@property (strong,nonatomic) IBInspectable NSString  *borderHexRGB;


@end

NS_ASSUME_NONNULL_END
