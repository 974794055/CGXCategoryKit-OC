//
//  NSNull+CGXSafe.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSNull+CGXSafe.h"

@implementation NSNull (CGXSafe)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    //look up method signature
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (!signature)
    {
        for (Class someClass in @[
                                  [NSMutableArray class],
                                  [NSMutableDictionary class],
                                  [NSMutableString class],
                                  [NSNumber class],
                                  [NSDate class],
                                  [NSData class]
                                  ])
        {
            @try
            {
                if ([someClass instancesRespondToSelector:selector])
                {
                    signature = [someClass instanceMethodSignatureForSelector:selector];
                    break;
                }
            }
            @catch (__unused NSException *unused) {}
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    // 消息转发对象设为空，就不会抛出异常
    invocation.target = nil;
    [invocation invoke];
}

@end
