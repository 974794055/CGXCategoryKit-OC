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
        
       SEL selectorsNSArray0[13] = {
           @selector(initWithString:),
           @selector(initWithString:attributes:),
        
           @selector(attributedSubstringFromRange:),
           @selector(attribute:atIndex:effectiveRange:),
           
           @selector(addAttribute:value:range:),
           @selector(addAttributes:range:),
           @selector(setAttributes:range:),
           @selector(removeAttribute:range:),
           @selector(deleteCharactersInRange:),
           
           @selector(replaceCharactersInRange:withString:),
           @selector(replaceCharactersInRange:withAttributedString:),
           @selector(enumerateAttribute:inRange:options:usingBlock:),
           @selector(enumerateAttributesInRange:options:usingBlock:)
       };
       for (int i = 0; i < 13;  i++) {
           SEL selector = selectorsNSArray0[i];
           NSString *newSelectorStr = [[NSString stringWithFormat:@"gx_hook_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
           [NSClassFromString(@"NSConcreteMutableAttributedString") gx_swizzleClassInstanceMethodWithOriginSel:selector swizzleSel:NSSelectorFromString(newSelectorStr)];
       }
    });
}
- (instancetype)gx_hook_initWithString:(NSString *)str {
    if (str){
        return [self gx_hook_initWithString:str];
    }
    return nil;
}
- (instancetype)gx_hook_initWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey,id> *)attrs
{
    if (str){
        return [self gx_hook_initWithString:str attributes:attrs];
    }
    return nil;
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
- (id)gx_hook_attribute:(NSAttributedStringKey)attrName atIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)range
{
    @synchronized (self) {
        if (location < self.length){
            return [self gx_hook_attribute:attrName atIndex:location effectiveRange:range];
        }else{
            return nil;
        }
    }
}
- (void)gx_hook_addAttribute:(id)name value:(id)value range:(NSRange)range {
    @synchronized (self) {
        if (!range.length) {
            [self gx_hook_addAttribute:name value:value range:range];
        }else if (value){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_addAttribute:name value:value range:range];
            }else if (range.location < self.length){
                [self gx_hook_addAttribute:name value:value range:NSMakeRange(range.location, self.length-range.location)];
            }
        }else {
            NSLog(@"gx_hook_AddAttribute:value:range: value is nil");
        }
    }
}
- (void)gx_hook_addAttributes:(NSDictionary<NSString *,id> *)attrs range:(NSRange)range {
    @synchronized (self) {
        if (!range.length) {
            [self gx_hook_addAttributes:attrs range:range];
        }else if (attrs){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_addAttributes:attrs range:range];
            }else if (range.location < self.length){
                [self gx_hook_addAttributes:attrs range:NSMakeRange(range.location, self.length-range.location)];
            }
        }else{
            NSLog(@"gx_hook_AddAttributes:range: attrs is nil");
        }
    }
}
- (void)gx_hook_setAttributes:(NSDictionary<NSString *,id> *)attrs range:(NSRange)range {
    @synchronized (self) {
        if (!range.length) {
            [self gx_hook_setAttributes:attrs range:range];
        }else if (attrs){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_setAttributes:attrs range:range];
            }else if (range.location < self.length){
                [self gx_hook_setAttributes:attrs range:NSMakeRange(range.location, self.length-range.location)];
            }
        }else{
            NSLog(@"gx_hook_SetAttributes:range:  attrs is nil");
        }
    }
}
- (void)gx_hook_removeAttribute:(id)name range:(NSRange)range {
    @synchronized (self) {
        if (!range.length) {
            [self gx_hook_removeAttribute:name range:range];
        }else if (name){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_removeAttribute:name range:range];
            }else if (range.location < self.length) {
                [self gx_hook_removeAttribute:name range:NSMakeRange(range.location, self.length-range.location)];
            }
        }else{
            NSLog(@"gx_hook_RemoveAttribute:range:  name is nil");
        }
    }
}
- (void)gx_hook_deleteCharactersInRange:(NSRange)range {
    @synchronized (self) {
        if (NSSafeMaxRange(range) <= self.length) {
            [self gx_hook_deleteCharactersInRange:range];
        }else if (range.location < self.length) {
            [self gx_hook_deleteCharactersInRange:NSMakeRange(range.location, self.length-range.location)];
        }
    }
}
- (void)gx_hook_replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    @synchronized (self) {
        if (str){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_replaceCharactersInRange:range withString:str];
            }else if (range.location < self.length) {
                [self gx_hook_replaceCharactersInRange:NSMakeRange(range.location, self.length-range.location) withString:str];
            }
        }else{
            NSLog(@"gx_hook_ReplaceCharactersInRange:withString:  str is nil");
        }
    }
}
- (void)gx_hook_replaceCharactersInRange:(NSRange)range withAttributedString:(NSString *)str {
    @synchronized (self) {
        if (str){
            if (NSSafeMaxRange(range) <= self.length) {
                [self gx_hook_replaceCharactersInRange:range withAttributedString:str];
            }else if (range.location < self.length) {
                [self gx_hook_replaceCharactersInRange:NSMakeRange(range.location, self.length-range.location) withAttributedString:str];
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
