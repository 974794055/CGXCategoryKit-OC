//
//  NSArray+CGXAdditional.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSArray (CGXAdditional)

/// 将多个对象合并成一个数组，如果参数类型是数组则会将数组内的元素拆解出来加到 return 内（只会拆解一层，所以多维数组不处理）
/// @param object 要合并的多个数组
+ (instancetype)gx_arrayWithObjects:(id)object, ...;
/// 将多维数组打平成一维数组再遍历所有子元素
/// @param block 遍历回调
- (void)gx_enumerateNestedArrayWithBlock:(void (^)(id obj, BOOL *stop))block;
/// 将多维数组递归转换成 mutable 多维数组
- (NSMutableArray *)gx_mutableCopyNestedArray;
/**
 Creates and returns an array from a specified property list data.
 @param plist   A property list data whose root object is an array.
 @return A new array created from the plist data, or nil if an error occurs.
 */
+ (nullable NSArray *)gx_arrayWithPlistData:(NSData *)plist;
/// 过滤数组元素，将 block 返回 YES 的 item 重新组装成一个数组返回
/// @param block 过滤回调
- (NSArray *)gx_filterWithBlock:(BOOL (^)(id))block;
/**
 Creates and returns an array from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is an array.
 @return A new array created from the plist string, or nil if an error occurs.
 */
+ (nullable NSArray *)gx_arrayWithPlistString:(NSString *)plist;
/**
 Serialize the array to a binary property list data.
 
 @return A bplist data, or nil if an error occurs.
 */
- (nullable NSData *)gx_plistData;

/**
 Serialize the array to a xml property list string.
 
 @return A plist xml string, or nil if an error occurs.
 */
- (nullable NSString *)gx_plistString;
/**
 Returns the object located at index, or return nil when out of bounds.
 It's similar to `objectAtIndex:`, but it never throw exception.
 
 @param index The object located at index.
 */
- (nullable id)gx_objectOrNilAtIndex:(NSUInteger)index;
/**
 Convert object to json string. return nil if an error occurs.
 NSString/NSNumber/NSDictionary/NSArray
 */
- (nullable NSString *)gx_jsonStringEncoded;
/**
 Convert object to json string formatted. return nil if an error occurs.
 */
- (nullable NSString *)gx_jsonPrettyStringEncoded;
/**
 通过Plist名取到Plist文件中的数组

 @param name plist文件名
 @return 数组
 */
+ (NSArray *)gx_arrayFromPlistFileName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
