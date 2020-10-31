//
//  NSObject+CGXKVOBlocks.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSObject+CGXKVOBlocks.h"
#import <objc/runtime.h>

@implementation NSObject (CGXKVOBlocks)

-(void)gx_addObserver:(NSObject *)observer
        forKeyPath:(NSString *)keyPath
           options:(NSKeyValueObservingOptions)options
           context:(void *)context
         withBlock:(CGXKVOBlock)block {
    
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), block, OBJC_ASSOCIATION_COPY);
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}

-(void)gx_removeBlockObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath {
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), nil, OBJC_ASSOCIATION_COPY);
    [self removeObserver:observer forKeyPath:keyPath];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    CGXKVOBlock block = objc_getAssociatedObject(self, (__bridge const void *)(keyPath));
    if (block) {
        block(change, context);
    }
}

-(void)gx_addObserverForKeyPath:(NSString *)keyPath
                     options:(NSKeyValueObservingOptions)options
                     context:(void *)context
                   withBlock:(CGXKVOBlock)block {
    
    [self gx_addObserver:self forKeyPath:keyPath options:options context:context withBlock:block];
}

-(void)gx_removeBlockObserverForKeyPath:(NSString *)keyPath {
    [self gx_removeBlockObserver:self forKeyPath:keyPath];
}

@end
