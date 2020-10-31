//
//  NSURL+CGXParam.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSURL+CGXParam.h"

@implementation NSURL (CGXParam)
/**
 *  @brief  url参数转字典
 *
 *  @return 参数转字典结果
 */
- (NSDictionary *)gx_parameters
{
    NSMutableDictionary * parametersDictionary = [NSMutableDictionary dictionary];
    NSArray * queryComponents = [self.query componentsSeparatedByString:@"&"];
    for (NSString * queryComponent in queryComponents) {
        NSString * key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        if (queryComponent.hash == key.hash) {
            continue;
        }
        NSString * value = [queryComponent substringFromIndex:(key.length + 1)];
        [parametersDictionary setObject:value forKey:key];
    }
    return parametersDictionary;
}
/**
 *  @brief  根据参数名 取参数值
 *
 *  @param parameterKey 参数名的key
 *
 *  @return 参数值
 */
- (NSString *)gx_valueForParameter:(NSString *)parameterKey
{
    return [[self gx_parameters] objectForKey:parameterKey];
}
@end
