//
//  NSObject+CGXModelParse.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSObject+CGXModelParse.h"

@implementation NSObject (CGXModelParse)
//防止向不存在的key赋值，导致崩溃，重写下面的方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

//防止向key中赋值nil导致崩溃
- (void)setNilValueForKey:(NSString *)key {}

//对数组进行解析，解析的操作就是把数组中的每个元素拿出来，使用特殊的类型进行解析，解析完毕后存入到可变数组种中
+ (id)parseAry:(NSArray *)ary {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (id obj in ary) {
        
        [array addObject:[self gx_objectParse:obj]];
    }
    return [array copy];
}

//对字典进行解析
+ (id)parseDic:(NSDictionary *)dic {
    
    id anyObj = [[self alloc]init];
    //[anyObj setValuesForKeysWithDictionary:dic];
    //为了匹配每个key，防止key有变动，需要更加自定义的方式
    //遍历字典
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //如果子类重写gx_replacePropertyForKey方法，则可以返回对应的key
        //即假设传入的参数key是description,子类重写以后，返回的是desc
        key = [self gx_replacePropertyForKey:key];
        //判断如果当前的value是数组类型的
        if([obj isKindOfClass:[NSArray class]]) {
            
            Class class = [self gx_objectClassInArray][key];
            if(class) {
                
                NSMutableArray *array = [[NSMutableArray alloc]init];
                for (id object in obj) {
                    [array addObject:[class gx_objectParse:object]];
                }
                obj = [array copy];
            }
        }
        [anyObj setValue:obj forKey:key];
    }];
    return anyObj;
}

//判断如果传入的是数组就用数组解析，否则就用字典字典解析
+ (id)gx_objectParse:(id)responseObj {
    
    if([responseObj isKindOfClass:[NSArray class]]) {
        
        return [self parseAry:responseObj];
    }
    if([responseObj isKindOfClass:[NSDictionary class]]) {
        
        return [self parseDic:responseObj];
    }
    return responseObj;
}
//此方法主要是为了让子类重写才能生效
+ (NSString *)gx_replacePropertyForKey:(NSString *)key {return key;}

//此方法只有子类重写才生效
+ (NSDictionary *)gx_objectClassInArray {return nil;}


+ (NSArray *)arrayWithData:(NSData *)data
{
    NSMutableArray *returnAarray  = [NSMutableArray array];
    if (data) {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *arrayaaaaa = (NSArray *)jsonObject; // 或者 NSString *string = (NSString *)jsonObject;
        returnAarray = [NSMutableArray arrayWithArray:arrayaaaaa];
    }
    return returnAarray;
}
+ (NSDictionary *)DictionaryWithData:(NSData *)data
{
    NSMutableDictionary *returnDic  = [NSMutableDictionary dictionary];
    if (data) {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *dict = (NSDictionary *)jsonObject; // 或者 NSString *string = (NSString *)jsonObject;
        returnDic = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    return returnDic;
}
+ (NSString *)stringWithData:(NSData *)data
{
    NSString *returnString  = @"";
    if (data) {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        returnString = (NSString *)jsonObject;
    }
    return returnString;
}

@end
