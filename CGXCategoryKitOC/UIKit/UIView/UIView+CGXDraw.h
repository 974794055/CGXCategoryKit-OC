//
//  UIView+CGXDraw.h
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGXDraw)

/**
 绘制虚线

 @param pointArr 通过NSStringFromCGPoint传入坐标数组
 @param lineWidth 虚线的宽度
 @param lineLength 虚线的长度
 @param lineSpacing 虚线的间距
 @param lineColor 虚线的颜色
 */
- (void)gx_drawDashLineWithpointArray:(NSArray *)pointArr lineWidth:(float)lineWidth lineLength:(float)lineLength lineSpacing:(float)lineSpacing lineColor:(UIColor *)lineColor;

@end

NS_ASSUME_NONNULL_END
