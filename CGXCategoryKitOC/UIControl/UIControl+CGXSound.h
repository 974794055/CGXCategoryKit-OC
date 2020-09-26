//
//  UIButton+CGXSound.h
//  CGXSound
//
//  Created by CGX on 2018/12/14.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIControl (CGXSound)

/// Set the sound for a particular control event (or events).
/// @param name The name of the file. The method looks for an image with the specified name in the application’s main bundle.
/// @param controlEvent A bitmask specifying the control events for which the action message is sent. See “Control Events” for bitmask constants.
//不同事件增加不同声音
- (void)gx_playSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent;

@end
