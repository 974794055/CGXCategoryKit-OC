//
//  NSMutableArray+CGXSort.h
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NSComparisonResult(^HDSortComparator)(id obj1, id obj2);
typedef void(^HDSortExchangeCallback)(id obj1, id obj2);
@interface NSMutableArray (CGXSort)

// 选择排序
- (void)gx_selectionSortUsingComparator:(HDSortComparator)comparator didExchange:(HDSortExchangeCallback)exchangeCallback;

// 冒泡排序
- (void)gx_bubbleSortUsingComparator:(HDSortComparator)comparator didExchange:(HDSortExchangeCallback)exchangeCallback;

// 插入排序
- (void)gx_insertionSortUsingComparator:(HDSortComparator)comparator didExchange:(HDSortExchangeCallback)exchangeCallback;

// 快速排序
- (void)gx_quickSortUsingComparator:(HDSortComparator)comparator didExchange:(HDSortExchangeCallback)exchangeCallback;

// 堆排序
- (void)gx_heapSortUsingComparator:(HDSortComparator)comparator didExchange:(HDSortExchangeCallback)exchangeCallback;

/**
 *  把联系人按首字母进行排序
 *
 *  @param array 需要排序的数组
 *
 *  @return 返回按各个字母排序好数组（数组中包含数组）
 */
+ (NSMutableArray*)gx_sortArrayByFirstLetterWithArray:(NSMutableArray*)array;


/**
 *  拖过排序好的数组获取索引
 *
 *  @param sortSecionsArray 字母排序好的数组
 *
 *  @return 索引数组
 */
+ (NSMutableArray*)gx_getSectionIndexsArrayWithSortSecionsArray:(NSMutableArray*)sortSecionsArray;

#pragma mark -- 将数组拆分成固定长度

/**
 *  将数组拆分成固定长度的子数组
 *
 *  @param array 需要拆分的数组
 *
 *  @param subSize 指定长度
 *
 */
NSArray * splitArray(NSArray *array, int subSize);

@end

NS_ASSUME_NONNULL_END
