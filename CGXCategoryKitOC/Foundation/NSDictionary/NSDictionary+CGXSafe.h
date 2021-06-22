//
//  NSDictionary+CGXSafe.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (CGXSafe)

/// 字典取string
/// @param key 键
- (NSString *)gx_stringForKey:(NSString *)key;

/// 字典取integer
/// @param key 键
- (NSInteger)gx_integerForKey:(NSString *)key;

/// 字典取float
/// @param key 键
- (float)gx_floatForKey:(NSString *)key;

/// 字典取bool
/// @param key 键
- (BOOL)gx_boolForKey:(NSString *)key;

/// 字典取array
/// @param key 键
- (NSMutableArray *)gx_arrayForKey:(NSString *)key;

/// 字典取dictionary
/// @param key 键
- (NSMutableDictionary *)gx_dictionaryKey:(NSString *)key;

/// 字典取long long
/// @param key 键
- (long long)gx_longLongForKey:(NSString *)key;

/// 转成可变型数据，包括里面的字典、数组
- (NSMutableDictionary *)gx_Mutable;

/// 替换字典中的NSNull为空字符串
- (NSDictionary *)gx_dictionaryByReplacingNullsWithBlanks;

/// 合并两个字典
/// @param dict 被合并的字典
- (NSDictionary *)gx_mergingWithDictionary:(NSDictionary *)dict;

/// 合并两个字典
/// @param dict 被合并的字典
/// @param ignoredKeyArr 忽略的Key
- (NSDictionary *)gx_mergingWithDictionary:(NSDictionary *)dict ignoredKeyArr:(NSArray *)ignoredKeyArr;

@end

NS_ASSUME_NONNULL_END
