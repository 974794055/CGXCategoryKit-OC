//
//  NSString+CGXScore.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, CGXScoreOption) {
    CGXScoreOptionNone = 1 << 0,
    CGXScoreOptionFavorSmallerWords = 1 << 1,
    CGXScoreOptionReducedLongStringPenalty = 1 << 2
};

//模糊匹配字符串 查找某两个字符串的相似程度
@interface NSString (CGXScore)

- (CGFloat)gx_scoreAgainst:(NSString *)otherString;
- (CGFloat)gx_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness;
- (CGFloat)gx_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness options:(CGXScoreOption)options;

@end
