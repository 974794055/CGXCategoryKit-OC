//
//  NSDictionary+CGXMerge.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CGXMerge)
/**
 *  @brief  合并两个NSDictionary
 *
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)gx_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)gx_dictionaryByMergingWith:(NSDictionary *)dict;

/**
 合并两个字典
 
 @param dict       被合并的字典
 @param ignoredKeyArr 忽略的Key
 */
- (NSDictionary *)gx_mergingWithDictionary:(NSDictionary *)dict ignoredKeyArr:(NSArray *)ignoredKeyArr;

/**转成可变型数据，包括里面的字典、数组*/
- (NSMutableDictionary *)gx_Mutable;
@end
