//
//  NSObject+CGXObject.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NSObject (CGXObject)

/** 版本号 */
+ (NSString *)gx_version;

/** build号 */
+ (NSInteger)gx_build;

/** Bundle id */
+ (NSString *)gx_identifier;

/** 语言 */
+ (NSString *)gx_currentAppLanguage;

/** 架构 */
+ (NSString *)gx_deviceModel;

/** 类名 */
- (NSString *)gx_className;

/** 类名 */
+ (NSString *)gx_className;

/** 父类名 */
- (NSString *)gx_superClassName;

/** 父类名 */
+ (NSString *)gx_superClassName;

/** 实例属性字典 */
- (NSDictionary *)gx_propertyDictionary;

/** 属性名称列表 */
- (NSArray *)gx_propertyKeys;

/** 属性名称列表 */
+ (NSArray *)gx_propertyKeys;

/** 方法列表 */
- (NSArray *)gx_methodList;

/** 方法列表 */
+ (NSArray *)gx_methodList;

/** 格式化方法列表 */
- (NSArray *)gx_methodListInfo;

/** 创建并返回一个指向所有已注册类的指针列表 */
+ (NSArray *)gx_registedClassList;

/** 实例变量 */
+ (NSArray *)gx_instanceVariable;

//协议列表
-(NSDictionary *)gx_protocolList;
+ (NSDictionary *)gx_protocolList;

//属性详细信息列表
- (NSArray *)gx_propertiesInfo;
+ (NSArray *)gx_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)gx_propertiesWithCodeFormat;

/** 是否包含某个属性 */
- (BOOL)gx_hasPropertyForKey:(NSString*)key;

/** 是否包含某个实例变量 */
- (BOOL)gx_hasIvarForKey:(NSString*)key;

- (void)gx_modelWithDictionary:(NSDictionary *)dict __attribute__((deprecated(" ")));

@end
