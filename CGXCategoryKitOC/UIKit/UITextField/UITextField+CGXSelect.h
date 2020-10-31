//
//  UITextField+CGXSelect.h
//  CGXAppStructure
//
//  Created by CGX on 2018/12/14.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CGXSelect)
/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)gx_selectedRange;
/**
 *  @brief  选中所有文字
 */
- (void)gx_selectAllText;
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)gx_setSelectedRange:(NSRange)range;
@end
