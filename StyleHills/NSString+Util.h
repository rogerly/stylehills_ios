//
//  NSString+Util.h
//  Ketup
//
//  Created by Roger Ly on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

- (bool)isEmpty;
- (NSString *)trim;
- (NSNumber *)numericValue;

@end

@interface NSNumber (NumericValueHack)
- (NSNumber *)numericValue;
@end