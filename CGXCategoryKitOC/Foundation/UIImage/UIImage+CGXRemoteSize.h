//
//  UIImage+CGXRemoteSize.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CGXRemoteSizeRequestCompleted) (NSURL* imgURL, CGSize size);

@interface UIImage (CGXRemoteSize)
/**
 *  @brief 获取远程图片的大小
 *
 *  @param imgURL     图片url
 *  @param completion 完成回调
 */
+ (void)gx_requestSizeNoHeader:(NSURL*)imgURL completion:(CGXRemoteSizeRequestCompleted)completion;

@end
