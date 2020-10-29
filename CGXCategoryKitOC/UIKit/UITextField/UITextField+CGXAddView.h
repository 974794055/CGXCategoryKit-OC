//
//  UITextField+CGXAddView.h
//  CGXAppStructure-OC
//
//  Created by CGX on 2019/6/24.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (CGXAddView)

/**
 *  左边占位图间距
 */
@property (nonatomic, assign) CGFloat gx_leftSpace1;
@property (nonatomic, assign) CGFloat gx_leftSpace2;

/**
 *  左边占位图间距
 */
@property (nonatomic, assign) CGFloat gx_rightSpace1;
@property (nonatomic, assign) CGFloat gx_rightSpace2;


- (void)gx_addLeftViewWithImage:(NSString *)image;

- (void)gx_addRightViewWithImage:(NSString *)image;

@end

NS_ASSUME_NONNULL_END
