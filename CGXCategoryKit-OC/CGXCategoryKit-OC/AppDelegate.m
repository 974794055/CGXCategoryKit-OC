//
//  AppDelegate.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSArray *arr1 = [[NSArray alloc] init];
    NSArray *arr4 = [[NSArray alloc] initWithObjects:@0, @1, @2, nil];
    NSLog(@"arr1: %s --%@", object_getClassName(arr1),arr1[1]);
    NSLog(@"arr4: %s --%@", object_getClassName(arr4),arr4[3]);

    NSMutableArray *mArr1 = [[NSMutableArray alloc] init];
    NSMutableArray *mArr3 = [[NSMutableArray alloc] initWithObjects:@0, @1, nil];
    NSLog(@"mArr1: %s --%@", object_getClassName(mArr1),mArr1[1]);
    NSLog(@"mArr3: %s --%@---%@", object_getClassName(mArr3),mArr3[3],[mArr3 objectAtIndexedSubscript:3]);
    

    return YES;
}

@end
