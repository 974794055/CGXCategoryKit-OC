//
//  UITableViewCell+CGXDelaysClick.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UITableViewCell+CGXDelaysClick.h"

@implementation UITableViewCell (CGXDelaysClick)

- (UIScrollView*)gx_scrollView
{
    id sv = self.contentView.superview;
    while ( ![sv isKindOfClass: [UIScrollView class]] && sv != self )
    {
        sv = [sv superview];
    }
    
    return sv == self ? nil : sv;
}

- (void)setGx_delaysContentTouches:(BOOL)gx_delaysContentTouches
{
    [self willChangeValueForKey: @"gx_delaysContentTouches"];
    
    [[self gx_scrollView] setDelaysContentTouches: gx_delaysContentTouches];
    
    [self didChangeValueForKey: @"gx_delaysContentTouches"];
}

- (BOOL)gx_delaysContentTouches
{
    return [[self gx_scrollView] delaysContentTouches];
}



@end
