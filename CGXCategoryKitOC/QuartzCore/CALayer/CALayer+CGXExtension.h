//
//  CALayer+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CALayer (CGXExtension)
/** 左右抖动 */
-(void)gx_shake;
/**

 *
 *  layer边框颜色
 */
@property(nonatomic, assign) UIColor *gx_borderColor;

@end

NS_ASSUME_NONNULL_END
