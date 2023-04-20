//
//  NSData+CGXSafe.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSData+CGXSafe.h"
#import "NSObject+CGXRuntime.h"
#import <objc/runtime.h>
/**
 * 1: negative value
 *  - NSUInteger  > NSIntegerMax
 * 2: overflow
 *  - (a+ b) > a
 */
NS_INLINE NSUInteger NSSafeMaxRange(NSRange range) {
    // negative or reach limit
    if (range.location >= NSNotFound
        || range.length >= NSNotFound){
        return NSNotFound;
    }
    // overflow
    if ((range.location + range.length) < range.location){
        return NSNotFound;
    }
    return (range.location + range.length);
}
static const char *NSZeroData = "_NSZeroData";
static const char *NSInlineData = "_NSInlineData";
static const char *NSCFData = "__NSCFData";

@implementation NSData (CGXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSClassFromString(@"NSConcreteData") gx_swizzleClassInstanceMethodWithOriginSel:@selector(subdataWithRange:) swizzleSel:@selector(gx_hook_subdataWithRange:)];
        [NSClassFromString(@"NSConcreteData") gx_swizzleClassInstanceMethodWithOriginSel:@selector(rangeOfData:options:range:) swizzleSel:@selector(gx_hook_hookRangeOfData:options:range:)];
        
        [NSClassFromString(@"NSConcreteMutableData") gx_swizzleClassInstanceMethodWithOriginSel:@selector(subdataWithRange:) swizzleSel:@selector(gx_hook_subdataWithRange:)];
        [NSClassFromString(@"NSConcreteMutableData") gx_swizzleClassInstanceMethodWithOriginSel:@selector(rangeOfData:options:range:) swizzleSel:@selector(gx_hook_hookRangeOfData:options:range:)];

        
        [objc_getClass(NSZeroData) gx_swizzleClassInstanceMethodWithOriginSel:@selector(subdataWithRange:) swizzleSel:@selector(gx_hook_subdataWithRange:)];
        [objc_getClass(NSZeroData) gx_swizzleClassInstanceMethodWithOriginSel:@selector(rangeOfData:options:range:) swizzleSel:@selector(gx_hook_hookRangeOfData:options:range:)];
        
        [objc_getClass(NSInlineData) gx_swizzleClassInstanceMethodWithOriginSel:@selector(subdataWithRange:) swizzleSel:@selector(gx_hook_subdataWithRange:)];
        [objc_getClass(NSInlineData) gx_swizzleClassInstanceMethodWithOriginSel:@selector(rangeOfData:options:range:) swizzleSel:@selector(gx_hook_hookRangeOfData:options:range:)];
        
        
        [objc_getClass(NSCFData) gx_swizzleClassInstanceMethodWithOriginSel:@selector(subdataWithRange:) swizzleSel:@selector(gx_hook_subdataWithRange:)];
        [objc_getClass(NSCFData) gx_swizzleClassInstanceMethodWithOriginSel:@selector(rangeOfData:options:range:) swizzleSel:@selector(gx_hook_hookRangeOfData:options:range:)];
        
    });
}
- (NSData*)gx_hook_subdataWithRange:(NSRange)range
{
    @synchronized (self) {
        if (NSSafeMaxRange(range) <= self.length){
            return [self gx_hook_subdataWithRange:range];
        }else if (range.location < self.length){
            return [self gx_hook_subdataWithRange:NSMakeRange(range.location, self.length-range.location)];
        }
        return nil;
    }
}

- (NSRange)gx_hook_hookRangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)range
{
    @synchronized (self) {
        if (dataToFind){
            if (NSSafeMaxRange(range) <= self.length) {
                return [self gx_hook_hookRangeOfData:dataToFind options:mask range:range];
            }else if (range.location < self.length){
                return [self gx_hook_hookRangeOfData:dataToFind options:mask range:NSMakeRange(range.location, self.length - range.location) ];
            }
            return NSMakeRange(NSNotFound, 0);
        }else{
            NSLog(@"gx_hook_hookRangeOfData:options:range: dataToFind is nil");
            return NSMakeRange(NSNotFound, 0);
        }
    }
}
@end
