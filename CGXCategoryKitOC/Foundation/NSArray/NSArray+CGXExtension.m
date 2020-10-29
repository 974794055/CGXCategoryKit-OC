//
//  NSArray+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSArray+CGXExtension.h"

@implementation NSArray (CGXExtension)

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
    [desc appendString:@"\t(\n"];
    
    for (id obj in self) {
        if ([obj isKindOfClass:[NSDictionary class]]
            || [obj isKindOfClass:[NSArray class]]
            || [obj isKindOfClass:[NSSet class]]) {
            NSString *str = [((NSDictionary *)obj) descriptionWithLocale:locale indent:level + 1];
            [desc appendFormat:@"%@\t%@,\n", tab, str];
        } else if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"%@\t\"%@\",\n", tab, obj];
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
                    [desc appendFormat:@"%@\t%@,\n", tab, str];
                } else if ([obj isKindOfClass:[NSString class]]) {
                    [desc appendFormat:@"%@\t\"%@\",\n", tab, result];
                }
            } else {
                @try {
                    NSString *str = [[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding];
                    if (str != nil) {
                        [desc appendFormat:@"%@\t\"%@\",\n", tab, str];
                    } else {
                        [desc appendFormat:@"%@\t%@,\n", tab, obj];
                    }
                }
                @catch (NSException *exception) {
                    [desc appendFormat:@"%@\t%@,\n", tab, obj];
                }
            }
        } else {
            [desc appendFormat:@"%@\t%@,\n", tab, obj];
        }
    }
    
    [desc appendFormat:@"%@)", tab];
    
    return desc;
}
#endif

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    return strM.copy;
}

- (NSArray *)gx_reverseArray
{
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [arrayTemp addObject:element];
    }
    return arrayTemp;
}

- (BOOL)gx_isEmpty
{
    if (self != nil && ![self isKindOfClass:[NSNull class]] && self.count != 0){
        return NO;
    }
    return YES;
}

+ (CGFloat)gx_maxNumberFromArray:(NSArray *)array {
    CGFloat max = 0;
    max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
    return max;
}

+ (CGFloat)gx_minNumberFromArray:(NSArray *)array{
    CGFloat min = 0;
    min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
    return min;
}

+ (CGFloat)gx_sumNumberFromArray:(NSArray *)array{
    CGFloat sum = 0;
    sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
    return sum;
}

+ (CGFloat)gx_averageNumberFromArray:(NSArray *)array{
    CGFloat avg = 0;
    avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
    return avg;
}
- (NSArray *)gx_removeNulls {
    
    // 拷贝为可变数组
    NSMutableArray *replaced = [NSMutableArray arrayWithArray:self];
    
    // 移除当前数组中的null对象
    [replaced removeObjectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj isKindOfClass:[NSNull class]];
    }]];
    
    // 遍历数组，移除当前数组中的元素是数组或字典中包含的null对象
    [replaced enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSNull class]]) {
            /**
             *  @brief  此处直接移除null，而不是替换为字符串
             *  替换成字符串可能导致程序闪退，原因：原本是要NSArray或者NSDictionary对象，我们替换成NSString对象，导致读取出错而闪退
             */
            [replaced removeObjectAtIndex:idx];
            
        } else if ([obj isKindOfClass:[NSArray class]]) {
            
            id newObj = [obj gx_removeNulls];
            [replaced replaceObjectAtIndex:idx withObject:newObj];
            
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            
            id newObj = [obj gx_removeNulls];
            [replaced replaceObjectAtIndex:idx withObject:newObj];
        }
        
    }];
    
    return replaced;
}

- (NSArray *)gx_uniqueArray {
    NSSet *set = [NSSet setWithArray:self];
    NSArray *array = [[NSArray alloc] initWithArray:[set allObjects]];
    return array;
}
+ (NSArray *)gx_sortFromArray:(NSArray *)array {
    
    NSArray *ary = [array sortedArrayUsingComparator:^(NSString * obj1, NSString * obj2){
        
        return (NSComparisonResult)[obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    return ary;
}

+ (NSArray *)gx_sortAscendingNumFromArray:(NSArray *)array {
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        
        if ([obj1 intValue] > [obj2 intValue]) {
            return NSOrderedDescending;//下行
        } else {
            return NSOrderedAscending;//上行
        }
    }];
    
    return sortedArray;
}

+ (NSArray *)gx_sortDescendingNumFromArray:(NSArray *)array {
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        
        if ([obj1 intValue] < [obj2 intValue]) {
            return NSOrderedDescending;//下行
        } else {
            return NSOrderedAscending;//上行
        }
    }];
    
    return sortedArray;
}
+ (NSArray *)gx_sortAscendingNumFromArray:(NSArray *)array WithModelSortKey:(NSString *)sortKey Ascending:(BOOL)ascending
{
    NSSortDescriptor *sD = [NSSortDescriptor sortDescriptorWithKey:sortKey ascending:ascending];
    return [[array sortedArrayUsingDescriptors:@[sD]] mutableCopy];
}
// -- 数组排序方法（乱序）

+ (NSArray *)gx_sortOutOfOrderNumFromArray:(NSArray *)array {
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //乱序
        if (arc4random_uniform(2) == 0) {
            return [obj2 compare:obj1]; //降序
        } else{
             return [obj1 compare:obj2]; //升序
        }
    }];
    return sortedArray;
}
//- (NSArray *)gx_shuffledArray {
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
//    NSMutableArray *copy = [self mutableCopy];
//    while ([copy count] > 0)
//    {
//        int index = arc4random() % [copy count];
//        id objectToMove = [copy objectAtIndex:index];
//        [array addObject:objectToMove];
//        [copy removeObjectAtIndex:index];
//    }
//    return array;
//}

@end
