//
//  UIButton+CGXIndicator.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CGXIndicator)
/**
 This method will show the activity indicator in place of the button text.
 */
- (void)gx_showIndicator;
/**
 This method will remove the indicator and put thebutton text back in place.
 */
- (void)gx_hideIndicator;
@end

NS_ASSUME_NONNULL_END
