//
//  NSException+CGXTrace.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSException (CGXTrace)
- (NSArray *)gx_backtrace;
@end
