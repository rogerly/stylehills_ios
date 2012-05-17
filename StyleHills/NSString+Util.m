//
//  NSString+Util.m
//  Ketup
//
//  Created by Roger Ly on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Util.h"


@implementation NSString (Util)

- (bool)isEmpty {
    return self.length == 0;
}

- (NSString *)trim {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSNumber *)numericValue {
    return [NSNumber numberWithInt:[self intValue]];
}

@end

@implementation NSNumber (NumericValueHack)
- (NSNumber *)numericValue {
	return self;
}
@end