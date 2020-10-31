//
//  NSDictionary+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSDictionary+CGXExtension.h"


@implementation NSDictionary (CGXExtension)

#if DEBUG
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [tabString appendString:@"\t"];
    }
    
    NSString *tab = @"";
    if (level > 0) {
        tab = tabString;
    }
    
    [desc appendString:@"\t{\n"];
    
    // 遍历数组,self就是当前的数组
    for (id key in self.allKeys) {
        id obj = [self objectForKey:key];
        
        if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"%@\t%@ = \"%@\",\n", tab, key, obj];
        } else if ([obj isKindOfClass:[NSArray class]]
                   || [obj isKindOfClass:[NSDictionary class]]
                   || [obj isKindOfClass:[NSSet class]]) {
            [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, [obj descriptionWithLocale:locale indent:level + 1]];
        } else if ([obj isKindOfClass:[NSData class]]) {
            // 如果是NSData类型，尝试去解析结果，以打印出可阅读的数据
            NSError *error = nil;
            NSObject *result =  [NSJSONSerialization JSONObjectWithData:obj
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&error];
            // 解析成功
            if (error == nil && result != nil) {
                if ([result isKindOfClass:[NSDictionary class]]
                    || [result isKindOfClass:[NSArray class]]
                    || [result isKindOfClass:[NSSet class]]) {
                    NSString *str = [((NSDictionary *)result) descriptionWithLocale:locale indent:level + 1];
                    [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, str];
                } else if ([obj isKindOfClass:[NSString class]]) {
                    [desc appendFormat:@"%@\t%@ = \"%@\",\n", tab, key, result];
                }
            } else {
                @try {
                    NSString *str = [[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding];
                    if (str != nil) {
                        [desc appendFormat:@"%@\t%@ = \"%@\",\n", tab, key, str];
                    } else {
                        [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, obj];
                    }
                }
                @catch (NSException *exception) {
                    [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, obj];
                }
            }
        } else {
            [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, obj];
        }
    }
    
    [desc appendFormat:@"%@}", tab];
    
    return desc;
}
#endif

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [strM appendString:@"}\n"];
    return strM.copy;
}

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

@end
