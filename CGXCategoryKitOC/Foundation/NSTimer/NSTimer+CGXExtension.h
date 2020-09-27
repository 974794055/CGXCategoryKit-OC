//
//  NSTimer+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (CGXExtension)

typedef void(^GXTimerCallback)(NSTimer *timer);

/**
 *    创建一个有时间间隔的计时器，重复或不重复，以及回调。
 *
 *    @param interval    Time interval
 *    @param repeats    Whether repeat to schedule.
 *    @param callback The callback block.
 *
 *    @return Timer object.
 */
+ (NSTimer *)gx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                       repeats:(BOOL)repeats
                                      callback:(GXTimerCallback)callback;
/**
 *    创建具有时间间隔、重复计数和回调的计时器。
 *
 *    @param interval    Time interval
 *    @param count        When count <= 0, it means repeat.
 *    @param callback    The callback block
 *
 *    @return Timer object
 */
+ (NSTimer *)gx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         count:(NSInteger)count
                                      callback:(GXTimerCallback)callback;

/**
 *    立即开始计时。
 */
- (void)gx_fireTimer;

/**
 *    立即暂停计时器
 */
- (void)gx_unfireTimer;

/**
 *    销毁计时器
 */
- (void)gx_invalidate;

/** 延迟开始NSTimer */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;


@end

NS_ASSUME_NONNULL_END
