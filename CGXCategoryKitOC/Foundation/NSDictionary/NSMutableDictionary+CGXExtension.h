//
//  NSDictionary+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+CGXExtension.h"
#import "NSDictionary+CGXURL.h"
#import "NSDictionary+CGXMerge.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (CGXExtension)

/**
 * 根据键获取所对应的对象
 
 @param key 键
 @return object
 */
- (id)gx_objectForKey:(id<NSCopying>)key;
/**
 * 根据键获取所对应的值 返回int类型
 
 @param key 键
 @return int
 */
- (int)gx_intForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回double类型
 
 @param key 键
 @return double
 */
- (double)gx_doubleForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回float类型
 
 @param key 键
 @return float
 */
- (float)gx_floatForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回NSInteger类型
 
 @param key 键
 @return NSInteger
 */
- (NSInteger)gx_integerForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回NSString类型
 
 @param key 键
 @return NSString
 */
- (NSString *)gx_stringForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回NSDictionary类型
 
 @param key 键
 @return NSDictionary
 */
- (NSDictionary *)gx_dictionaryForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回NSArray类型
 
 @param key 键
 @return NSArray
 */
- (NSArray *)gx_arrayForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回NSNumber类型
 
 @param key 键
 @return NSNumber
 */
- (NSNumber *)gx_numberForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回BOOL类型
 
 @param key 键
 @return BOOL
 */
- (BOOL)gx_boolForKey:(id<NSCopying>)key;

/**
 * 根据键获取所对应的值 返回unsigned long long类型
 
 @param key 键
 @return unsigned long long
 */
- (unsigned long long)gx_unsignedLongLongValue:(id<NSCopying>)key;

/**
 * 使用它来为键设置对象是安全的。
 
 @param anObject 对象
 @param aKey 键
 @return BOOL
 */
- (BOOL)gx_setObject:(id)anObject forKey:(id<NSCopying>)aKey;


/**
 * 使用它来设置键值是安全的。
 
 @param value 值
 @param key 键
 @return bool
 */
- (BOOL)gx_setValue:(id)value forKey:(NSString *)key;




@end

NS_ASSUME_NONNULL_END
