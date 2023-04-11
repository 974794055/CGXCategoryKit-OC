//
//  UIGestureRecognizer+CGXCategoryBlock.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIGestureRecognizer+CGXCategoryBlock.h"
#import <objc/runtime.h>

static const int block_key;

@interface CGXCategoryUIGestureRecognizerBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation CGXCategoryUIGestureRecognizerBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end

@implementation UIGestureRecognizer (CGXCategoryBlock)

- (instancetype)initWithGXActionBlock:(void (^)(id sender))block {
    self = [self init];
    [self gx_addActionBlock:block];
    return self;
}

- (void)gx_addActionBlock:(void (^)(id sender))block {
    CGXCategoryUIGestureRecognizerBlockTarget *target = [[CGXCategoryUIGestureRecognizerBlockTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self p_allUIGestureRecognizerBlockTargets];
    [targets addObject:target];
}

- (void)gx_removeAllActionBlocks{
    NSMutableArray *targets = [self p_allUIGestureRecognizerBlockTargets];
    [targets enumerateObjectsUsingBlock:^(id target, NSUInteger idx, BOOL *stop) {
        [self removeTarget:target action:@selector(invoke:)];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)p_allUIGestureRecognizerBlockTargets
{
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
