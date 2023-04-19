//
//  NSMutableAttributedString+CGXSafe.m
//  NSObjectSafe
//
//  Created by guixin on 2023/4/9.
//  Copyright © 2023 tencent. All rights reserved.
//

#import "NSMutableAttributedString+CGXSafe.h"
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

@implementation NSMutableAttributedString (CGXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        /* init方法 */
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(initWithString:) swizzleSel:@selector(gx_hook_InitWithString:)];
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(initWithString:attributes:) swizzleSel:@selector(gx_hook_InitWithString:attributes:)];
        
        /* 普通方法 */
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(attributedSubstringFromRange:) swizzleSel:@selector(gx_hook_AttributedSubstringFromRange:)];
        
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(attribute:atIndex:effectiveRange:) swizzleSel:@selector(gx_hook_Attribute:atIndex:effectiveRange:)];
        
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(addAttribute:value:range:) swizzleSel:@selector(gx_hook_AddAttribute:value:range:)];
        
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(addAttributes:range:) swizzleSel:@selector(gx_hook_AddAttributes:range:)];
        
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(setAttributes:range:) swizzleSel:@selector(gx_hook_SetAttributes:range:)];
        
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(removeAttribute:range:) swizzleSel:@selector(gx_hook_RemoveAttribute:range:)];

        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(deleteCharactersInRange:) swizzleSel:@selector(gx_hook_DeleteCharactersInRange:)];
        
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceCharactersInRange:withString:) swizzleSel:@selector(gx_hook_ReplaceCharactersInRange:withString:)];
        
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceCharactersInRange:withAttributedString:) swizzleSel:@selector(gx_hook_ReplaceCharactersInRange:withAttributedString:)];
        
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateAttribute:inRange:options:usingBlock:) swizzleSel:@selector(gx_hook_enumerateAttribute:inRange:options:usingBlock:)];
        
        [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateAttributesInRange:options:usingBlock:) swizzleSel:@selector(gx_hook_enumerateAttributesInRange:options:usingBlock:)];
        
        
    });
}
- (instancetype)gx_hook_InitWithString:(NSString *)str {
    if (str){
        return [self gx_hook_InitWithString:str];
    }
    return nil;
}
- (instancetype)gx_hook_InitWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey,id> *)attrs
{
    if (str){
        return [self gx_hook_InitWithString:str attributes:attrs];
    }
    return nil;
}
- (NSAttributedString *)gx_hook_AttributedSubstringFromRange:(NSRange)range {
    @synchronized (self) {
        if (NSSafeMaxRange(range) <= self.length) {
            return [self gx_hook_AttributedSubstringFromRange:range];
        }else if (range.location < self.length){
            return [self gx_hook_AttributedSubstringFromRange:NSMakeRange(range.location, self.length-range.location)];
        }
        return nil;
    }
}
- (id)gx_hook_Attribute:(NSAttributedStringKey)attrName atIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)range
{
    @synchronized (self) {
        if (location < self.length){
            return [self gx_hook_Attribute:attrName atIndex:location effectiveRange:range];
        }else{
            return nil;
        }
    }
}
- (void)gx_hook_AddAttribute:(id)name value:(id)value range:(NSRange)range {
    @synchronized (self) {
        if (!range.length) {
            [self gx_hook_AddAttribute:name value:value range:range];
        }else if (value){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_AddAttribute:name value:value range:range];
            }else if (range.location < self.length){
                [self gx_hook_AddAttribute:name value:value range:NSMakeRange(range.location, self.length-range.location)];
            }
        }else {
            NSLog(@"gx_hook_AddAttribute:value:range: value is nil");
        }
    }
}
- (void)gx_hook_AddAttributes:(NSDictionary<NSString *,id> *)attrs range:(NSRange)range {
    @synchronized (self) {
        if (!range.length) {
            [self gx_hook_AddAttributes:attrs range:range];
        }else if (attrs){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_AddAttributes:attrs range:range];
            }else if (range.location < self.length){
                [self gx_hook_AddAttributes:attrs range:NSMakeRange(range.location, self.length-range.location)];
            }
        }else{
            NSLog(@"gx_hook_AddAttributes:range: attrs is nil");
        }
    }
}
- (void)gx_hook_SetAttributes:(NSDictionary<NSString *,id> *)attrs range:(NSRange)range {
    @synchronized (self) {
        if (!range.length) {
            [self gx_hook_SetAttributes:attrs range:range];
        }else if (attrs){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_SetAttributes:attrs range:range];
            }else if (range.location < self.length){
                [self gx_hook_SetAttributes:attrs range:NSMakeRange(range.location, self.length-range.location)];
            }
        }else{
            NSLog(@"gx_hook_SetAttributes:range:  attrs is nil");
        }
    }
}
- (void)gx_hook_RemoveAttribute:(id)name range:(NSRange)range {
    @synchronized (self) {
        if (!range.length) {
            [self gx_hook_RemoveAttribute:name range:range];
        }else if (name){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_RemoveAttribute:name range:range];
            }else if (range.location < self.length) {
                [self gx_hook_RemoveAttribute:name range:NSMakeRange(range.location, self.length-range.location)];
            }
        }else{
            NSLog(@"gx_hook_RemoveAttribute:range:  name is nil");
        }
    }
}
- (void)gx_hook_DeleteCharactersInRange:(NSRange)range {
    @synchronized (self) {
        if (NSSafeMaxRange(range) <= self.length) {
            [self gx_hook_DeleteCharactersInRange:range];
        }else if (range.location < self.length) {
            [self gx_hook_DeleteCharactersInRange:NSMakeRange(range.location, self.length-range.location)];
        }
    }
}
- (void)gx_hook_ReplaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    @synchronized (self) {
        if (str){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_ReplaceCharactersInRange:range withString:str];
            }else if (range.location < self.length) {
                [self gx_hook_ReplaceCharactersInRange:NSMakeRange(range.location, self.length-range.location) withString:str];
            }
        }else{
            NSLog(@"gx_hook_ReplaceCharactersInRange:withString:  str is nil");
        }
    }
}
- (void)gx_hook_ReplaceCharactersInRange:(NSRange)range withAttributedString:(NSString *)str {
    @synchronized (self) {
        if (str){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_ReplaceCharactersInRange:range withAttributedString:str];
            }else if (range.location < self.length) {
                [self gx_hook_ReplaceCharactersInRange:NSMakeRange(range.location, self.length-range.location) withAttributedString:str];
            }
        }else{
            NSLog(@"gx_hook_ReplaceCharactersInRange:withString:  str is nil");
        }
    }
}
- (void)gx_hook_enumerateAttribute:(NSString*)attrName inRange:(NSRange)range options:(NSAttributedStringEnumerationOptions)opts usingBlock:(void (^)(id _Nullable, NSRange, BOOL * _Nonnull))block
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
