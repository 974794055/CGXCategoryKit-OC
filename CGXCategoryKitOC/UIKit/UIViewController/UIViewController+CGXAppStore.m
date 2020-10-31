//
//  UIViewController+CGXAppStore.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UIViewController+CGXAppStore.h"

#import <StoreKit/StoreKit.h>
#import <objc/runtime.h>
////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

NSString* const gx_affiliateTokenKey = @"at";
NSString* const gx_campaignTokenKey = @"ct";
NSString* const gx_iTunesAppleString = @"itunes.apple.com";

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface UIViewController (SKStoreProductViewControllerDelegate) <SKStoreProductViewControllerDelegate>

@property NSString *gx_campaignToken;
@property (nonatomic, copy) void (^gx_loadingStoreKitItemBlock)(void);
@property (nonatomic, copy) void (^gx_loadedStoreKitItemBlock)(void);


@end
@implementation UIViewController (CGXAppStore)

- (void)gx_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier
{
    SKStoreProductViewController* storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;

    NSString* campaignToken = self.gx_campaignToken ?: @"";

    NSDictionary* parameters = @{
        SKStoreProductParameterITunesItemIdentifier : @(itemIdentifier),
        gx_affiliateTokenKey : gx_affiliateTokenKey,
        gx_campaignTokenKey : campaignToken,
    };

    if (self.gx_loadingStoreKitItemBlock) {
        self.gx_loadingStoreKitItemBlock();
    }
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError* error) {
        if (self.gx_loadedStoreKitItemBlock) {
            self.gx_loadedStoreKitItemBlock();
        }

        if (result && !error)
        {
            [self presentViewController:storeViewController animated:YES completion:nil];
        }
    }];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Delegation - SKStoreProductViewControllerDelegate

- (void)gx_productViewControllerDidFinish:(SKStoreProductViewController*)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

+ (NSURL*)gx_appURLForIdentifier:(NSInteger)identifier
{
    NSString* appURLString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%li", (long)identifier];
    return [NSURL URLWithString:appURLString];
}

+ (void)gx_openAppReviewURLForIdentifier:(NSInteger)identifier
{
    NSString* reviewURLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%li", (long)identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURLString]];
}

+ (void)gx_openAppURLForIdentifier:(NSInteger)identifier
{
    NSString* appURLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%li", (long)identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURLString]];
}

+ (BOOL)gx_containsITunesURLString:(NSString*)URLString
{
    return ([URLString rangeOfString:gx_iTunesAppleString].location != NSNotFound);
}

+ (NSInteger)gx_IDFromITunesURL:(NSString*)URLString
{
    NSError* error;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"id\\d+" options:0 error:&error];
    NSTextCheckingResult* match = [regex firstMatchInString:URLString options:0 range:NSMakeRange(0, URLString.length)];

    NSString* idString = [URLString substringWithRange:match.range];
    if (idString.length > 0) {
        idString = [idString stringByReplacingOccurrencesOfString:@"id" withString:@""];
    }

    return [idString integerValue];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Associated objects

- (void)setGx_campaignToken:(NSString *)gx_campaignToken
{
    objc_setAssociatedObject(self, @selector(setGx_campaignToken:), gx_campaignToken, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*)gx_campaignToken
{
    return objc_getAssociatedObject(self, @selector(setGx_campaignToken:));
}

- (void)setGx_loadingStoreKitItemBlock:(void (^)(void))loadingStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setGx_loadingStoreKitItemBlock:), loadingStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))gx_loadingStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setGx_loadedStoreKitItemBlock:));
}

- (void)setGx_loadedStoreKitItemBlock:(void (^)(void))loadedStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setGx_loadedStoreKitItemBlock:), loadedStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))gx_loadedStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setGx_loadedStoreKitItemBlock:));
}

@end
