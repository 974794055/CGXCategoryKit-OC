//
//  NSDictionary+CGXSafe.h
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
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
/**
 替换字典中的NSNull为空字符串
 */
- (NSDictionary *)gx_dictionaryByReplacingNullsWithBlanks;

@end

NS_ASSUME_NONNULL_END
