//
//  UIDevice+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (CGXExtension)

/**
 *  Return the device platform string
 *  Example: "iPhone3,2"
 *
 *  @return Return the device platform string
 */
+ (NSString *)gx_devicePlatform;

/**
 *  Return the user-friendly device platform string
 *  Example: "iPad Air (Cellular)"
 *
 *  @return Return the user-friendly device platform string
 */
+ (NSString *)gx_devicePlatformString;

/** 是否有摄像头 */
+ (BOOL)gx_hasCamera;

/**
 *  Check if the current device is an iPad
 *
 *  @return Return YES if it's an iPad, NO if not
 */
+ (BOOL)gx_isiPad;

/**
 *  Check if the current device is an iPhone
 *
 *  @return Return YES if it's an iPhone, NO if not
 */
+ (BOOL)gx_isiPhone;

/**
 *  Check if the current device is an iPod
 *
 *  @return Return YES if it's an iPod, NO if not
 */
+ (BOOL)gx_isiPod;

/**
 *  Check if the current device is the simulator
 *
 *  @return Return YES if it's the simulator, NO if not
 */
+ (BOOL)gx_isSimulator;

/**
 *  Check if the current device has a Retina display
 *
 *  @return Return YES if it has a Retina display, NO if not
 */
+ (BOOL)gx_isRetina;

/**
 *  Check if the current device has a Retina HD display
 *
 *  @return Return YES if it has a Retina HD display, NO if not
 */
+ (BOOL)gx_isRetinaHD;

/**
 *  Return the iOS version without the subversion
 *  Example: 7  系统的版本号 
 *
 *  @return Return the iOS version
 */
+ (NSInteger)gx_SystemVersion;

/**
 *  Return the current device CPU frequency
 * cpu个数
 *  @return Return the current device CPU frequency
 */
+ (NSUInteger)gx_cpuFrequency;

/**
 *  Return the current device BUS frequency
 *
 *  @return Return the current device BUS frequency
 */
+ (NSUInteger)gx_busFrequency;

/**
 *  Return the current device RAM size
 * ram的size
 *  @return Return the current device RAM size
 */
+ (NSUInteger)gx_ramSize;

/**
 *  Return the current device CPU number
 *
 *  @return Return the current device CPU number
 */
+ (NSUInteger)gx_cpuNumber;

/**
 *  Return the current device total memory
 *获取手机内存总量, 返回的是字节数
 *  @return Return the current device total memory
 */
+ (NSUInteger)gx_totalMemory;

/**
 *  Return the current device non-kernel memory
 * 获取手机可用内存, 返回的是字节数
 *  @return Return the current device non-kernel memory
 */
+ (NSUInteger)gx_userMemory;

/**
 *  Return the current device total disk space
 *获取手机硬盘总空间, 返回的是字节数
 *  @return Return the current device total disk space
 */
+ (NSNumber *)gx_totalDiskSpace;

/**
 *  Return the current device free disk space
 *获取手机硬盘空闲空间, 返回的是字节数
 *  @return Return the current device free disk space
 */
+ (NSNumber *)gx_freeDiskSpace;

/**
 *  Return the current device MAC address
 mac地址
 *  @return Return the current device MAC address
 */
+ (NSString *)gx_macAddress;

/**
 *  Generate an unique identifier and store it into standardUserDefaults
 *
 *  @return Return a unique identifier as a NSString
 */
+ (NSString *)gx_uniqueIdentifier;

/** 获取设备ip地址*/
+ (NSString *)gx_getDeviceIpAddress;



/**
 获取当前硬件体系类型
 */
-(NSString *)gx_deviceName;

/**
 获取当前操作系统名
 */
-(NSString *)gx_sysnameName;

/**
 获取网络上的名称
 */
-(NSString *)gx_nodenameName;

/**
 获取当前发布级别
 */
-(NSString *)gx_releaseName;

/**
 获取当前发布版本
 */
-(NSString *)gx_versionName;

@end

NS_ASSUME_NONNULL_END
