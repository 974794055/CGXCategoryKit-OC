//
//  UITextView+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CGXExtension)
/**
 *  文本发生改变时回调
 */
- (void)gx_textDidChange:(void(^)(NSString *textStr))handle;

@end

NS_ASSUME_NONNULL_END
