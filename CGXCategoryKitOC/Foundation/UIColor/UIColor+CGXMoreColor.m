//
//  UIColor+CGXMoreColor.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIColor+CGXMoreColor.h"

#define GXRGB16Color(rgbValue) [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (CGXMoreColor)

#pragma mark - **************** 红色系
/** 薄雾玫瑰*/
+ (UIColor *)gx_mMistyRose {
    return GXRGB16Color(0xFFE4E1);
}
/** 浅鲑鱼色*/
+ (UIColor *)gx_mLightSalmon {
    return GXRGB16Color(0xFFA07A);
}
/** 淡珊瑚色*/
+ (UIColor *)gx_mLightCoral {
    return GXRGB16Color(0xF08080);
}
/** 鲑鱼色*/
+ (UIColor *)gx_mSalmonColor {
    return GXRGB16Color(0xFA8072);
}
/** 珊瑚色*/
+ (UIColor *)gx_mCoralColor {
    return GXRGB16Color(0xFF7F50);
}
/** 番茄*/
+ (UIColor *)gx_mTomatoColor {
    return GXRGB16Color(0xFF6347);
}
/** 橙红色*/
+ (UIColor *)gx_mOrangeRed {
    return GXRGB16Color(0xFF4500);
}
/** 印度红*/
+ (UIColor *)gx_mIndianRed {
    return GXRGB16Color(0xCD5C5C);
}
/** 猩红*/
+ (UIColor *)gx_mCrimsonColor {
    return GXRGB16Color(0xDC143C);
}
/** 耐火砖*/
+ (UIColor *)gx_mFireBrick {
    return GXRGB16Color(0xB22222);
}

#pragma mark - **************** 黄色系
/** 玉米色*/
+ (UIColor *)gx_mCornColor {
    return GXRGB16Color(0xFFF8DC);
}
/** 柠檬薄纱*/
+ (UIColor *)gx_mLemonChiffon {
    return GXRGB16Color(0xFFFACD);
}
/** 苍金麒麟*/
+ (UIColor *)gx_mPaleGodenrod {
    return GXRGB16Color(0xEEE8AA);
}
/** 卡其色*/
+ (UIColor *)gx_mKhakiColor {
    return GXRGB16Color(0xF0E68C);
}
/** 金色*/
+ (UIColor *)gx_mGoldColor {
    return GXRGB16Color(0xFFD700);
}
/** 雌黄*/
+ (UIColor *)gx_mOrpimentColor {
    return GXRGB16Color(0xFFC64B);
}
/** 藤黄*/
+ (UIColor *)gx_mGambogeColor {
    return GXRGB16Color(0xFFB61E);
}
/** 雄黄*/
+ (UIColor *)gx_mRealgarColor {
    return GXRGB16Color(0xE9BB1D);
}
/** 金麒麟色*/
+ (UIColor *)gx_mGoldenrod {
    return GXRGB16Color(0xDAA520);
}
/** 乌金*/
+ (UIColor *)gx_mDarkGold {
    return GXRGB16Color(0xA78E44);
}

#pragma mark - **************** 绿色系
/** 苍绿*/
+ (UIColor *)gx_mPaleGreen {
    return GXRGB16Color(0x98FB98);
}
/** 淡绿色*/
+ (UIColor *)gx_mLightGreen {
    return GXRGB16Color(0x90EE90);
}
/** 春绿*/
+ (UIColor *)gx_mSpringGreen {
    return GXRGB16Color(0x2AFD84);
}
/** 绿黄色*/
+ (UIColor *)gx_mGreenYellow {
    return GXRGB16Color(0xADFF2F);
}
/** 草坪绿*/
+ (UIColor *)gx_mLawnGreen {
    return GXRGB16Color(0x7CFC00);
}
/** 酸橙绿*/
+ (UIColor *)gx_mLimeColor {
    return GXRGB16Color(0x00FF00);
}
/** 森林绿*/
+ (UIColor *)gx_mForestGreen {
    return GXRGB16Color(0x228B22);
}
/** 海洋绿*/
+ (UIColor *)gx_mSeaGreen {
    return GXRGB16Color(0x2E8B57);
}
/** 深绿*/
+ (UIColor *)gx_mDarkGreen {
    return GXRGB16Color(0x006400);
}
/** 橄榄(墨绿)*/
+ (UIColor *)gx_mOlive  {
    return GXRGB16Color(0x556B2F);
}

