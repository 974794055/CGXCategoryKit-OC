//
//  UITextField+CGXExtension.h
//  CGXAppStructure
//
//  Created by CGX on 2018/12/14.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (CGXExtension)
/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *gx_placeholderColor;
/**
 *  占位文字大小
 */
@property (nonatomic, strong) UIFont *gx_placeholderFont;
/**
 *  文本最大支持多少个字符，设置后会自动根据该属性截取文本字符长度
 */
@property (nonatomic, assign) NSInteger gx_maximumLimit;

/**
 *  文本发生改变时回调
 */
- (void)gx_textDidChange:(void(^)(NSString *textStr))handle;

/**
 *  处理系统输入法导致的乱码,如果调用了maximumLimit属性，内部会默认处理乱码
 */
- (void)gx_fixMessyDisplay;



@end

NS_ASSUME_NONNULL_END
