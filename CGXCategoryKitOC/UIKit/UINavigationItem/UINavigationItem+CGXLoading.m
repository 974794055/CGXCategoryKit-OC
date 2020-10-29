//
// UINavigationItem+CGXLoading.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UINavigationItem+CGXLoading.h"
#import <objc/runtime.h>

static void *CGXLoaderPositionAssociationKey = &CGXLoaderPositionAssociationKey;
static void *CGXSubstitutedViewAssociationKey = &CGXSubstitutedViewAssociationKey;

@implementation UINavigationItem (CGXLoading)

- (void)gx_startAnimatingAt:(CGXLoaderNavBarPosition)position {
    // stop previous if animated
    [self gx_stopAnimating];
    
    // hold reference for position to stop at the right place
    objc_setAssociatedObject(self, CGXLoaderPositionAssociationKey, @(position), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIActivityIndicatorView* loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    // substitute bar views to loader and hold reference to them for restoration
    switch (position) {
        case CGXLoaderNavBarPositionLeft:
            objc_setAssociatedObject(self, CGXSubstitutedViewAssociationKey, self.leftBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.leftBarButtonItem.customView = loader;
            break;
            
        case CGXLoaderNavBarPositionCenter:
            objc_setAssociatedObject(self, CGXSubstitutedViewAssociationKey, self.titleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.titleView = loader;
            break;
            
        case CGXLoaderNavBarPositionRight:
            objc_setAssociatedObject(self, CGXSubstitutedViewAssociationKey, self.rightBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.rightBarButtonItem.customView = loader;
            break;
    }
    
    [loader startAnimating];
}

- (void)gx_stopAnimating {
    NSNumber* positionToRestore = objc_getAssociatedObject(self, CGXLoaderPositionAssociationKey);
    id componentToRestore = objc_getAssociatedObject(self, CGXSubstitutedViewAssociationKey);
    
    // restore UI if animation was in a progress
    if (positionToRestore) {
        switch (positionToRestore.intValue) {
            case CGXLoaderNavBarPositionLeft:
                self.leftBarButtonItem.customView = componentToRestore;
                break;
                
            case CGXLoaderNavBarPositionCenter:
                self.titleView = componentToRestore;
                break;
                
            case CGXLoaderNavBarPositionRight:
                self.rightBarButtonItem.customView = componentToRestore;
                break;
        }
    }
    
    objc_setAssociatedObject(self, CGXLoaderPositionAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, CGXSubstitutedViewAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
