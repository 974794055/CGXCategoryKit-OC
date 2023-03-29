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
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    /*
    renderInContext:方式实际上是通过遍历UIView的layer tree进行渲染，但是它不支持动画的渲染，它的的性能会和layer tree的复杂度直接关联
    drawViewHierarchyInRect:afterScreenUpdates:的api是苹果基于UIView的扩展，与第一种方式不同，这种方式是直接获取当前屏幕的“快照”，此种方式的性能与UIView的frame大小直接关联。
    在UIView内容不是很“长”的情况下，第二种方式有内存优势的；但是随着UIView的内容增加，第二种方式会有较大增加；
             第一种(内存)           第二种(内存)       第一种(耗时)        第二种(耗时)
    1~2屏    28.4323M             8.1431M           195.765972ms      271.728992ms
    2~3屏    36.0012M             8.5782M           221.408010ms      280.839980ms
    5屏以上   38.511718M           23.1875M          448.800981ms      565.396011ms
    */
    if ([self isKindOfClass:[UIScrollView class]]) {
        CGRect rect = self.frame;
        rect.size = ((UIScrollView *)self).contentSize;
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.layer renderInContext:context];
    } else {
        /*
         * 参数一: 指定将来创建出来的bitmap的大小
         * 参数二: 设置透明YES代表透明，NO代表不透明
         * 参数三: 代表缩放,0代表不缩放
         */
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, [UIScreen mainScreen].scale);
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 
 *  @param maxWidth 限制缩放的最大宽度 保持默认传0
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


- (NSData *)gx_snapshotPDF
{
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (UIImage *)gx_cutoutInViewWithRect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.layer.contents = nil;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
    img = [UIImage imageWithCGImage:imageRef];
    return img;
}

- (void)appaddBlurEffectWith:(UIBlurEffectStyle)blurStyle
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:blurStyle];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:effectView];
}
@end
