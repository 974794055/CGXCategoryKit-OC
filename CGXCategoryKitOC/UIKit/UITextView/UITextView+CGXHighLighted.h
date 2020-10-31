//
//  UITextView+CGXHighLighted.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface UITextView (CGXHighLighted)

/**
 * 获取高亮部分
 */
- (NSInteger)gx_getInputLengthWithText:(NSString *)text;

/** 是否高亮 */
@property (nonatomic, readonly) BOOL gx_isHighLighted;


/**
 输入无效,将已经数据的打回原形
 
 @param curContent 希望当前的显示内容
 */
- (void)gx_invalidTextFieldCurContent:(NSString*)curContent;
@end
