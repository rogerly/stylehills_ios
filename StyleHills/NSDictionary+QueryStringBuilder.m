//
//  NSDictionary+QueryStringBuilder.m
//  Ketup
//
//  Created by Roger Ly on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+QueryStringBuilder.h"

static NSString * escapeString(NSString *unencodedString)
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge_retained CFStringRef)unencodedString, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", kCFStringEncodingUTF8);
}


@implementation NSDictionary (QueryStringBuilder)

- (NSString *)queryString
{
    NSMutableString *queryString = nil;
    NSArray *keys = [self allKeys];
    
    if ([keys count] > 0) {
        for (id key in keys) {
            id value = [self objectForKey:key];
            if (nil == queryString) {
                queryString = [[NSMutableString alloc] init];
                [queryString appendFormat:@"?"];
            } else {
                [queryString appendFormat:@"&"];
            }
            
            if (nil != key && nil != value) {
                [queryString appendFormat:@"%@=%@", escapeString(key), escapeString(value)];
            } else if (nil != key) {
                [queryString appendFormat:@"%@", escapeString(key)];
            }
        }
    }
    
    return queryString;
}

@end
