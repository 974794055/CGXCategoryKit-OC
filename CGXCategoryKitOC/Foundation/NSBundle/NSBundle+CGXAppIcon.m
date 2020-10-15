//
//  NSBundle+CGXAppIcon.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "NSBundle+CGXAppIcon.h"

@implementation NSBundle (CGXAppIcon)
- (NSString*)gx_appIconPath
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //获取app中所有icon名字数组
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    //取最后一个icon的名字
    NSString *iconLastName = [iconsArr lastObject];
    //打印icon名字
//    NSLog(@"iconsArr: %@", iconsArr);
//    NSLog(@"iconLastName: %@", iconLastName);
    /*
     打印日志：
     iconsArr: (
     AppIcon29x29,
     AppIcon40x40,
     AppIcon60x60
     )
     iconLastName: AppIcon60x60
     */
    return iconLastName;
}


- (UIImage*)gx_appIcon
{
    UIImage*appIcon = [UIImage imageNamed:[self gx_appIconPath]];
    return appIcon;
}
@end