#pragma mark - **************** 青色系
/** 淡青色*/
+ (UIColor *)gx_mLightCyan {
    return GXRGB16Color(0xE1FFFF);
}
/** 苍白绿松石*/
+ (UIColor *)gx_mPaleTurquoise {
    return GXRGB16Color(0xAFEEEE);
}
/** 绿碧*/
+ (UIColor *)gx_mAquamarine {
    return GXRGB16Color(0x7FFFD4);
}
/** 绿松石*/
+ (UIColor *)gx_mTurquoise {
    return GXRGB16Color(0x40E0D0);
}
/** 适中绿松石*/
+ (UIColor *)gx_mMediumTurquoise {
    return GXRGB16Color(0x48D1CC);
}
/** 美团色*/
+ (UIColor *)gx_mMeituanColor {
    return GXRGB16Color(0x2BB8AA);
}
/** 浅海洋绿*/
+ (UIColor *)gx_mLightSeaGreen {
    return GXRGB16Color(0x20B2AA);
}
/** 深青色*/
+ (UIColor *)gx_mDarkCyan {
    return GXRGB16Color(0x008B8B);
}
/** 水鸭色*/
+ (UIColor *)gx_mTealColor {
    return GXRGB16Color(0x008080);
}
/** 深石板灰*/
+ (UIColor *)gx_mDarkSlateGray {
    return GXRGB16Color(0x2F4F4F);
}

#pragma mark - **************** 蓝色系
/** 天蓝色*/
+ (UIColor *)gx_mSkyBlue {
    return GXRGB16Color(0xE1FFFF);
}
/** 淡蓝*/
+ (UIColor *)gx_mLightBLue {
    return GXRGB16Color(0xADD8E6);
}
/** 深天蓝*/
+ (UIColor *)gx_mDeepSkyBlue {
    return GXRGB16Color(0x00BFFF);
}
/** 道奇蓝*/
+ (UIColor *)gx_mDoderBlue {
    return GXRGB16Color(0x1E90FF);
}
/** 矢车菊*/
+ (UIColor *)gx_mCornflowerBlue {
    return GXRGB16Color(0x6495ED);
}
/** 皇家蓝*/
+ (UIColor *)gx_mRoyalBlue {
    return GXRGB16Color(0x4169E1);
}
/** 适中的蓝色*/
+ (UIColor *)gx_mMediumBlue {
    return GXRGB16Color(0x0000CD);
}
/** 深蓝*/
+ (UIColor *)gx_mDarkBlue {
    return GXRGB16Color(0x00008B);
}
/** 海军蓝*/
+ (UIColor *)gx_mNavyColor {
    return GXRGB16Color(0x000080);
}
/** 午夜蓝*/
+ (UIColor *)gx_mMidnightBlue {
    return GXRGB16Color(0x191970);
}

#pragma mark - **************** 紫色系
/** 薰衣草*/
+ (UIColor *)gx_mLavender {
    return GXRGB16Color(0xE6E6FA);
}
/** 蓟*/
+ (UIColor *)gx_mThistleColor {
    return GXRGB16Color(0xD8BFD8);
}
/** 李子*/
+ (UIColor *)gx_mPlumColor {
    return GXRGB16Color(0xDDA0DD);
}
/** 紫罗兰*/
+ (UIColor *)gx_mVioletColor {
    return GXRGB16Color(0xEE82EE);
}
/** 适中的兰花紫*/
+ (UIColor *)gx_mMediumOrchid {
    return GXRGB16Color(0xBA55D3);
}
/** 深兰花紫*/
+ (UIColor *)gx_mDarkOrchid {
    return GXRGB16Color(0x9932CC);
}
/** 深紫罗兰色*/
+ (UIColor *)gx_mDarkVoilet {
    return GXRGB16Color(0x9400D3);
}
/** 泛蓝紫罗兰*/
+ (UIColor *)gx_mBlueViolet {
    return GXRGB16Color(0x8A2BE2);
}
/** 深洋红色*/
+ (UIColor *)gx_mDarkMagenta {
    return GXRGB16Color(0x8B008B);
}
/** 靛青*/
+ (UIColor *)gx_mIndigoColor {
    return GXRGB16Color(0x4B0082);
}

#pragma mark - **************** 灰色系
/** 白烟*/
+ (UIColor *)gx_mWhiteSmoke {
    return GXRGB16Color(0xF5F5F5);
}
/** 鸭蛋*/
+ (UIColor *)gx_mDuckEgg {
    return GXRGB16Color(0xE0EEE8);
}
/** 亮灰*/
+ (UIColor *)gx_mGainsboroColor {
    return GXRGB16Color(0xDCDCDC);
}
/** 蟹壳青*/
+ (UIColor *)gx_mCarapaceColor {
    return GXRGB16Color(0xBBCDC5);
}
/** 银白色*/
+ (UIColor *)gx_mSilverColor {
    return GXRGB16Color(0xC0C0C0);
}
/** 暗淡的灰色*/
+ (UIColor *)gx_mDimGray {
    return GXRGB16Color(0x696969);
}

