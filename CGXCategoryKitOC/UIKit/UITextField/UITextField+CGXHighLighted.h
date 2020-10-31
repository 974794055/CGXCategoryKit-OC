//
//  UITextField+OKA.h
//  CategoryManager
//
//  Created by  CGX on 2017/2/22.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+CGXSelect.h"
@interface UITextField (CGXHighLighted)


/** 是否高亮 */
@property (nonatomic, readonly) BOOL gx_isHighLighted;

/**
 输入无效,将已经数据的打回原形
 
 @param curContent 希望当前的显示内容
 */
- (void)gx_invalidTextFieldCurContent:(NSString*)curContent;


@end
