//
//  CLLocation+CGXCalculation.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLLocation (CGXCalculation)

/// 两个坐标间的距离，单位 米
/// @param latOne one维度
/// @param lonOne one经度
/// @param latAnother Another维度
/// @param lonAnother Another经度
+ (double)gx_getDistanceWithLat1:(double)latOne lon1:(double)lonOne withLat2:(double)latAnother lon2:(double)lonAnother;

/// 两个坐标间的距离，单位 米
/// @param oneLocation 第一个坐标
/// @param anotherLocation 另一个坐标
+ (double)gx_getDistance:(CLLocationCoordinate2D)oneLocation withAnotherLocation:(CLLocationCoordinate2D)anotherLocation;

@end

NS_ASSUME_NONNULL_END
