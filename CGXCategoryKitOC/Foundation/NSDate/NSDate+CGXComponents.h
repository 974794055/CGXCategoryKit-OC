//
//  NSDate+CGXComponents.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CGXComponents)
- (NSDateComponents *)gx_dateComponentsTime;
- (NSDateComponents *)gx_dateComponentsDate;
- (NSDateComponents *)gx_dateComponentsWeek;
- (NSDateComponents *)gx_dateComponentsWeekday;
- (NSDateComponents *)gx_dateComponentsDateTime;
- (NSDateComponents *)gx_dateComponentsWeekTime;

- (NSDateComponents *)gx_components;
- (NSDateComponents *)gx_obtainCurrentDate;
@end

NS_ASSUME_NONNULL_END
