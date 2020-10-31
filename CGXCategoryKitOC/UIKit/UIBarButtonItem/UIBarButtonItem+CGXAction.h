//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CGXBarButtonItemActionBlock)(void);

@interface UIBarButtonItem (CGXAction)

/*
 点击 事件
 */
- (void)gx_clickActionBlock:(CGXBarButtonItemActionBlock)actionBlock;

@end
