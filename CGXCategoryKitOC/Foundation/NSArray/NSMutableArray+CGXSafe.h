//
//  NSMutableArray+CGXSafe.h
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (CGXSafe)
/// 加一个主键不重复的元素，如果元素是字符串key可以不用传；如果元素是字典，则传主键
/// @param anObject 参数
/// @param key 主键
- (void)gx_addObject:(id)anObject withKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
