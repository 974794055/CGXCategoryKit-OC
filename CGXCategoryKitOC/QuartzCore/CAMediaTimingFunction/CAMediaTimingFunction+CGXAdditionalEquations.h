//
//  CAMediaTimingFunction+CGXAdditionalEquations.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAMediaTimingFunction (CGXAdditionalEquations)


///---------------------------------------------------------------------------------------
/// @name Circ Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)gx_easeInCirc;
+(CAMediaTimingFunction *)gx_easeOutCirc;
+(CAMediaTimingFunction *)gx_easeInOutCirc;

///---------------------------------------------------------------------------------------
/// @name Cubic Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)gx_easeInCubic;
+(CAMediaTimingFunction *)gx_easeOutCubic;
+(CAMediaTimingFunction *)gx_easeInOutCubic;

///---------------------------------------------------------------------------------------
/// @name Expo Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)gx_easeInExpo;
+(CAMediaTimingFunction *)gx_easeOutExpo;
+(CAMediaTimingFunction *)gx_easeInOutExpo;

///---------------------------------------------------------------------------------------
/// @name Quad Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)gx_easeInQuad;
+(CAMediaTimingFunction *)gx_easeOutQuad;
+(CAMediaTimingFunction *)gx_easeInOutQuad;

///---------------------------------------------------------------------------------------
/// @name Quart Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)gx_easeInQuart;
+(CAMediaTimingFunction *)gx_easeOutQuart;
+(CAMediaTimingFunction *)gx_easeInOutQuart;

///---------------------------------------------------------------------------------------
/// @name Quint Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)gx_easeInQuint;
+(CAMediaTimingFunction *)gx_easeOutQuint;
+(CAMediaTimingFunction *)gx_easeInOutQuint;

///---------------------------------------------------------------------------------------
/// @name Sine Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)gx_easeInSine;
+(CAMediaTimingFunction *)gx_easeOutSine;
+(CAMediaTimingFunction *)gx_easeInOutSine;

///---------------------------------------------------------------------------------------
/// @name Back Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)gx_easeInBack;
+(CAMediaTimingFunction *)gx_easeOutBack;
+(CAMediaTimingFunction *)gx_easeInOutBack;

@end
