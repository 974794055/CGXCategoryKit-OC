//
//  NSMutableString+CGXSafe.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (CGXSafe)

/* hook方法如下：
 substringFromIndex:
 substringToIndex:
 substringWithRange:
 lineRangeForRange:
 enumerateSubstringsInRange:options:usingBlock:
 stringByReplacingOccurrencesOfString:withString:options:range:
 stringByReplacingCharactersInRange:withString:
 
 insertString:atIndex:
 deleteCharactersInRange:
 replaceOccurrencesOfString:withString:options:range:
 
 内部做了安全取值处理
*/

@end

NS_ASSUME_NONNULL_END
