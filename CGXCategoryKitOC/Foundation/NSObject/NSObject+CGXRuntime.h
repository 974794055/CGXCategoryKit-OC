//
//  NSObject+CGXRuntime.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CGXRuntime)

/**
 swizzle交换类方法

 @param oriSel 原有方法
 @param swiSel 替换方法
 */
+ (void)gx_swizzleClassMethodOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;

/**
 swizzle交换类实例方法

 @param oriSel 原有方法
 @param swiSel 替换方法
 */
+ (void)gx_swizzleClassInstanceMethodWithOriginSel:(SEL)oriSel swizzleSel:(SEL)swiSel;

/**
 判断方法是否在子类里override了
 
 @param cls 传入要判断的Class
 @param sel 传入要判断的Selector
 @return 返回判断是否被重载的结果
 */
- (BOOL)gx_isMethodOverride:(Class)cls selector:(SEL)sel;

/// 将一个对象与“self”相关联，它是一个strong属性（strong，nonatomic）。
- (void)gx_setAssociateValue:(nullable id)value withKey:(void *)key;

/// 将一个对象与“self”相关联，它是一个弱属性（assign，nonatomic）。
- (void)gx_setAssociateWeakValue:(nullable id)value withKey:(void *)key;

/// 获取一个关联对象
- (nullable id)gx_getAssociatedValueForKey:(void *)key;

/// 移除所有的关联对象
- (void)gx_removeAssociatedValues;

/**
 判断当前类是否在主bundle里
 
 @param cls 出入类
 @return 返回判断结果
 */
+ (BOOL)gx_isMainBundleClass:(Class)cls;

/// 输出类方法
+ (void)gx_printClassMethodList;

/// 输出类属性
+ (void)gx_printClassPropertyList;
/**
 返回类属性字典
 */
- (NSDictionary *)gx_properties_aps;

/// 清空所有属性值
- (void)gx_cleanWithAllProperties;
@end

NS_ASSUME_NONNULL_END
