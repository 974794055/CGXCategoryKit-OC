//
//  NSDictionary+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDictionary+CGXExtension.h"


@implementation NSDictionary (CGXExtension)

/**
 *  判断是否为空或为空格
 *
 *  @return YES OR NOT
 */
- (BOOL)gx_isEmpty
{
    if (self != nil && ![self isKindOfClass:[NSNull class]] && self.allKeys.count != 0){
         return NO;
     }
     return YES;
}
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)gx_JSONString{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
/**
 *  @brief  将NSDictionary转换成XML 字符串
 *
 *  @return XML 字符串
 */
- (NSString *)gx_XMLString {
    
    NSString *xmlStr = @"<xml>";
    
    for (NSString *key in self.allKeys) {
        
        NSString *value = [self objectForKey:key];
        
        xmlStr = [xmlStr stringByAppendingString:[NSString stringWithFormat:@"<%@>%@</%@>", key, value, key]];
    }
    
    xmlStr = [xmlStr stringByAppendingString:@"</xml>"];
    
    return xmlStr;
}

- (NSDictionary *)gx_removeNulls {
    
    NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary:self];
    // 遍历字典
    [replaced enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSNull class]]) {
            /**
             *  @brief  此处直接移除null，而不是替换为字符串
             *  替换成字符串可能导致程序闪退，原因：原本是要NSArray或者NSDictionary对象，我们替换成NSString对象，导致读取出错而闪退
             */
            [replaced removeObjectForKey:key];
            
        } else if ([obj isKindOfClass:[NSArray class]]) {
            
            id newObj = [obj gx_removeNulls];
            [replaced setObject:newObj forKey:key];
            
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            
            id newObj = [obj gx_removeNulls];
            [replaced setObject:newObj forKey:key];
        }
    }];
    
    return replaced;
}
#pragma mark - 网络模型属性
-(void)gx_createNetProperty{
    NSMutableString *codes=[NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString *code;
        if ([value isKindOfClass:[NSString class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) BOOL %@;",key];
        }else if ([value isKindOfClass:[NSNumber class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) NSNumber *%@;",key];
        }else if ([value isKindOfClass:[NSArray class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) NSArray *%@;",key];
        }else if ([value isKindOfClass:[NSDictionary class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) NSDictionary *%@;",key];
        }
        [codes appendFormat:@"\n%@\n",code];
    }];
    NSLog(@"%@",codes);
}


#pragma mark - 根据字典key值转模型属性
-(void)gx_createProperty{
    NSMutableString *codes=[NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString *code;
        if ([value isKindOfClass:[NSString class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code=[NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        }else if ([value isKindOfClass:[NSNumber class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        }else if ([value isKindOfClass:[NSArray class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        }else if ([value isKindOfClass:[NSDictionary class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }
        [codes appendFormat:@"\n%@\n",code];
    }];
    NSLog(@"%@",codes);
}


/**
 *  json的二进制数据NSData通过NSJSONSerialization转换为NSDictionary
 *
 *  @param jsonData json的二进制数据NSData
 *
 *  @return NSDictionary，失败时返回nil
 */
+ (NSDictionary *)gx_dictionaryWithJsonData:(NSData *)jsonData
{
    if (nil == jsonData) {
        return nil;
    }
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return result;
}

/**
 *  json的字符串数据NSString通过NSJSONSerialization转换为NSDictionary
 *
 *  @param jsonString json的字符串数据NSString
 *
 *  @return NSDictionary，失败时返回nil
 */
+ (NSDictionary *)gx_dictionaryWithJsonString:(NSString *)jsonString
{
    if (nil == jsonString || jsonString.length < 2) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [self gx_dictionaryWithJsonData:jsonData];
}

- (NSMutableDictionary *)gx_Mutable {
    NSMutableDictionary *dicResult = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.allKeys) {
        NSObject *obj = self[key];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [(NSDictionary *)obj gx_Mutable];
            [dicResult setValue:mDic forKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [self gx_MutableWith:(NSArray *)obj];
            [dicResult setValue:mArr forKey:key];
        } else {
            [dicResult setValue:obj forKey:key];
        }
        NSLog(@"-------%@",dicResult);
    }
    return dicResult;
}
#pragma mark - private
- (NSMutableArray *)gx_MutableWith:(NSArray *)array {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSObject *obj in array) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [(NSDictionary *)obj gx_Mutable];
            [tempArray addObject:mDic];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [self gx_MutableWith:(NSArray *)obj];
            [tempArray addObject:mArr];
            
        } else {
            [tempArray addObject:obj];
        }
    }
    
    return tempArray;
}

- (NSDictionary *)gx_dictionaryByReplacingNullsWithBlanks {
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        if (object == nul) [replaced setValue:blank forKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setValue:[object gx_dictionaryByReplacingNullsWithBlanks] forKey:key];
        else if ([object isKindOfClass:[NSArray class]])
            [replaced setValue:[self gx_arrayByReplacingNullsWithBlanksWith:object] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}
- (NSArray *)gx_arrayByReplacingNullsWithBlanksWith:(NSArray *)tempArr
{
    NSMutableArray *replaced = [tempArr mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object gx_dictionaryByReplacingNullsWithBlanks]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[self gx_arrayByReplacingNullsWithBlanksWith:object]];
    }
    return [replaced copy];
}
@end
