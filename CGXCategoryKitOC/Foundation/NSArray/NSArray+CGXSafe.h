//
//  NSArray+CGXSafe.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (CGXSafe)


/// 主键去重复，如果元素是字符串key可不传；如果元素是字典，则传主键
/// @param key 键值
- (NSMutableArray *)gx_removeDuplicatesWithKey:(NSString *)key;

/// 转成可变型数据，包括里面的字典、数组
- (NSMutableArray *)gx_Mutable;

@end

/* hook方法如下：
 objectAtIndex:
 subarrayWithRange:
 indexOfObject:inRange:
 objectsAtIndexes:
 objectAtIndexedSubscript:
 enumerateObjectsAtIndexes:options:usingBlock:
 indexOfObjectAtIndexes:options:passingTest:
 indexesOfObjectsAtIndexes:options:passingTest:
 indexOfObject:inSortedRange:options:usingComparator:
 
 内部做了安全取值处理
*/

NS_ASSUME_NONNULL_END
