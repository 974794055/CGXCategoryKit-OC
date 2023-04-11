//
//  NSString+CGXSafe.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSString+CGXSafe.h"
#import "NSObject+CGXRuntime.h"
#import <objc/runtime.h>

static const char *NSCFConstantString = "__NSCFConstantString";
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
@implementation NSString (CGXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        /* init方法 */
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(initWithString:) swizzleSel:@selector(gx_hook_initWithString:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(initWithUTF8String:) swizzleSel:@selector(gx_hook_initWithUTF8String:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(initWithCString:encoding:) swizzleSel:@selector(gx_hook_initWithCString:encoding:)];
        
        /* _NSCFConstantString */
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(substringFromIndex:) swizzleSel:@selector(gx_hook_substringFromIndex:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(substringToIndex:) swizzleSel:@selector(gx_hook_substringToIndex:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(substringWithRange:) swizzleSel:@selector(gx_hook_substringWithRange:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(rangeOfString:options:range:locale:) swizzleSel:@selector(gx_hook_rangeOfString:options:range:locale:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(stringByAppendingString:) swizzleSel:@selector(gx_hook_stringByAppendingString:)];
        

        /* _NSCFConstantString */
        [NSClassFromString(@"NSCFConstantString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(substringFromIndex:) swizzleSel:@selector(gx_hook_substringFromIndex:)];
        [NSClassFromString(@"NSCFConstantString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(substringToIndex:) swizzleSel:@selector(gx_hook_substringToIndex:)];
        [NSClassFromString(@"NSCFConstantString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(substringWithRange:) swizzleSel:@selector(gx_hook_substringWithRange:)];
        [NSClassFromString(@"NSCFConstantString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(rangeOfString:options:range:locale:) swizzleSel:@selector(gx_hook_rangeOfString:options:range:locale:)];
        [NSClassFromString(@"NSCFConstantString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(stringByAppendingString:) swizzleSel:@selector(gx_hook_stringByAppendingString:)];
        
        
        
        
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(lineRangeForRange:) swizzleSel:@selector(gx_hook_lineRangeForRange:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateSubstringsInRange:options:usingBlock:) swizzleSel:@selector(gx_hook_enumerateSubstringsInRange:options:usingBlock:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) swizzleSel:@selector(gx_hook_stringByReplacingOccurrencesOfString:withString:options:range:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(stringByReplacingCharactersInRange:withString:) swizzleSel:@selector(gx_hook_stringByReplacingCharactersInRange:withString:)];
        
     
    });
}

#pragma mark - NSCFConstantString
- (NSString *)gx_hook_substringFromIndex:(NSUInteger)from
{
    if (from >= 0 && from < self.length) {
       return [self gx_hook_substringFromIndex:from];
    }
    return @"";
}
- (NSString *)gx_hook_substringToIndex:(NSUInteger)to
{
    @synchronized (self) {
        if (to <= self.length) {
            return [self gx_hook_substringToIndex:to];
        }
        return nil;
    }
    return @"";
}

- (NSString *)gx_hook_substringWithRange:(NSRange)range
{
    return [self gx_hook_substringWithRange:[self gx_getNewRangeWith:range]];
}
// 返回字符串指定段的位置和长度
- (NSRange)gx_hook_lineRangeForRange:(NSRange)range
{
    return [self gx_hook_lineRangeForRange:[self gx_getNewRangeWith:range]];
}
// 指定段分段的位置和长度
- (NSRange)gx_hook_paragraphRangeForRange:(NSRange)range
{
    return [self gx_hook_paragraphRangeForRange:[self gx_getNewRangeWith:range]];
}
// 检查是否在指定范围内是否有匹配的字符串
- (void)gx_hook_enumerateSubstringsInRange:(NSRange)range options:(NSStringEnumerationOptions)opts usingBlock:(void (^)(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop))block
{
    return [self gx_hook_enumerateSubstringsInRange:[self gx_getNewRangeWith:range] options:opts usingBlock:block];
}
- (NSString *)gx_hook_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    return [self gx_hook_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:[self gx_getNewRangeWith:searchRange]];
}

/* 用指定的字符串替换范围内的字符，并返回新的字符串。*/
- (NSString *)gx_hook_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
{
    return [self gx_hook_stringByReplacingCharactersInRange:[self gx_getNewRangeWith:range] withString:replacement];
}
#pragma mark - private
- (NSRange)gx_getNewRangeWith:(NSRange)range
{
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    
    if (location > self.length) {
        return NSMakeRange(self.length, 0);
    } else {
        if (length + location > self.length) {
            length = self.length - location;
        }
        return NSMakeRange(location, length);
    }
}
- (nullable instancetype)gx_hook_initWithString:(NSString *)aString
{
    if (aString){
        return [self gx_hook_initWithString:aString];
    }
    NSLog(@"NSString invalid args hookInitWithString nil aString");
    return nil;
}
- (nullable instancetype)gx_hook_initWithUTF8String:(const char *)nullTerminatedCString
{
    if (NULL != nullTerminatedCString) {
        return [self gx_hook_initWithUTF8String:nullTerminatedCString];
    }
    NSLog(@"NSString invalid args hookInitWithUTF8String nil aString");
    return nil;
}
- (nullable instancetype)gx_hook_initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding
{
    if (NULL != nullTerminatedCString){
        return [self gx_hook_initWithCString:nullTerminatedCString encoding:encoding];
    }
    NSLog(@"NSString invalid args hookInitWithCString nil cstring");
    return nil;
}
- (NSString *)gx_hook_stringByAppendingString:(NSString *)aString
{
    @synchronized (self) {
        if (aString){
            return [self gx_hook_stringByAppendingString:aString];
        }
        return self;
    }
}
- (NSRange)gx_hook_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)range locale:(nullable NSLocale *)locale
{
    @synchronized (self) {
        if (searchString){
            if (NSSafeMaxRange(range) <= self.length) {
                return [self gx_hook_rangeOfString:searchString options:mask range:range locale:locale];
            }else if (range.location < self.length){
                return [self gx_hook_rangeOfString:searchString options:mask range:NSMakeRange(range.location, self.length-range.location) locale:locale];
            }
            return NSMakeRange(NSNotFound, 0);
        }else{
            NSLog(@"hookRangeOfString:options:range:locale: searchString is nil");
            return NSMakeRange(NSNotFound, 0);
        }
    }
}
@end