#pragma mark - **************** 白色系
/** 海贝壳*/
+ (UIColor *)gx_mSeaShell {
    return GXRGB16Color(0xFFF5EE);
}
/** 雪*/
+ (UIColor *)gx_mSnowColor {
    return GXRGB16Color(0xFFFAFA);
}
/** 亚麻色*/
+ (UIColor *)gx_mLinenColor {
    return GXRGB16Color(0xFAF0E6);
}
/** 花之白*/
+ (UIColor *)gx_mFloralWhite {
    return GXRGB16Color(0xFFFAF0);
}
/** 老饰带*/
+ (UIColor *)gx_mOldLace {
    return GXRGB16Color(0xFDF5E6);
}
/** 象牙白*/
+ (UIColor *)gx_mIvoryColor {
    return GXRGB16Color(0xFFFFF0);
}
/** 蜂蜜露*/
+ (UIColor *)gx_mHoneydew {
    return GXRGB16Color(0xF0FFF0);
}
/** 薄荷奶油*/
+ (UIColor *)gx_mMintCream {
    return GXRGB16Color(0xF5FFFA);
}
/** 蔚蓝色*/
+ (UIColor *)gx_mAzureColor {
    return GXRGB16Color(0xF0FFFF);
}
/** 爱丽丝蓝*/
+ (UIColor *)gx_mAliceBlue {
    return GXRGB16Color(0xF0F8FF);
}
/** 幽灵白*/
+ (UIColor *)gx_mGhostWhite {
    return GXRGB16Color(0xF8F8FF);
}
/** 淡紫红*/
+ (UIColor *)gx_mLavenderBlush {
    return GXRGB16Color(0xFFF0F5);
}
/** 米色*/
+ (UIColor *)gx_mBeigeColor {
    return GXRGB16Color(0xF5F5DD);
}

#pragma mark - **************** 棕色系
/** 黄褐色*/
+ (UIColor *)gx_mTanColor {
    return GXRGB16Color(0xD2B48C);
}
/** 玫瑰棕色*/
+ (UIColor *)gx_mRosyBrown {
    return GXRGB16Color(0xBC8F8F);
}
/** 秘鲁*/
+ (UIColor *)gx_mPeruColor {
    return GXRGB16Color(0xCD853F);
}
/** 巧克力*/
+ (UIColor *)gx_mChocolateColor {
    return GXRGB16Color(0xD2691E);
}
/** 古铜色*/
+ (UIColor *)gx_mBronzeColor { // $$$$$
    return GXRGB16Color(0xB87333);
}
/** 黄土赭色*/
+ (UIColor *)gx_mSiennaColor {
    return GXRGB16Color(0xA0522D);
}
/** 马鞍棕色*/
+ (UIColor *)gx_mSaddleBrown {
    return GXRGB16Color(0x8B4513);
}
/** 土棕*/
+ (UIColor *)gx_mSoilColor {
    return GXRGB16Color(0x734A12);
}
/** 栗色*/
+ (UIColor *)gx_mMaroonColor {
    return GXRGB16Color(0x800000);
}
/** 乌贼墨棕*/
+ (UIColor *)gx_mInkfishBrown {
    return GXRGB16Color(0x5E2612);
}

#pragma mark - **************** 粉色系
/** 水粉*/
+ (UIColor *)gx_mWaterPink { // $$$$$
    return GXRGB16Color(0xF3D3E7);
    
}
/** 藕色*/
+ (UIColor *)gx_mLotusRoot { // $$$$$
    return GXRGB16Color(0xEDD1D8);
}
/** 浅粉红*/
+ (UIColor *)gx_mLightPink {
    return GXRGB16Color(0xFFB6C1);
}
/** 适中的粉红*/
+ (UIColor *)gx_mMediumPink {
    return GXRGB16Color(0xFFC0CB);
}
/** 桃红*/
+ (UIColor *)gx_mPeachRed { // $$$$$
    return GXRGB16Color(0xF47983);
}
/** 苍白的紫罗兰红色*/
+ (UIColor *)gx_mPaleVioletRed {
    return GXRGB16Color(0xDB7093);
}
/** 深粉色*/
+ (UIColor *)gx_mDeepPink {
    return GXRGB16Color(0xFF1493);
}

@end
