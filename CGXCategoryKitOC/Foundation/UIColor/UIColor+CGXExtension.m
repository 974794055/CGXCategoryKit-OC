//
//  UIColor+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIColor+CGXExtension.h"

@implementation NSString (CGXColorPadding)

- (NSString *)gx_stringByPaddingTheLeftToLength:(NSUInteger) newLength withString:(NSString *) padString startingAtIndex:(NSUInteger) padIndex
{
    if ([self length] <= newLength)
        return [[@"" stringByPaddingToLength:newLength - [self length] withString:padString startingAtIndex:padIndex] stringByAppendingString:self];
    else
        return [self copy];
}

@end

@implementation UIColor (CGXExtension)


//默认alpha值为1
+ (UIColor *)gx_colorWithHexString:(NSString *)color {
    return [self gx_colorWithHexString:color alpha:1.0f];
}
+ (UIColor *)gx_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    if (!color) {
        return [UIColor clearColor];
    }
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }

    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (UIColor *)gx_colorWithHex:(long)hex
{
    return [UIColor gx_colorWithHex:hex alpha:1];
}
+ (UIColor *)gx_colorWithHex:(long)hex alpha:(CGFloat)alpha {
    CGFloat red, green, blue;
    
    red = ((CGFloat)((hex >> 16) & 0xFF)) / ((CGFloat)0xFF);
    green = ((CGFloat)((hex >> 8) & 0xFF)) / ((CGFloat)0xFF);
    blue = ((CGFloat)((hex >> 0) & 0xFF)) / ((CGFloat)0xFF);
    
    return [UIColor colorWithRed: red green:green blue:blue alpha:alpha];
}

+ (UIColor*)gx_colorWithCSS:(NSString*)css {
    if (css.length == 0)
        return [UIColor blackColor];
    
    if ([css characterAtIndex:0] == '#')
        css = [css substringFromIndex:1];
    
    NSString *a, *r, *g, *b;
    
    NSUInteger len = css.length;
    if (len == 6) {
    six:
        a = @"FF";
        r = [css substringWithRange:NSMakeRange(0, 2)];
        g = [css substringWithRange:NSMakeRange(2, 2)];
        b = [css substringWithRange:NSMakeRange(4, 2)];
    }
    else if (len == 8) {
    eight:
        a = [css substringWithRange:NSMakeRange(0, 2)];
        r = [css substringWithRange:NSMakeRange(2, 2)];
        g = [css substringWithRange:NSMakeRange(4, 2)];
        b = [css substringWithRange:NSMakeRange(6, 2)];
    }
    else if (len == 3) {
    three:
        a = @"FF";
        r = [css substringWithRange:NSMakeRange(0, 1)];
        r = [r stringByAppendingString:a];
        g = [css substringWithRange:NSMakeRange(1, 1)];
        g = [g stringByAppendingString:a];
        b = [css substringWithRange:NSMakeRange(2, 1)];
        b = [b stringByAppendingString:a];
    }
    else if (len == 4) {
        a = [css substringWithRange:NSMakeRange(0, 1)];
        a = [a stringByAppendingString:a];
        r = [css substringWithRange:NSMakeRange(1, 1)];
        r = [r stringByAppendingString:a];
        g = [css substringWithRange:NSMakeRange(2, 1)];
        g = [g stringByAppendingString:a];
        b = [css substringWithRange:NSMakeRange(3, 1)];
        b = [b stringByAppendingString:a];
    }
    else if (len == 5 || len == 7) {
        css = [@"0" stringByAppendingString:css];
        if (len == 5) goto six;
        goto eight;
    }
    else if (len < 3) {
        css = [css gx_stringByPaddingTheLeftToLength:3 withString:@"0" startingAtIndex:0];
        goto three;
    }
    else if (len > 8) {
        css = [css substringFromIndex:len-8];
        goto eight;
    }
    else {
        a = @"FF";
        r = @"00";
        g = @"00";
        b = @"00";
    }
    
    // parse each component separately. This gives more accurate results than
    // throwing it all together in one string and use scanf on the global string.
    a = [@"0x" stringByAppendingString:a];
    r = [@"0x" stringByAppendingString:r];
    g = [@"0x" stringByAppendingString:g];
    b = [@"0x" stringByAppendingString:b];
    
    uint av, rv, gv, bv;
    sscanf([a cStringUsingEncoding:NSASCIIStringEncoding], "%x", &av);
    sscanf([r cStringUsingEncoding:NSASCIIStringEncoding], "%x", &rv);
    sscanf([g cStringUsingEncoding:NSASCIIStringEncoding], "%x", &gv);
    sscanf([b cStringUsingEncoding:NSASCIIStringEncoding], "%x", &bv);
    
    return [UIColor colorWithRed: rv / 255.f
                           green: gv / 255.f
                            blue: bv / 255.f
                           alpha: av / 255.f];
}
+ (UIColor *)gx_randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}



+ (UIColor *)gx_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}
@end
