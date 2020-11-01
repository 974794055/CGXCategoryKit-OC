//
//  NSObject+CGXAddProperty.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

//objc_getAssociatedObject和objc_setAssociatedObject都需要指定一个固定的地址，这个固定的地址值用来表示属性的key，起到一个常量的作用。
//static const void *CGXStringProperty = &CGXStringProperty;
//static char IntegerProperty;
//@selector(methodName:)

@interface NSObject (CGXAddProperty)
/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
@property (nonatomic,strong) NSString *gx_stringProperty;
/**
 *  @brief  catgory runtime实现get set方法增加一个NSInteger属性
 */
@property (nonatomic,assign) NSInteger gx_integerProperty;
/**
 *  自动生成属性列表
 *  @param dict JSON字典/模型字典
 */
+ (void)gx_printPropertyWithDict:(NSDictionary *)dict;

/**
 *  自动给属性赋值
 *  @param dict JSON字典/模型字典
 */
+ (instancetype)gx_setPropertyValuesWithDict:(NSDictionary *)dict;
/**
 *  为类添加id类型的属性，objc_AssociationPolicy类型为OBJC_ASSOCIATION_RETAIN_NONATOMIC
 *  @param name 属性的name
 */
+ (void)gx_addObjectProperty:(NSString *)name;
/**
 *  为类添加id类型的属性
 *  @param name   属性的name
 *  @param policy 属性的policy
 */
+ (void)gx_addObjectProperty:(NSString *)name associationPolicy:(objc_AssociationPolicy)policy;

/**
 *  为类添加基础类型的属性，如：int,float,CGPoint,CGRect等
 *  @param name 属性的name
 *  @param type 属性的encodingType，如int类型的属性，type为@encode(int)
 */
+ (void)gx_addBasicProperty:(NSString *)name encodingType:(char *)type;

@end
