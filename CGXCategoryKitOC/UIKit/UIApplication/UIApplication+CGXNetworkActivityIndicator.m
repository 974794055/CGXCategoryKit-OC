//
//  UIApplication+CGXNetworkActivityIndicator.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIApplication+CGXNetworkActivityIndicator.h"

#import <libkern/OSAtomic.h>

@implementation UIApplication (CGXNetworkActivityIndicator)

static volatile int32_t numberOfActiveNetworkConnectionsxxx;

#pragma mark Public API

- (void)gx_beganNetworkActivity
{
	self.networkActivityIndicatorVisible = OSAtomicAdd32(1, &numberOfActiveNetworkConnectionsxxx) > 0;
}

- (void)gx_endedNetworkActivity
{
	self.networkActivityIndicatorVisible = OSAtomicAdd32(-1, &numberOfActiveNetworkConnectionsxxx) > 0;
}

@end
