//
//  NSURL+CGXParam.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (CGXParam)
/**
 *  @brief  url参数转字典
 *
 *  @return 参数转字典结果
 */
- (NSDictionary *)gx_parameters;
/**
 *  @brief  根据参数名 取参数值
 *
 *  @param parameterKey 参数名的key
 *
 *  @return 参数值
 */
- (NSString *)gx_valueForParameter:(NSString *)parameterKey;

@end
