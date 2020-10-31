//
//  NSUserDefaults+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+CGXExtension.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (CGXExtension)

/**
 *    将安全对象设置为用户默认值，它将过滤所有nil或Null对象,为了防止应用程序崩溃。
 *
 *    @param value                The object to be saved.
 *    @param key          The only key.
 */
- (BOOL)gx_SaveSafeObject:(id)value forKey:(NSString *)key;


/**
 *注意：
 *使用以下方法的自定义对象，必须实现decode和encode方法，否则会导致崩溃。
 *具体实现方法可以参考BZModel.m，或直接继承BZModel。
 */

/**
 存自定义对象到Userdefault

 @param value 自定义对象
 @param defaultName key
 */
- (void)gx_setObject:(id<NSCoding>)value forKey:(NSString *)defaultName;

/**
 获取自定义对象

 @param defaultName key
 @return 自定义对象
 */
- (id)gx_objectForKey:(NSString *)defaultName;


@end

NS_ASSUME_NONNULL_END
