//
//  CGXCategoryKitOC.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

/*
 下载链接：https://github.com/974794055/CGXCategoryKit-OC.git
 QQ号：974794055
 群名称：
 群   号：
 版本： 0.0.3
 */

#ifndef CGXCategoryKitOC_h
#define CGXCategoryKitOC_h

//// ****  UIControl   **** /
#import "UIControl+CGXClicks.h"
#import "UIControl+CGXSound.h"
#import "UIControl+CGXActionBlocks.h"

//// ****  UIWindow   **** /
#import "UIWindow+CGXHierarchy.h"
//// ****  WKWebView   **** /
#import "WKWebView+CGXExtension.h"

//// ****  NSTimer   **** /
#import "NSTimer+CGXExtension.h"
//// ****  NSNotificationCenter   **** /
#import "NSNotificationCenter+CGXMainThread.h"
//// ****  NSBundle   **** /
#import "NSBundle+CGXAppIcon.h"

// ****  UIColor   **** /
#import "UIColor+CGXExtension.h"
#import "UIColor+CGXGradient.h"
#import "UIColor+CGXWeb.h"
#import "UIColor+CGXLightDark.h"

// ****  CALayer   **** /
#import "CALayer+CGXExtension.h"

// ****  UIDevice   **** /
#import "UIDevice+CGXExtension.h"

// ****  NSFileManager   **** /
#import "NSFileManager+CGXExtension.h"
#import "NSFileManager+CGXData.h"
#import "NSFileManager+CGXFilePath.h"
#import "NSFileManager+CGXVerification.h"

// ****  NSURL   **** /
#import "NSURL+CGXParam.h"
#import "NSURL+CGXQueryDictionary.h"

// ****  UIFont   **** /
#import "UIFont+CGXDynamicFontControl.h"
#import "UIFont+CGXCustomLoader.h"
#import "UIFont+CGXTTF.h"

// ****  NSUserDefaults   **** /
#import "NSUserDefaults+CGXExtension.h"
#import "NSUserDefaults+CGXSafeAccess.h"

// ****  NSObject   **** /
//#import "NSObject+CGXMainRuntime.h"
#import "NSObject+CGXModelParse.h"
#import "NSObject+CGXExtension.h"
#import "NSObject+CGXObject.h"
//#import "NSObject+CGXRuntime.h"
#import "NSObject+CGXGCD.h"
#import "NSObject+CGXKVOBlocks.h"
#import "NSObject+CGXEasyCopy.h"
#import "NSObject+CGXAddProperty.h"
#import "NSObject+CGXAssociatedObject.h"
#import "NSObject+CGXSafe.h"

// ****  UIImage   **** /
#import "UIImage+CGXColor.h"
#import "UIImage+CGXAlpha.h"
#import "UIImage+CGXFileName.h"
#import "UIImage+CGXCapture.h"
#import "UIImage+CGXMerge.h"
#import "UIImage+CGXExtension.h"
#import "UIImage+CGXUserAvatar.h"
#import "UIImage+CGXRemoteSize.h"
#import "UIImage+CGXOrientation.h"
#import "UIImage+CGXAnimatedGIF.h"
#import "UIImage+CGXVector.h"
#import "UIImage+CGXCompress.h"

// ****  NSString   **** /
#import "NSString+CGX.h"
#import "NSString+CGXExtension.h"
#import "NSString+CGXSize.h"
#import "NSString+CGXRegex.h"
#import "NSString+CGXCrypto.h"
#import "NSString+CGXSecurity.h"
#import "NSString+CGXURLEncode.h"
#import "NSString+CGXMIME.h"
#import "NSString+CGXTrims.h"
#import "NSString+CGXScore.h"
#import "NSString+CGXUUID.h"
#import "NSString+CGXMD5.h"

// ****  NSMutableAttributedString   **** /
#import "NSMutableAttributedString+CGX.h"
#import "NSMutableAttributedString+CGXExtension.h"

// ****  NSIndexPath   **** /
#import "NSIndexPath+CGXOffset.h"

// ****  NSRunLoop   **** /
#import "NSRunLoop+CGXPerformBlock.h"

// ****  CLLocation   **** /
#import "CLLocation+CGXCH1903.h"
#import "CLLocation+CGXConverter.h"
#import "CLLocation+CGXCalculation.h"

// ****  CLLocation   **** /
#import "CATransaction+CGXAnimate.h"

#import "CAShapeLayer+CGXBezierPath.h"

#import "CAMediaTimingFunction+CGXAdditionalEquations.h"



#import "NSHTTPCookieStorage+CGXFreezeDry.h"
#import "NSFileHandle+CGXReadLine.h"
#import "NSException+CGXTrace.h"


// ****  NSDictionary   **** /
#import "NSDictionary+CGXMerge.h"
#import "NSDictionary+CGXExtension.h"
#import "NSDictionary+CGXURL.h"
#import "NSMutableDictionary+CGXExtension.h"
#import "NSDictionary+CGXSafe.h"
#import "NSMutableDictionary+CGXSafe.h"

//****  NSArray   **** /
#import "NSArray+CGXExtension.h"
#import "NSArray+CGXAdditional.h"
#import "NSMutableArray+CGXAdditional.h"
#import "NSMutableArray+CGXSort.h"
#import "NSArray+CGXSafe.h"
#import "NSMutableArray+CGXSafe.h"

// ****  NSData   **** /

#import "NSData+CGXAPNSToken.h"
#import "NSData+CGXBase64.h"
#import "NSData+CGXDataCache.h"
#import "NSData+CGXEncrypt.h"
#import "NSData+CGXGzip.h"
#import "NSData+CGXExtension.h"
#import "NSData+CGXRSA.h"



// ****  NSNumber   **** /
#import "NSNumber+CGXRound.h"

// ****  NSDecimalNumber   **** /
#import "NSDecimalNumber+CGXExtensions.h"


//*  NSDate   **** /
#import "NSDate+CGX.h"
#import "NSDate+CGXTime.h"
#import "NSDate+CGXDay.h"
#import "NSDate+CGXYear.h"
#import "NSDate+CGXMonth.h"
#import "NSDate+CGXWeek.h"
#import "NSDate+CGXCompare.h"
#import "NSDate+CGXExtension.h"
#import "NSDate+CGXComponents.h"
#import "NSDate+CGXTransTime.h"
#import "NSDate+CGXLunarCalendar.h"
#import "CGXCategoryDateFormatterPool.h"
#import "NSCalendar+CGXExtension.h"

#import "NSNull+CGXSafe.h"

#endif /* CGXCategoryKitOC_h */

