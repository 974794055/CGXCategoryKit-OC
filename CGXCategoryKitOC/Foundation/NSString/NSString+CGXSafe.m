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

@implementation NSString (CGXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(substringFromIndex:) swizzleSel:@selector(gx_CFConstantString_substringFromIndex:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(substringToIndex:) swizzleSel:@selector(gx_CFConstantString_substringToIndex:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(substringWithRange:) swizzleSel:@selector(gx_CFConstantString_substringWithRange:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(lineRangeForRange:) swizzleSel:@selector(gx_CFConstantString_lineRangeForRange:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateSubstringsInRange:options:usingBlock:) swizzleSel:@selector(gx_CFConstantString_enumerateSubstringsInRange:options:usingBlock:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) swizzleSel:@selector(gx_CFConstantString_stringByReplacingOccurrencesOfString:withString:options:range:)];
        [objc_getClass(NSCFConstantString) gx_swizzleClassInstanceMethodWithOriginSel:@selector(stringByReplacingCharactersInRange:withString:) swizzleSel:@selector(gx_CFConstantString_stringByReplacingCharactersInRange:withString:)];
    });
}

#pragma mark - NSCFConstantString
- (NSString *)gx_CFConstantString_substringFromIndex:(NSUInteger)from
{
    if (from >= 0 && from < self.length) {
       return [self gx_CFConstantString_substringFromIndex:from];
    }
    return @"";
}
- (NSString *)gx_CFConstantString_substringToIndex:(NSUInteger)to
{
    NSUInteger newTo = to;
    if (newTo >= 0 && newTo < self.length) {
       return [self gx_CFConstantString_substringToIndex:newTo];
    } else if (newTo >= self.length) {
        newTo = self.length;
        return [self gx_CFConstantString_substringToIndex:newTo];
    }
    return @"";
}
- (NSString *)gx_CFConstantString_substringWithRange:(NSRange)range
{
    return [self gx_CFConstantString_substringWithRange:[self gx_getNewRangeWith:range]];
}
// 返回字符串指定段的位置和长度
- (NSRange)gx_CFConstantString_lineRangeForRange:(NSRange)range
{
    return [self gx_CFConstantString_lineRangeForRange:[self gx_getNewRangeWith:range]];
}
// 指定段分段的位置和长度
- (NSRange)gx_CFConstantString_paragraphRangeForRange:(NSRange)range
{
    return [self gx_CFConstantString_paragraphRangeForRange:[self gx_getNewRangeWith:range]];
}
// 检查是否在指定范围内是否有匹配的字符串
- (void)gx_CFConstantString_enumerateSubstringsInRange:(NSRange)range options:(NSStringEnumerationOptions)opts usingBlock:(void (^)(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop))block
{
    return [self gx_CFConstantString_enumerateSubstringsInRange:[self gx_getNewRangeWith:range] options:opts usingBlock:block];
}
- (NSString *)gx_CFConstantString_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    return [self gx_CFConstantString_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:[self gx_getNewRangeWith:searchRange]];
}

/* 用指定的字符串替换范围内的字符，并返回新的字符串。*/
- (NSString *)gx_CFConstantString_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
{
    return [self gx_CFConstantString_stringByReplacingCharactersInRange:[self gx_getNewRangeWith:range] withString:replacement];
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
@end
