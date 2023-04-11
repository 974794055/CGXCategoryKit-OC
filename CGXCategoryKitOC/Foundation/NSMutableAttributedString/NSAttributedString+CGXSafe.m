//
//  NSAttributedString+CGXSafe.m
//  NSObjectSafe
//
//  Created by guixin on 2023/4/9.
//  Copyright © 2023 tencent. All rights reserved.
//

#import "NSAttributedString+CGXSafe.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+CGXRuntime.h"

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
@implementation NSAttributedString (CGXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        /* init方法 */
        [NSClassFromString(@"NSConcreteAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(initWithString:) swizzleSel:@selector(gx_hook_initWithString:)];
        [NSClassFromString(@"NSConcreteAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(initWithString:attributes:) swizzleSel:@selector(gx_hook_initWithCString:attributes:)];
        

        /* 普通方法 */
        [NSClassFromString(@"NSConcreteAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(attributedSubstringFromRange:) swizzleSel:@selector(gx_hook_attributedSubstringFromRange:)];
        [NSClassFromString(@"NSConcreteAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(attribute:atIndex:effectiveRange:) swizzleSel:@selector(gx_hook_attribute:atIndex:effectiveRange:)];
        [NSClassFromString(@"NSConcreteAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateAttribute:inRange:options:usingBlock:) swizzleSel:@selector(gx_hook_enumerateAttribute:inRange:options:usingBlock:)];
        [NSClassFromString(@"NSConcreteAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateAttributesInRange:options:usingBlock:) swizzleSel:@selector(gx_hook_enumerateAttributesInRange:options:usingBlock:)];
        
        
    });
}
- (instancetype)gx_hook_initWithString:(NSString *)str
{
    if (str){
        return [self gx_hook_initWithString:str];
    }
    return nil;
}
- (instancetype)gx_hook_initWithCString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey,id> *)attrs
{
    if (str){
        return [self gx_hook_initWithCString:str attributes:attrs];
    }
    return nil;
}
- (id)gx_hook_attribute:(NSAttributedStringKey)attrName atIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    @synchronized (self) {
        if (location < self.length){
            return [self gx_hook_attribute:attrName atIndex:location effectiveRange:range];
        }else{
            return nil;
        }
    }
}
- (NSAttributedString *)gx_hook_attributedSubstringFromRange:(NSRange)range {
    @synchronized (self) {
        if (NSSafeMaxRange(range) <= self.length) {
            return [self gx_hook_attributedSubstringFromRange:range];
        }else if (range.location < self.length){
            return [self gx_hook_attributedSubstringFromRange:NSMakeRange(range.location, self.length-range.location)];
        }
        return nil;
    }
}
- (void)gx_hook_enumerateAttribute:(NSString *)attrName inRange:(NSRange)range options:(NSAttributedStringEnumerationOptions)opts usingBlock:(void (^)(id _Nullable, NSRange, BOOL * _Nonnull))block
{
    @synchronized (self) {
        if (NSSafeMaxRange(range) <= self.length) {
            [self gx_hook_enumerateAttribute:attrName inRange:range options:opts usingBlock:block];
        }else if (range.location < self.length){
            [self gx_hook_enumerateAttribute:attrName inRange:NSMakeRange(range.location, self.length-range.location) options:opts usingBlock:block];
        }
    }
}
- (void)gx_hook_enumerateAttributesInRange:(NSRange)range options:(NSAttributedStringEnumerationOptions)opts usingBlock:(void (^)(NSDictionary<NSString*,id> * _Nonnull, NSRange, BOOL * _Nonnull))block
{
    @synchronized (self) {
        if (NSSafeMaxRange(range) <= self.length) {
            [self gx_hook_enumerateAttributesInRange:range options:opts usingBlock:block];
        }else if (range.location < self.length){
            [self gx_hook_enumerateAttributesInRange:NSMakeRange(range.location, self.length-range.location) options:opts usingBlock:block];
        }
    }
}
@end
