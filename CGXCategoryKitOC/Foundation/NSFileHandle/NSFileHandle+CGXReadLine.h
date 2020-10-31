//
//  NSFileHandle+CGXReadLine.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileHandle (CGXReadLine)
/**
 *  @brief   A Cocoa / Objective-C NSFileHandle category that adds the ability to read a file line by line.

 *
 *  @param theDelimier 分隔符
 *
 *  @return An NSData* object is returned with the line if found, or nil if no more lines were found
 */
- (NSData *)gx_readLineWithDelimiter:(NSString *)theDelimier;

@end
