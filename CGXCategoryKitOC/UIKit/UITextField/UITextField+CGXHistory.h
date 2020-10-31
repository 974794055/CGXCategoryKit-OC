//
//  UITextField+CGXHistory.h
//  CGXAppStructure
//
//  Created by CGX on 2018/12/14.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CGXHistory)

/**
 *  identity of this textfield
 */
@property (retain, nonatomic) NSString *gx_identify;

/**
 *  load textfiled input history
 *
 *
 *  @return the history of it's input
 */
- (NSArray*)gx_loadHistroy;

/**
 *  save current input text
 */
- (void)gx_synchronize;

- (void)gx_showHistory;

- (void)gx_hideHistroy;

- (void)gx_clearHistory;

@end
