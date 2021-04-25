//
//  NSArray+CGXSafe.h
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (CGXSafe)

/// 去除重复元素
- (NSArray *)gx_removeTheSameElement;

/// 主键去重复，如果元素是字符串key可不传；如果元素是字典，则传主键
/// @param key 键值
- (NSMutableArray *)gx_removeDuplicatesWithKey:(NSString *)key;

/// 替换数组中的NSNull为空字符串
- (NSArray *)gx_arrayByReplacingNullsWithBlanks;

/// 转成可变型数据，包括里面的字典、数组
- (NSMutableArray *)gx_Mutable;

@end

NS_ASSUME_NONNULL_END
