//
//  NSMutableDictionary+CGXSafe.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
//

#import "NSMutableDictionary+CGXSafe.h"
#import <objc/runtime.h>
@implementation NSMutableDictionary (CGXSafe)
+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self gx_swizzlingSysMethod:@"gx_removeObjectForKey:" sysClassString:@"NSMutableDictionary" toCustMethod:@"removeObjectForKey:" targetClassString:@"__NSDictionaryM"];
        [self gx_swizzlingSysMethod:@"gx_setObject:forKey:" sysClassString:@"NSMutableDictionary" toCustMethod:@"setObject:forKey:" targetClassString:@"__NSDictionaryM"];
    });
    
}


- (void)gx_removeObjectForKey:(id)key {
    if (!key) {
        return;
    }
    [self gx_removeObjectForKey:key];
}

- (void)gx_setObject:(id)obj forKey:(id <NSCopying>)key {
    if (!obj) {
        return;
    }
    if (!key) {
        return;
    }
    [self gx_setObject:obj forKey:key];
}


+ (void)gx_swizzlingSysMethod:(NSString *)systemMethodString sysClassString:(NSString *)systemClassString toCustMethod:(NSString *)custMethodString targetClassString:(NSString *)targetClassString{
    
    //系统方法IMP
    Method sysMethod = class_getInstanceMethod(NSClassFromString(systemClassString), NSSelectorFromString(systemMethodString));
    
    //自定义方法的IMP
    Method safeMethod = class_getInstanceMethod(NSClassFromString(targetClassString), NSSelectorFromString(custMethodString));
    
    //通过IMP相互交换，进而交换方法的实现
    method_exchangeImplementations(safeMethod,sysMethod);
}

@end
