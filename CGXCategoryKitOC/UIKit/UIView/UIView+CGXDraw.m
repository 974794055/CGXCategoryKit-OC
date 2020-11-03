//
//  UIView+CGXDraw.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2020/11/3.
//

#import "UIView+CGXDraw.h"

@implementation UIView (CGXDraw)


- (void)gx_drawDashLineWithpointArray:(NSArray *)pointArr lineWidth:(float)lineWidth lineLength:(float)lineLength lineSpacing:(float)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为lineColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:lineWidth];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线长度，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint point = CGPointFromString(pointArr[0]);
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    
    for (NSInteger i=1; i<pointArr.count; i++) {
        CGPoint point = CGPointFromString(pointArr[i]);
        CGPathAddLineToPoint(path, NULL, point.x, point.y);
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

@end
