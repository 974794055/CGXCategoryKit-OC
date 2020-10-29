//
//  NSNotificationCenter+CGXMainThread.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSNotificationCenter+CGXMainThread.h"
#include <pthread.h>
@implementation NSNotificationCenter (CGXMainThread)



- (void)gx_postNotificationOnMainThread:(NSNotification *)notification
{
    if (pthread_main_np())
    return [self postNotification:notification];
    [self gx_postNotificationOnMainThread:notification waitUntilDone:NO];
}
- (void)gx_postNotificationOnMainThread:(NSNotification *)notification
                          waitUntilDone:(BOOL)wait
{
    if (pthread_main_np())
        return [self postNotification:notification];
    [[self class] performSelectorOnMainThread:@selector(gx_postNotification:) withObject:notification waitUntilDone:wait];
}
- (void)gx_postNotificationOnMainThreadWithName:(NSString *)name
                                         object:(id)object
                                       userInfo:(NSDictionary *)userInfo
                                  waitUntilDone:(BOOL)wait
{
    if (pthread_main_np())
    return [self postNotificationName:name object:object userInfo:userInfo];
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) [info setObject:name forKey:@"name"];
    if (object) [info setObject:object forKey:@"object"];
    if (userInfo) [info setObject:userInfo forKey:@"userInfo"];
    [[self class] performSelectorOnMainThread:@selector(gx_postNotificationName:) withObject:info waitUntilDone:wait];
}

- (void)gx_postNotificationOnMainThreadWithName:(NSString *)name
                                         object:(id)object
                                       userInfo:(NSDictionary *)userInfo
{
    if (pthread_main_np())
    return [self postNotificationName:name object:object userInfo:userInfo];
    [self gx_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void)gx_postNotificationOnMainThreadWithName:(NSString *)name
                                         object:(id)object
{
    if (pthread_main_np())
    return [self postNotificationName:name object:object userInfo:nil];
    [self gx_postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

#pragma mark - private
+ (void)gx_postNotification:(NSNotification *)notification
{
    [[self defaultCenter] postNotification:notification];
}

+ (void)gx_postNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

@end
