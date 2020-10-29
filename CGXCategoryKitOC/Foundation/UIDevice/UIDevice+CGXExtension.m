//
//  UIDevice+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIDevice+CGXExtension.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/utsname.h>
static NSString * const BFUniqueIdentifierDefaultsKey = @"BFUniqueIdentifier";

@implementation UIDevice (CGXExtension)


+ (NSString *)gx_devicePlatform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    
    return platform;
}

+ (NSString *)gx_devicePlatformString {
    NSString *platform = [self gx_devicePlatform];
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    
    if([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch (Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch (Cellular)";
    
    if ([platform isEqualToString:@"iPad6,11"])     return @"iPad 5 (WiFi)";
    if ([platform isEqualToString:@"iPad6,12"])     return @"iPad 5 (Cellular)";
    if ([platform isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9-inch (Cellular)";
    if ([platform isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5-inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5-inch (Cellular)";
    
    
    if ([platform isEqualToString:@"iPad7,5"])     return @"iPad 6th Gen (WiFi)";
    if ([platform isEqualToString:@"iPad7,6"])     return @"iPad 6th Gen (WiFi+Cellular)";
    
    if ([platform isEqualToString:@"iPad8,1"])     return @"iPad Pro 3rd Gen (11 inch, WiFi)";
    if ([platform isEqualToString:@"iPad8,2"])     return @"iPad Pro 3rd Gen (11 inch, 1TB, WiFi)";
    if ([platform isEqualToString:@"iPad8,3"])     return @"iPad Pro 3rd Gen (11 inch, WiFi+Cellular)";
    if ([platform isEqualToString:@"iPad8,4"])     return @"iPad Pro 3rd Gen (11 inch, 1TB, WiFi+Cellular)";
    if ([platform isEqualToString:@"iPad8,5"])     return @"iPad Pro 3rd Gen (12.9 inch, WiFi)";
    if ([platform isEqualToString:@"iPad8,6"])     return @"iPad Pro 3rd Gen (12.9 inch, 1TB, WiFi)";
    if ([platform isEqualToString:@"iPad8,7"])     return @"iPad Pro 3rd Gen (12.9 inch, WiFi+Cellular)";
    if ([platform isEqualToString:@"iPad8,8"])     return @"iPad Pro 3rd Gen (12.9 inch, 1TB, WiFi+Cellular)";
    
    
    if ([platform isEqualToString:@"iPad11,1"])     return @"iPad mini 5th Gen (WiFi)";
    if ([platform isEqualToString:@"iPad11,2"])     return @"iPad mini 5th Gen";
    if ([platform isEqualToString:@"iPad11,3"])     return @"iPad Air 3rd Gen (WiFi)";
    if ([platform isEqualToString:@"iPad11,4"])     return @"iPad Air 3rd Gen";
    
    
    if ([platform isEqualToString:@"Watch1,1"])     return @"Apple Watch 38mm case";
    if ([platform isEqualToString:@"Watch1,2"])     return @"Apple Watch 38mm case";
    if ([platform isEqualToString:@"Watch2,6"])     return @"Apple Watch Series 1 38mm case";
    if ([platform isEqualToString:@"Watch2,7"])     return @"Apple Watch Series 1 42mm case";
    if ([platform isEqualToString:@"Watch2,3"])     return @"Apple Watch Series 2 38mm case";
    if ([platform isEqualToString:@"Watch2,4"])     return @"Apple Watch Series 2 42mm case";
    if ([platform isEqualToString:@"Watch3,1"])     return @"Apple Watch Series 3 38mm case (GPS+Cellular)";
    if ([platform isEqualToString:@"Watch3,2"])     return @"Apple Watch Series 3 42mm case (GPS+Cellular)";
    if ([platform isEqualToString:@"Watch3,3"])     return @"Apple Watch Series 3 38mm case (GPS)";
    if ([platform isEqualToString:@"Watch3,4"])     return @"Apple Watch Series 3 42mm case (GPS)";
    
    if ([platform isEqualToString:@"Watch4,1"])     return @"Apple Watch Series 4 40mm case (GPS)";
    if ([platform isEqualToString:@"Watch4,2"])     return @"Apple Watch Series 4 44mm case (GPS)";
    if ([platform isEqualToString:@"Watch4,3"])     return @"Apple Watch Series 4 40mm case (GPS+Cellular)";
    if ([platform isEqualToString:@"Watch4,4"])     return @"Apple Watch Series 4 44mm case (GPS+Cellular)";
    
    
    if ([platform isEqualToString:@"Watch5,1"])     return @"Apple Watch Series 5 40mm case (GPS)";
    if ([platform isEqualToString:@"Watch5,2"])     return @"Apple Watch Series 5 44mm case (GPS)";
    if ([platform isEqualToString:@"Watch5,3"])     return @"Apple Watch Series 5 40mm case (GPS+Cellular)";
    if ([platform isEqualToString:@"Watch5,4"])     return @"Apple Watch Series 5 44mm case (GPS+Cellular)";
    
    
//    [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    
    
    
    return platform;
}
+ (BOOL)gx_hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
+ (BOOL)gx_isiPad {
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
    
}

+ (BOOL)gx_isiPhone {
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return YES;
    }
    return NO;
}

+ (BOOL)gx_isiPod {
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
}

+ (BOOL)gx_isSimulator {
    return [[self gx_devicePlatform] isEqualToString:@"i386"]
    || [[self gx_devicePlatform] isEqualToString:@"x86_64"];
}

+ (BOOL)gx_isRetina {
    return [[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)]
    && ([UIScreen mainScreen].scale == 2.0 || [UIScreen mainScreen].scale == 3.0);
}

+ (BOOL)gx_isRetinaHD {
    return [[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)]
    && ([UIScreen mainScreen].scale == 3.0);
}

+ (NSInteger)gx_SystemVersion {
    return [[[UIDevice currentDevice] systemVersion] integerValue];
}

+ (NSUInteger)gx_cpuFrequency {
    return [self gx_getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)gx_busFrequency {
    return [self gx_getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)gx_ramSize {
    return [self gx_getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)gx_cpuNumber {
    return [self gx_getSysInfo:HW_NCPU];
}

+ (NSUInteger)gx_totalMemory {
    return [self gx_getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)gx_userMemory {
    return [self gx_getSysInfo:HW_USERMEM];
}

+ (NSNumber *)gx_totalDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

+ (NSNumber *)gx_freeDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

+ (NSString *)gx_macAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)gx_uniqueIdentifier {
    NSString *uuid;
    if([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        uuid = [defaults objectForKey:BFUniqueIdentifierDefaultsKey];
        if (!uuid) {
            uuid = [self gx_generateUUID];
            [defaults setObject:uuid forKey:BFUniqueIdentifierDefaultsKey];
            [defaults synchronize];
        }
    }
    return uuid;
}


#pragma mark - Private
+ (NSUInteger)gx_getSysInfo:(uint)typeSpecifier {
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

+ (NSString *)gx_generateUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}


/** 获取设备ip地址*/
+ (NSString *)gx_getDeviceIpAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}



//uname系统调用:获取当前内核名称和其它信息  参数__name：指向存放系统信息的缓冲区
-(NSString *)gx_deviceName{
    struct utsname u;
    uname(&u);
    return  [NSString stringWithCString:u.machine encoding:NSUTF8StringEncoding];
}

-(NSString *)gx_sysnameName{
    struct utsname u;
    uname(&u);
    return [NSString stringWithCString:u.sysname encoding:NSUTF8StringEncoding];
}

-(NSString *)gx_nodenameName{
    struct utsname u;
    uname(&u);
    return [NSString stringWithCString:u.nodename encoding:NSUTF8StringEncoding];
}

-(NSString *)gx_releaseName{
    struct utsname u;
    uname(&u);
    return [NSString stringWithCString:u.release encoding:NSUTF8StringEncoding];
}

-(NSString *)gx_versionName{
    struct utsname u;
    uname(&u);
    return [NSString stringWithCString:u.version encoding:NSUTF8StringEncoding];
}
@end
