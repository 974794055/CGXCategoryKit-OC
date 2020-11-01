//
//  NSString+CGXTrims.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "NSString+CGXTrims.h"

@implementation NSString (CGXTrims)
/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)gx_stringByStrippingHTML {
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}
/**
 *  @brief  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)gx_stringByRemovingScriptsAndStrippingHTML {
    NSMutableString *mString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString gx_stringByStrippingHTML];
}
/**
 *  @brief  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)gx_trimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
/**
 *  @brief  去除字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (NSString *)gx_trimmingWhitespaceAndNewlines
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/** 去除字符串两端的空格 */
+ (NSString *)gx_trimmingWipeBothEndsSpaceFromStr:(NSString *)str {
    NSString *s = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//该方法是去掉两端的空格
    return s;
}


/** 去除字符串中的特定符号 */
+ (NSString *)gx_wipeAppointSymbolFromStr:(NSString *)str AppointSymbol:(NSString *)appointSymbol WithStr:(NSString *)replacement
{    
    NSString *b = [str stringByReplacingOccurrencesOfString:appointSymbol withString:replacement];//该方法是去掉指定符号
    return b;
}
//将 &lt 等类似的字符转化为HTML中的“<”等
+ (NSString *)gx_htmlEntityDecode:(NSString *)string {
    
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

+ (NSString *)gx_changeHTMLText:(NSString *)bbsContent {
    
    NSRange range = [bbsContent rangeOfString:@"font-size:"];
    if (range.location == NSNotFound) {
        NSLog(@"can not change fontsize!");
    } else {
        NSArray*sourcearray = [bbsContent componentsSeparatedByString:@"font-size:"];
        NSMutableArray *bigArray = [NSMutableArray arrayWithArray:sourcearray];
        
        for (int i=1; i<bigArray.count; i++) {
            NSArray *minArray = [bigArray[i] componentsSeparatedByString:@"px"];
            if (minArray.count < 2) {
                minArray = [bigArray[i] componentsSeparatedByString:@"pt"];
            }
            if (minArray.count < 2) {
                minArray = [bigArray[i] componentsSeparatedByString:@"em"];
            }
            bigArray[i] = minArray[1];
        }
        bbsContent = @"";
        for (NSString *subStr in bigArray) {
            bbsContent = [bbsContent stringByAppendingString:subStr];
        }
    }
    
    //设置字体大小为14，颜色为0x666666，边距为18，并且图片的宽度自动充满屏幕，高度自适应
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {margin:18;font-size:14;color:0x666666}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",bbsContent];
    
    return htmls;
}


@end
