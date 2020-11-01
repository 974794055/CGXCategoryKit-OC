//
//  NSString+CGXExtension.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

#import <AdSupport/AdSupport.h>
NS_ASSUME_NONNULL_BEGIN


@interface NSString (CGXExtension)

/**
 *  判断是否为空或为空格
 *  @return YES OR NOT
 */
- (BOOL)gx_isEmpty;
/**
 验证非空字符串  如果为空 转换成 @"";
 */
+ (NSString *)gx_emptyStr:(NSString *)str;
/**
 *  包含某些字符串
 *  @return YES OR NOT
 */
- (BOOL)gx_containsStringWith:(NSString*)other;
/**
 *  @brief  判断URL中是否包含中文
 *  @return 是否包含中文
 */
- (BOOL)gx_isContainChinese;
/**
 *  @brief  是否包含空格
 *  @return 是否包含空格
 */
- (BOOL)gx_isContainBlank;
/**
 阿拉伯数字转成中文
 @param arebic 阿拉伯数字
 @return 返回的中文数字
 */
+(NSString *)gx_translation:(NSString *)arebic;
/**
 字符串反转
 @param str 要反转的字符串
 @return 反转之后的字符串
 */
- (NSString*)gx_reverseWordsInString:(NSString*)str;
/**
 获得汉字的拼音
 @param chinese 汉字
 @return 拼音
 */
+ (NSString *)gx_transform:(NSString *)chinese;

/**
 返回一个包含匹配正则表达式的新字符串替换为模版字符串。
 @param regex       正则表达式
 @param options     上报的匹配选项.
 @param replacement 用来替换匹配到的内容.
 @param  string 需要匹配的字符串
 
 @return 返回一个用指定字符串替换匹配字符串后的字符串.
 */
+ (NSString *)gx_stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement content:(NSString *)string;

/**
 匹配正则表达式，并使用匹配的每个对象执行给定的块。
 
 @param regex    正则表达式
 @param options  上报的匹配选项.
 @param block    应用于在数组元素中匹配的块.
 该块需要四个参数:
 match: 匹配的子串.
 matchRange: 匹配选项.
 stop: 一个布尔值的引用。块可以设置YES来停止处理阵列。stop参数是一个唯一的输出。你应该给块设置YES。
 @param  string 需要匹配的字符串
 */
+ (void)gx_enumerateRegexMatches:(NSString *)regex
                      options:(NSRegularExpressionOptions)options
                   usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block content:(NSString *)string;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)gx_isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)gx_isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

@end


/**
*  正则表达式简单说明
*  语法：
.       匹配除换行符以外的任意字符
\w      匹配字母或数字或下划线或汉字
\s      匹配任意的空白符
\d      匹配数字
\b      匹配单词的开始或结束
^       匹配字符串的开始
$       匹配字符串的结束
*       重复零次或更多次
+       重复一次或更多次
?       重复零次或一次
{n}     重复n次
{n,}     重复n次或更多次
{n,m}     重复n到m次
\W      匹配任意不是字母，数字，下划线，汉字的字符
\S      匹配任意不是空白符的字符
\D      匹配任意非数字的字符
\B      匹配不是单词开头或结束的位置
[^x]     匹配除了x以外的任意字符
[^aeiou]匹配除了aeiou这几个字母以外的任意字符
*?      重复任意次，但尽可能少重复
+?      重复1次或更多次，但尽可能少重复
??      重复0次或1次，但尽可能少重复
{n,m}?     重复n到m次，但尽可能少重复
{n,}?     重复n次以上，但尽可能少重复
\a      报警字符(打印它的效果是电脑嘀一声)
\b      通常是单词分界位置，但如果在字符类里使用代表退格
\t      制表符，Tab
\r      回车
\v      竖向制表符
\f      换页符
\n      换行符
\e      Escape
\0nn     ASCII代码中八进制代码为nn的字符
\xnn     ASCII代码中十六进制代码为nn的字符
\unnnn     Unicode代码中十六进制代码为nnnn的字符
\cN     ASCII控制字符。比如\cC代表Ctrl+C
\A      字符串开头(类似^，但不受处理多行选项的影响)
\Z      字符串结尾或行尾(不受处理多行选项的影响)
\z      字符串结尾(类似$，但不受处理多行选项的影响)
\G      当前搜索的开头
\p{name}     Unicode中命名为name的字符类，例如\p{IsGreek}
(?>exp)     贪婪子表达式
(?<x>-<y>exp)     平衡组
(?im-nsx:exp)     在子表达式exp中改变处理选项
(?im-nsx)       为表达式后面的部分改变处理选项
(?(exp)yes|no)     把exp当作零宽正向先行断言，如果在这个位置能匹配，使用yes作为此组的表达式；否则使用no
(?(exp)yes)     同上，只是使用空表达式作为no
(?(name)yes|no) 如果命名为name的组捕获到了内容，使用yes作为表达式；否则使用no
(?(name)yes)     同上，只是使用空表达式作为no

捕获
(exp)               匹配exp,并捕获文本到自动命名的组里
(?<name>exp)        匹配exp,并捕获文本到名称为name的组里，也可以写成(?'name'exp)
(?:exp)             匹配exp,不捕获匹配的文本，也不给此分组分配组号
零宽断言
(?=exp)             匹配exp前面的位置
(?<=exp)            匹配exp后面的位置
(?!exp)             匹配后面跟的不是exp的位置
(?<!exp)            匹配前面不是exp的位置
注释
(?#comment)         这种类型的分组不对正则表达式的处理产生任何影响，用于提供注释让人阅读

*  表达式：\(?0\d{2}[) -]?\d{8}
*  这个表达式可以匹配几种格式的电话号码，像(010)88886666，或022-22334455，或02912345678等。
*  我们对它进行一些分析吧：
*  首先是一个转义字符\(,它能出现0次或1次(?),然后是一个0，后面跟着2个数字(\d{2})，然后是)或-或空格中的一个，它出现1次或不出现(?)，
*  最后是8个数字(\d{8})
*/

NS_ASSUME_NONNULL_END
