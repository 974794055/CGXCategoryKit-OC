//
//  NSDictionary+CGXURL.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CGXURL)
/**
 *  @brief  将url参数转换成NSDictionary
 *
 *  @param query url参数
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)gx_dictionaryWithURLQuery:(NSString *)query;
/**
 *  @brief  将NSDictionary转换成url 参数字符串   例如：&key=vlaue
 *
 *  @return url 参数字符串
 */
- (NSString *)gx_URLQueryString;

- (NSString*)gx_URLQueryStringWithSortedKeys:(BOOL)sortedKeys;
@end
