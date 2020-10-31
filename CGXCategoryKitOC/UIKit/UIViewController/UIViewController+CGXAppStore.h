//
//  UIViewController+CGXAppStore.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CGXAppStore)

- (void)gx_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier;

+ (NSURL*)gx_appURLForIdentifier:(NSInteger)identifier;

+ (void)gx_openAppURLForIdentifier:(NSInteger)identifier;
+ (void)gx_openAppReviewURLForIdentifier:(NSInteger)identifier;

+ (BOOL)gx_containsITunesURLString:(NSString*)URLString;

+ (NSInteger)gx_IDFromITunesURL:(NSString*)URLString;

@end

NS_ASSUME_NONNULL_END
