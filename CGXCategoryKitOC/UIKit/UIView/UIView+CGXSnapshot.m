//
//  UIView+CGXSnapshot.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXSnapshot.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIView (CGXSnapshot)

#pragma mark - 屏幕快照
- (UIImage *)gx_snapshotImage
{
    //开启图片的图形上下文
    //参数1：图片上下文的大小
    //参数2：不透明(YES：不透明；NO：透明)
    //参数3：缩放因子，即2X、3X，设为0.0，系统会自动识别
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    
    //将当前视图的层次结构渲染到上下文中
    //updates -> 是否更新? -> tableView在滚动的过程,截图!保证不会有不清晰的情况
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    //获取图片
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(snapshotImage, nil, nil, nil);
    
    //返回图片
    return snapshotImage;
}

/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)gx_screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}
/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param aView    一个view
 *  @param limitWidth 限制缩放的最大宽度 保持默认传0
 *
 *  @return 截图
 */
- (UIImage *)gx_screenshot:(CGFloat)maxWidth{
    CGAffineTransform oldTransform = self.transform;
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    
//    if (!isnan(scale)) {
//        CGAffineTransform transformScale = CGAffineTransformMakeScale(scale, scale);
//        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
//    }
    if (!isnan(maxWidth) && maxWidth>0) {
        CGFloat maxScale = maxWidth/CGRectGetWidth(self.frame);
        CGAffineTransform transformScale = CGAffineTransformMakeScale(maxScale, maxScale);
        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
        
    }
    if(!CGAffineTransformEqualToTransform(scaleTransform, CGAffineTransformIdentity)){
        self.transform = scaleTransform;
    }
    
    CGRect actureFrame = self.frame; //已经变换过后的frame
    CGRect actureBounds= self.bounds;//CGRectApplyAffineTransform();
    
    //begin
    UIGraphicsBeginImageContextWithOptions(actureFrame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1, -1);
    CGContextTranslateCTM(context,actureFrame.size.width/2, actureFrame.size.height/2);
    CGContextConcatCTM(context, self.transform);
    CGPoint anchorPoint = self.layer.anchorPoint;
    CGContextTranslateCTM(context,
                          -actureBounds.size.width * anchorPoint.x,
                          -actureBounds.size.height * anchorPoint.y);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //end
    self.transform = oldTransform;
    
    return screenshot;
}
@end
