//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

/*
    Persists UIWebView cookies to disk. To send the cookies with an initial NSURLRequest you must do the following after loading the cookies:
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:yourURL];
    NSDictionary* headers = [NSHTTPCookie requestHeaderFieldsWithCookies:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    [request setAllHTTPHeaderFields:headers];
*/
#import <Foundation/Foundation.h>

@interface NSHTTPCookieStorage (CGXFreezeDry)
/**
 *  @brief 存储 UIWebView cookies到磁盘目录
 */
- (void)gx_saveCookie;
/**
 *  @brief 读取UIWebView cookies从磁盘目录
 */
- (void)gx_loadCookie;

@end
