//
//  NSURL+CGXQueryDictionary.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (CGXQueryDictionary)

/**
 *  @return URL's query component as keys/values
 *  Returns nil for an empty query
 */
- (NSDictionary*)gx_queryDictionary;

/**
 *  @return URL with keys values appending to query string
 *  @param queryDictionary Query keys/values
 *  @param sortedKeys Sorted the keys alphabetically?
 *  @warning If keys overlap in receiver and query dictionary,
 *  behaviour is undefined.
 */
- (NSURL*)gx_URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary
                             withSortedKeys:(BOOL) sortedKeys;

/** As above, but `sortedKeys=NO` */
- (NSURL*)gx_URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary;

/**
 *  @return Copy of URL with its query component replaced with
 *  the specified dictionary.
 *  @param queryDictionary A new query dictionary
 *  @param sortedKeys      Whether or not to sort the query keys
 */
- (NSURL*)gx_URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary
                                 withSortedKeys:(BOOL) sortedKeys;

/** As above, but `sortedKeys=NO` */
- (NSURL*)gx_URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary;

/** @return Receiver with query component completely removed */
- (NSURL*)gx_URLByRemovingQuery;

@end

#pragma mark -

@interface NSString (CGXURLQuery)

/**
 *  @return If the receiver is a valid URL query component, returns
 *  components as key/value pairs. If couldn't split into *any* pairs,
 *  returns nil.
 */
- (NSDictionary*)gx_URLQueryDictionary;

@end

