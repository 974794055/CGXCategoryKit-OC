//
//  NSUserDefaults+CGXSafeAccess.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (CGXSafeAccess)
+ (NSString *)gx_stringForKey:(NSString *)defaultName;

+ (NSArray *)gx_arrayForKey:(NSString *)defaultName;

+ (NSDictionary *)gx_dictionaryForKey:(NSString *)defaultName;

+ (NSData *)gx_dataForKey:(NSString *)defaultName;

+ (NSArray *)gx_stringArrayForKey:(NSString *)defaultName;

+ (NSInteger)gx_integerForKey:(NSString *)defaultName;

+ (float)gx_floatForKey:(NSString *)defaultName;

+ (double)gx_doubleForKey:(NSString *)defaultName;

+ (BOOL)gx_boolForKey:(NSString *)defaultName;

+ (NSURL *)gx_URLForKey:(NSString *)defaultName;

+ (void)gx_setObject:(id)value forKey:(NSString *)defaultName;

+ (id)gx_arcObjectForKey:(NSString *)defaultName;

+ (void)gx_setArcObject:(id)value forKey:(NSString *)defaultName;

@end

NS_ASSUME_NONNULL_END
