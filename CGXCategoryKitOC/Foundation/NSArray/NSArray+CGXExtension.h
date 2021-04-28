//
//  NSArray+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSArray (CGXExtension)
/** 反转数组 */
- (NSArray *)gx_reverseArray;
/**
 *  判断是否为空或为空格
 *  @return YES OR NOT
 */
- (BOOL)gx_isEmpty;
/** 获取数组中的最大值 */
+ (CGFloat)gx_maxNumberFromArray:(NSArray *)array;
/** 获取数组中的最小值 */
+ (CGFloat)gx_minNumberFromArray:(NSArray *)array;
/** 获取数组的和 */
+ (CGFloat)gx_sumNumberFromArray:(NSArray *)array;
/** 获取数组平均值 */
+ (CGFloat)gx_averageNumberFromArray:(NSArray *)array;
/** 移出所有的空 */
- (NSArray *)gx_removeNulls;
/**
 去除数组相同的元素
 @return 去除后的数组
 */
- (NSArray *)gx_uniqueArray;
/** 按照字母排序 */
+ (NSArray *)gx_sortFromArray:(NSArray *)array;
/** 按照升序排序 */
+ (NSArray *)gx_sortAscendingNumFromArray:(NSArray *)array;
/** 按照降序排序 */
+ (NSArray *)gx_sortDescendingNumFromArray:(NSArray *)array;
/** 按照模型排序
 array ：模型数组 [model,model,model,model,model];
 sortKey :模型数组里面的key值
 ascending ：YES升序。NO降序
 */
+ (NSArray *)gx_sortAscendingNumFromArray:(NSArray *)array WithModelSortKey:(NSString *)sortKey Ascending:(BOOL)ascending;

// 数组排序方法（乱序）
+ (NSArray *)gx_sortOutOfOrderNumFromArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
