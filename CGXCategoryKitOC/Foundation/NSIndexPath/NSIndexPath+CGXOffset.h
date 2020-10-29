//
//  NSIndexPath+CGXOffset.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface NSIndexPath (CGXOffset)
/**

 *
 *  Compute previous row indexpath
 *
 */
- (NSIndexPath *)gx_previousRow;
/**

 *
 *  Compute next row indexpath
 *
 */
- (NSIndexPath *)gx_nextRow;
/**

 *
 *  Compute previous item indexpath
 *
 */
- (NSIndexPath *)gx_previousItem;
/**

 *
 *  Compute next item indexpath
 *
 */
- (NSIndexPath *)gx_nextItem;
/**

 *
 *  Compute next section indexpath
 *
 */
- (NSIndexPath *)gx_nextSection;
/**

 *
 *  Compute previous section indexpath
 *
 */
- (NSIndexPath *)gx_previousSection;

@end
