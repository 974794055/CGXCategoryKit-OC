//
//  NSMutableArray+CGXSafe.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (CGXSafe)

/// 加一个主键不重复的元素，如果元素是字符串key可以不用传；如果元素是字典，则传主键
/// @param anObject 参数
/// @param key 主键
- (void)gx_addObject:(id)anObject withKey:(NSString *)key;

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
 
 insertObject:atIndex:
 removeObjectAtIndex:
 replaceObjectAtIndex:withObject:
 exchangeObjectAtIndex:withObjectAtIndex:
 removeObject:inRange:
 removeObjectIdenticalTo:inRange:
 removeObjectsInRange:
 replaceObjectsInRange:withObjectsFromArray:range:
 replaceObjectsInRange:withObjectsFromArray:
 insertObjects:atIndexes:
 removeObjectsAtIndexes:
 replaceObjectsAtIndexes:withObjects:
 setObject:atIndexedSubscript:
 
 内部做了安全取值处理
*/


NS_ASSUME_NONNULL_END
