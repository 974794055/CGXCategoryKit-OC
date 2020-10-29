//
//  UIView+CGXNib.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXNib.h"

@implementation UIView (CGXNib)
#pragma mark - Nibs
+ (UINib *)gx_loadNib
{
    return [self gx_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)gx_loadNibNamed:(NSString*)nibName
{
    return [self gx_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)gx_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)gx_loadInstanceFromNib
{
    return [self gx_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)gx_loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self gx_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)gx_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self gx_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)gx_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}

@end
