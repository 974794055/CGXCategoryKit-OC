//
//  NSMutableData+CGXSafe.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSMutableData+CGXSafe.h"
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

@implementation NSMutableData (CGXSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"NSConcreteMutableData") gx_swizzleClassInstanceMethodWithOriginSel:@selector(resetBytesInRange:) swizzleSel:@selector(gx_hook_resetBytesInRange:)];
        [NSClassFromString(@"NSConcreteMutableData") gx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceBytesInRange:withBytes:) swizzleSel:@selector(gx_hook_replaceBytesInRange:withBytes:)];
        [NSClassFromString(@"NSConcreteMutableData") gx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceBytesInRange:withBytes:length:) swizzleSel:@selector(gx_hook_replaceBytesInRange:withBytes:length:)];
        
        [NSClassFromString(@"__NSCFData") gx_swizzleClassInstanceMethodWithOriginSel:@selector(resetBytesInRange:) swizzleSel:@selector(gx_hook_resetBytesInRange:)];
        [NSClassFromString(@"__NSCFData") gx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceBytesInRange:withBytes:) swizzleSel:@selector(gx_hook_replaceBytesInRange:withBytes:)];
        [NSClassFromString(@"__NSCFData") gx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceBytesInRange:withBytes:length:) swizzleSel:@selector(gx_hook_replaceBytesInRange:withBytes:length:)];
    });
}

- (void)gx_hook_resetBytesInRange:(NSRange)range
{
    @synchronized (self) {
        if (NSSafeMaxRange(range) <= self.length){
            [self gx_hook_resetBytesInRange:range];
        }else if (range.location < self.length){
            [self gx_hook_resetBytesInRange:NSMakeRange(range.location, self.length-range.location)];
        }
    }
}
- (void)gx_hook_replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes
{
    @synchronized (self) {
        if (bytes){
            if (range.location <= self.length) {
                [self gx_hook_replaceBytesInRange:range withBytes:bytes];
            }else {
                NSLog(@"gx_hook_replaceBytesInRange:withBytes: range.location error");
            }
        }else if (!NSEqualRanges(range, NSMakeRange(0, 0))){
            NSLog(@"gx_hook_replaceBytesInRange:withBytes: bytes is nil");
        }
    }
}
- (void)gx_hook_replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes length:(NSUInteger)replacementLength
{
    @synchronized (self) {
        if (NSSafeMaxRange(range) <= self.length) {
            [self gx_hook_replaceBytesInRange:range withBytes:bytes length:replacementLength];
        }else if (range.location < self.length){
            [self gx_hook_replaceBytesInRange:NSMakeRange(range.location, self.length - range.location) withBytes:bytes length:replacementLength];
        }
    }
}

@end
