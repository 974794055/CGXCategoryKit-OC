//
//  NSMutableArray+CGXSort.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/19.
//

#import "NSMutableArray+CGXSort.h"

@implementation NSMutableArray (CGXSort)

/// 交换两个元素
- (void)gx_exchangeWithIndexA:(NSInteger)indexA indexB:(NSInteger)indexB didExchange:(CGXSortExchangeCallback)exchangeCallback {
    id temp = self[indexA];
    self[indexA] = self[indexB];
    self[indexB] = temp;
    
    if (exchangeCallback) {
        exchangeCallback(temp, self[indexA]);
    }
}

#pragma mark - 选择排序
- (void)gx_selectionSortUsingComparator:(CGXSortComparator)comparator didExchange:(CGXSortExchangeCallback)exchangeCallback {
    if (self.count == 0) {
        return;
    }
    for (NSInteger i = 0; i < self.count - 1; i ++) {
        for (NSInteger j = i + 1; j < self.count; j ++) {
            if (comparator(self[i], self[j]) == NSOrderedDescending) {
                [self gx_exchangeWithIndexA:i indexB:j didExchange:exchangeCallback];
            }
        }
    }
}

#pragma mark - 冒泡排序
- (void)gx_bubbleSortUsingComparator:(CGXSortComparator)comparator didExchange:(CGXSortExchangeCallback)exchangeCallback {
    if (self.count == 0) {
        return;
    }
    for (NSInteger i = self.count - 1; i > 0; i --) {
        for (NSInteger j = 0; j < i; j ++) {
            if (comparator(self[j], self[j + 1]) == NSOrderedDescending) {
                [self gx_exchangeWithIndexA:j indexB:j + 1 didExchange:exchangeCallback];
            }
        }
    }
}

#pragma mark - 插入排序
- (void)gx_insertionSortUsingComparator:(CGXSortComparator)comparator didExchange:(CGXSortExchangeCallback)exchangeCallback {
    for (NSInteger i = 1; i < self.count; i ++) {
        for (NSInteger j = i; j > 0 && comparator(self[j], self[j - 1]) == NSOrderedAscending; j --) {
            [self gx_exchangeWithIndexA:j indexB:j - 1 didExchange:exchangeCallback];
        }
    }
}

#pragma mark - 快速排序
- (void)gx_quickSortUsingComparator:(CGXSortComparator)comparator didExchange:(CGXSortExchangeCallback)exchangeCallback {
    if (self.count == 0) {
        return;
    }
    [self gx_quickSortWithLowIndex:0 highIndex:self.count - 1 usingComparator:comparator didExchange:exchangeCallback];
}

- (void)gx_quickSortWithLowIndex:(NSInteger)low highIndex:(NSInteger)high usingComparator:(CGXSortComparator)comparator didExchange:(CGXSortExchangeCallback)exchangeCallback {
    if (low >= high) {
        return;
    }
    NSInteger pivotIndex = [self gx_quickPartitionWithLowIndex:low highIndex:high usingComparator:comparator didExchange:exchangeCallback];
    [self gx_quickSortWithLowIndex:low highIndex:pivotIndex - 1 usingComparator:comparator didExchange:exchangeCallback];
    [self gx_quickSortWithLowIndex:pivotIndex + 1 highIndex:high usingComparator:comparator didExchange:exchangeCallback];
}

- (NSInteger)gx_quickPartitionWithLowIndex:(NSInteger)low highIndex:(NSInteger)high usingComparator:(CGXSortComparator)comparator didExchange:(CGXSortExchangeCallback)exchangeCallback {
    id pivot = self[low];
    NSInteger i = low;
    NSInteger j = high;
    
    while (i < j) {
        // 略过大于等于pivot的元素
        while (i < j && comparator(self[j], pivot) != NSOrderedAscending) {
            j --;
        }
        if (i < j) {
            // i、j未相遇，说明找到了小于pivot的元素。交换。
            [self gx_exchangeWithIndexA:i indexB:j didExchange:exchangeCallback];
            i ++;
        }
        
        /// 略过小于等于pivot的元素
        while (i < j && comparator(self[i], pivot) != NSOrderedDescending) {
            i ++;
        }
        if (i < j) {
            // i、j未相遇，说明找到了大于pivot的元素。交换。
            [self gx_exchangeWithIndexA:i indexB:j didExchange:exchangeCallback];
            j --;
        }
    }
    return i;
}

#pragma mark - 堆排序
- (void)gx_heapSortUsingComparator:(CGXSortComparator)comparator didExchange:(CGXSortExchangeCallback)exchangeCallback {
    // 排序过程中不使用第0位
    [self insertObject:[NSNull null] atIndex:0];
    
    // 构造大顶堆
    // 遍历所有非终结点，把以它们为根结点的子树调整成大顶堆
    // 最后一个非终结点位置在本队列长度的一半处
    for (NSInteger index = self.count / 2; index > 0; index --) {
        // 根结点下沉到合适位置
        [self gx_sinkIndex:index bottomIndex:self.count - 1 usingComparator:comparator didExchange:exchangeCallback];
    }
    
    // 完全排序
    // 从整棵二叉树开始，逐渐剪枝
    for (NSInteger index = self.count - 1; index > 1; index --) {
        // 每次把根结点放在列尾，下一次循环时将会剪掉
        [self gx_exchangeWithIndexA:1 indexB:index didExchange:exchangeCallback];
        // 下沉根结点，重新调整为大顶堆
        [self gx_sinkIndex:1 bottomIndex:index - 1 usingComparator:comparator didExchange:exchangeCallback];
    }
    
    // 排序完成后删除占位元素
    [self removeObjectAtIndex:0];
}

