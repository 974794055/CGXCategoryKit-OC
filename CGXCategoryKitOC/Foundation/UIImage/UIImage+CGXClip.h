//
//  UIImage+CGXClip.h
//  CGXCategoryKit-OC-OC
//
//  CGXCategoryKit-OC
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CGXClip)


#pragma mark - 边框相关属属性，仅对生成圆形图片和矩形图片有效
/**
 *    默认为0，当<=0时，不会添加边框
 */
@property (nonatomic, assign) CGFloat gx_borderWidth;
/**
 *    当小于0时，不会添加边框。默认为0.仅对生成圆形图片和矩形图片有效。要求pathwidth > 2*borderwidth，否则只添加border而无path
 */
@property (nonatomic, assign) CGFloat gx_pathWidth;
/**
 *    边框线的颜色，默认为[UIColor lightGrayColor]，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *gx_borderColor;
/**
 *    Path颜色，默认为白色。仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *gx_pathColor;


#pragma mark - 生成圆形图片
/**
 * 生成圆形图片，默认为白色背景、isEqualScale为YES
 *    @param targetSize     裁剪后的图片大小
 *    @return 裁剪后的图片
 */
- (UIImage *)gx_clipToSize:(CGSize)targetSize;

#pragma mark - 生成带背景颜色的圆形图片
/**
 *    将图片裁剪成圆形
 *
 *    @param targetSize              裁剪后的图片大小.如果宽与高不相等，会通过isMax参数决定
 *    @param backgroundColor    背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *
 *    @return 圆形图片对象
 */
- (UIImage *)gx_clipToSize:(CGSize)targetSize
            backgroundColor:(UIColor *)backgroundColor;
#pragma mark - 生成带背景颜色的圆形图片
/**
 *    将图片裁剪成圆形
 *
 *    @param targetSize              裁剪后的图片大小.如果宽与高不相等，会通过isMax参数决定
 *    @param backgroundColor    背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *    @param isEqualScale            是否是等比例压缩
 *
 *    @return 圆形图片对象
 */
- (UIImage *)gx_clipToSize:(CGSize)targetSize
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale;

#pragma mark - 生成四个圆角图片
/**
 * 生成圆角图片，默认为白色背景、isEqualScale为YES
 *    @param targetSize      裁剪后的图片大小
 *    @param cornerRadius    图片的四个圆角值
 *    @return 裁剪后的图片
 */
- (UIImage *)gx_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius;

#pragma mark - 生成任意带圆角的图片
/**
 * 生成任意带圆角的图片，默认为白色背景，isEqualScale=YES
 *    @param targetSize      裁剪后的图片大小
 *    @param cornerRadius    图片的四个圆角值
 *    @param corners         指定哪些圆角，如果是左上、右上，可这样：UIRectCornerTopLeft | UIRectCornerTopRight
 *                           如果是全加圆角，使用UIRectCornerAllCorners
 *    @return 裁剪后的图片
 */
- (UIImage *)gx_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners;

#pragma mark - 生成是否是等比例缩放放大或者缩小带背景色图片
/**
 * 生成任意带圆角的图片，默认为白色背景，isEqualScale=YES
 *    @param targetSize      裁剪后的图片大小
 *    @param cornerRadius    图片的四个圆角值
 *    @param corners         指定哪些圆角，如果是左上、右上，可这样：UIRectCornerTopLeft | UIRectCornerTopRight
 *                           如果是全加圆角，使用UIRectCornerAllCorners
 *    @param backgroundColor 背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *    @return 裁剪后的图片
 */
- (UIImage *)gx_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor;

#pragma mark - 生成是否是等比例缩放放大或者缩小图片
/**
 * 生成任意带圆角的图片，默认为白色背景，isEqualScale=YES
 *    @param targetSize      裁剪后的图片大小
 *    @param cornerRadius    图片的四个圆角值
 *    @param corners         指定哪些圆角，如果是左上、右上，可这样：UIRectCornerTopLeft | UIRectCornerTopRight
 *                           如果是全加圆角，使用UIRectCornerAllCorners
 *    @param isEqualScale    是否是等比例压缩
 *    @return 裁剪后的图片
 */
- (UIImage *)gx_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
               isEqualScale:(BOOL)isEqualScale;


#pragma mark - 生成是否是等比例缩放放大或者缩小带背景色图片
/**
 * 生成任意带圆角的图片，默认为白色背景，isEqualScale=YES
 *    @param targetSize      裁剪后的图片大小
 *    @param cornerRadius    图片的四个圆角值
 *    @param corners         指定哪些圆角，如果是左上、右上，可这样：UIRectCornerTopLeft | UIRectCornerTopRight
 *                           如果是全加圆角，使用UIRectCornerAllCorners
 *    @param backgroundColor 背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *    @param isEqualScale    是否是等比例压缩
 *    @return 裁剪后的图片
 */
- (UIImage *)gx_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale;


#pragma mark - 最完整的API
/**
 *    剪裁图片为任意指定圆角。isCircle的优化级最高，其次是cornerRadius，最后才是corners。
 *
 *    @param targetSize              裁剪成指定的大小
 *    @param cornerRadius          圆角大小
 *    @param corners                    哪些圆角，多个圆角可用 | 来连接
 *    @param backgroundColor    背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *    @param isEqualScale     是否是等比例压缩
 *    @param isCircle                    是否剪裁成圆。优化级最高。若为YES，生成的是圆形图片。
 *
 *    @return 剪裁后的图片
 */
- (UIImage *)gx_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale
                   isCircle:(BOOL)isCircle;

@end

NS_ASSUME_NONNULL_END
