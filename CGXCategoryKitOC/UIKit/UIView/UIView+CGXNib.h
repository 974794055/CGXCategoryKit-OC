//
//  UIView+CGXNib.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (CGXNib)
+ (UINib *)gx_loadNib;
+ (UINib *)gx_loadNibNamed:(NSString*)nibName;
+ (UINib *)gx_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;

+ (instancetype)gx_loadInstanceFromNib;
+ (instancetype)gx_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)gx_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)gx_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;

@end