/// 下沉，传入需要下沉的元素位置，以及允许下沉的最底位置
- (void)gx_sinkIndex:(NSInteger)index bottomIndex:(NSInteger)bottomIndex usingComparator:(CGXSortComparator)comparator didExchange:(CGXSortExchangeCallback)exchangeCallback {
    for (NSInteger maxChildIndex = index * 2; maxChildIndex <= bottomIndex; maxChildIndex *= 2) {
        // 如果存在右子结点，并且左子结点比右子结点小
        if (maxChildIndex < bottomIndex && (comparator(self[maxChildIndex], self[maxChildIndex + 1]) == NSOrderedAscending)) {
            // 指向右子结点
            ++ maxChildIndex;
        }
        // 如果最大的子结点元素小于本元素，则本元素不必下沉了
        if (comparator(self[maxChildIndex], self[index]) == NSOrderedAscending) {
            break;
        }
        // 否则
        // 把最大子结点元素上游到本元素位置
        [self gx_exchangeWithIndexA:index indexB:maxChildIndex didExchange:exchangeCallback];
        // 标记本元素需要下沉的目标位置，为最大子结点原位置
        index = maxChildIndex;
    }
}







/**
 *  把联系人按首字母进行排序
 *
 *  @param array 需要排序的数组
 *
 *  @return 返回按各个字母排序好数组（数组中包含数组）
 */
+ (NSMutableArray*)gx_sortArrayByFirstLetterWithArray:(NSMutableArray*)array {
    
    NSMutableArray *sortSectionArray = [NSMutableArray array];
    
    NSString *tempString;
    
    NSMutableArray *itme;
    
    // 首先对其进行排序
    NSMutableArray *sortArray = [[array sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        obj1 = gxSort_removeSpecialCharacter(obj1);
        obj2 = gxSort_removeSpecialCharacter(obj2);
        NSString *str1 = gxSort_chineseStringTransformToPinYin(obj1);
        
        NSString *str2 = gxSort_chineseStringTransformToPinYin(obj2);
        
        return [str1 compare:str2];
        
        
    }] mutableCopy];
    
    
    // 对其排序
    for (int i = 0; i<sortArray.count; i++) {
        
        NSString *str = sortArray[i];
        NSString *tempStr = gxSort_removeSpecialCharacter(str);
        
        NSString*firstString;
        
        if (str.length>0&&!gxSort_isContainChinese(tempStr)) {
            
            firstString = [[str substringToIndex:1] uppercaseString];
        }
        else if(str.length>0&&gxSort_isContainChinese(tempStr)){
            
            firstString = gxSort_fisrtUppercasePinYin(tempStr);
            
        }
        
        // 不同
        if (![tempString isEqualToString:firstString]) {
            
            //分组
            itme = [NSMutableArray array];
            [itme addObject:str];
            tempString = firstString;
            [sortSectionArray addObject:itme];
        }
        else {
            
            [itme addObject:str];
        }
    }
    return sortSectionArray;
}


// 通过分组数组来获取索引
+(NSMutableArray*)gx_getSectionIndexsArrayWithSortSecionsArray:(NSMutableArray*)sortSecionsArray {
    
    
    NSMutableArray *indexsArray = [NSMutableArray array];
    
    for (NSArray *arr in sortSecionsArray) {
        
        NSString *str = [arr firstObject];
        NSString *tempStr = gxSort_removeSpecialCharacter(str);

        NSString *firstLetter = @"";
        
        if (str.length>0&&!gxSort_isContainChinese(tempStr)) {
            
            firstLetter = [[tempStr substringToIndex:1] uppercaseString];
            
        }
        else if (str.length>0&&gxSort_isContainChinese(tempStr)) {
            
            firstLetter = gxSort_fisrtUppercasePinYin(tempStr);
        }
        
        [indexsArray addObject:firstLetter];
    }
    
    return indexsArray;
}

#pragma mark -- 将数组拆分成固定长度

/**
 *  将数组拆分成固定长度的子数组
 *
 *  @param array 需要拆分的数组
 *
 *  @param subSize 指定长度
 *
 */
NSArray * splitArray(NSArray *array, int subSize) {
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        //数组下标
        int index = i * subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        
        int j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < subSize*(i + 1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j += 1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];
    }
    
    return [arr copy];
}

NSString *gxSort_removeSpecialCharacter(NSString *string) {
    NSMutableString *trimmedStr = [NSMutableString new];
    for (int i = 0; i < string.length; i++) {
        unichar ch = [string characterAtIndex:i];
        if ((0x4e00 < ch  && ch < 0x9fff) || ((ch >= 0x0041 && ch<= 0x005a) || (ch >= 0x0061 && ch<= 0x007a))) {
            NSString *subStr = [string substringWithRange:NSMakeRange(i, 1)];
            if (ch >= 0x0041 && ch<= 0x005a) {
                subStr = subStr.lowercaseString;
            }
            [trimmedStr appendString:subStr];
        }
    }
    return [NSString stringWithFormat:@"%@",trimmedStr];
}

NSString * gxSort_chineseStringTransformToPinYin(NSString *string) {
    
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:string];
    
    // 转为带声调的拉丁文
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformMandarinLatin, NO);
    
    // 去掉声调
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, NO);
    
    return mutableString;
}


NSString * gxSort_fisrtUppercasePinYin(NSString *string) {
    
    
    NSString *str = gxSort_chineseStringTransformToPinYin(string);
    
    
    return  [[str uppercaseString] substringToIndex:1];
 
}


BOOL gxSort_isContainChinese(NSString *string) {
    
    for (int i = 0; i < string.length; i++) {
        
        unichar ch = [string characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}

@end
