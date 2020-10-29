//
//  CLLocation+CGXCalculation.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "CLLocation+CGXCalculation.h"

@implementation CLLocation (CGXCalculation)

+ (double)gx_getDistanceWithLat1:(double)latOne lon1:(double)lonOne withLat2:(double)latAnother lon2:(double)lonAnother
{
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:latOne longitude:lonOne];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:latAnother longitude:lonAnother];
    CLLocationDistance kilometers = [orig distanceFromLocation:dist];
    return kilometers;
}

+ (double)gx_getDistance:(CLLocationCoordinate2D)oneLocation withAnotherLocation:(CLLocationCoordinate2D)anotherLocation
{
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:oneLocation.latitude longitude:oneLocation.longitude];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:anotherLocation.latitude longitude:anotherLocation.longitude];
    CLLocationDistance kilometers = [orig distanceFromLocation:dist];
    return kilometers;
}

@end
