//
//  NSObject+CGXKVOBlocks.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef void (^CGXKVOBlock)(NSDictionary *change, void *context);

@interface NSObject (CGXKVOBlocks)
/**
 添加观察者与监听属性
 
 @param observer 观察者,一般为其他对象(谁想监听)
 @param keyPath 监听的属性
 @param options 监听模式
 @param context context
 @param block  监听回调
 */
- (void)gx_addObserver:(NSObject *)observer
         forKeyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
            context:(void *)context
          withBlock:(CGXKVOBlock)block;
/**
 移除观察者对属性的监听

 @param observer 观察者,一般为其他对象(谁想监听)
 @param keyPath 监听的属性
 */
-(void)gx_removeBlockObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath;

/**
 对象本身作为观察者

 @param keyPath 监听的属性
 @param options 监听模式
 @param context context
 @param block 监听回调
 */
-(void)gx_addObserverForKeyPath:(NSString *)keyPath
                     options:(NSKeyValueObservingOptions)options
                     context:(void *)context
                   withBlock:(CGXKVOBlock)block;

/**
 移除观察者对属性的监听

 @param keyPath 监听的属性
 */
-(void)gx_removeBlockObserverForKeyPath:(NSString *)keyPath;

@end
