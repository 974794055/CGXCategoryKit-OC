//
//  UITextField+OKA.m
//  CategoryManager
//
//  Created by  CGX on 2017/2/22.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import "UITextField+CGXHighLighted.h"

@implementation UITextField (CGXHighLighted)

- (BOOL)gx_isHighLighted {
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *pos = [self positionFromPosition:selectedRange.start offset:0];
    return (selectedRange && pos);
    
}
/**
 输入无效,将已经数据的打回原形
 
 @param curContent 希望当前的显示内容
 */
- (void)gx_invalidTextFieldCurContent:(NSString*)curContent {
    // 保留光标的位置信息
    NSRange selectedRange = [self gx_selectedRange];
    // 保留当前文本的内容
    NSString* tmpSTR = self.text;
    
    // 设置了文本,光标到了最后
    self.text = curContent;
    // 重新设置光标的位置
    selectedRange.location -= (tmpSTR.length - curContent.length);
    [self gx_setSelectedRange:selectedRange];
}
@end
