//
//  NSBundle+CGXAppIcon.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSBundle (CGXAppIcon)
- (NSString*)gx_appIconPath;
- (UIImage*)gx_appIcon;
@end
