//
//  NSMutableArray+CGXAdditional.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/19.
//

#import "NSMutableArray+CGXAdditional.h"

@implementation NSMutableArray (CGXAdditional)
+ (nullable NSMutableArray *)gx_arrayWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSMutableArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    if ([array isKindOfClass:[NSMutableArray class]]) return array;
    return nil;
}

+ (nullable NSMutableArray *)gx_arrayWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self gx_arrayWithPlistData:data];
}

- (void)gx_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)gx_removeLastObject {
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}
#pragma clang diagnostic pop

- (nullable id)gx_popFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self gx_removeFirstObject];
    }
    return obj;
}

- (nullable id)gx_popLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self gx_removeLastObject];
    }
    return obj;
}

- (void)gx_appendObject:(id)anObject {
    
    [self addObject:anObject];
}

- (void)gx_prependObject:(id)anObject {
    [self insertObject:anObject atIndex:0];
}

- (void)gx_appendObjects:(NSArray *)objects {
    if (!objects) return;
    [self addObjectsFromArray:objects];
}

- (void)gx_prependObjects:(NSArray *)objects {
    if (!objects) return;
    NSUInteger i = 0;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)gx_insertObjects:(NSArray *)objects
                 atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)gx_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)gx_shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}

@end
