//
//  CLLocation+CGXCH1903.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CLLocation (CGXCH1903)

/*!
 @method     initWithCH1903x
 @abstract   initialize a CLLocation-Instance with CH1903 x/y coorinates
 */
- (id)initWithCH1903x:(double)x y:(double)y;
/*!
 @method     CH1903Y
 @abstract   returns the CH1903 y value of the location
 */
- (double)gx_CH1903Y;
/*!
 @method     CH1903X
 @abstract   returns the CH1903 x value of the location
 */
- (double)gx_CH1903X;

+ (double)gx_CHtoWGSlatWithX:(double)x y:(double)y;
+ (double)gx_CHtoWGSlongWithX:(double)x y:(double)y;
+ (double)gx_WGStoCHyWithLatitude:(double)lat longitude:(double)lng;
+ (double)gx_WGStoCHxWithLatitude:(double)lat longitude:(double)lng;

+ (double)gx_decToSex:(double)angle;
+ (double)gx_degToSec:(double)angle;
+ (double)gx_sexToDec:(double)angle;


@end
