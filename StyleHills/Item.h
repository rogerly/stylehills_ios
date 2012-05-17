//
//  Item.h
//  StyleHills
//
//  Created by Roger Ly on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject
{
    NSString *thumbnailURL;
    NSString *thumbnailURLRetina;
}

- (NSString *)getThumbnailURL;
- (void)loadDataFromDictionary:(NSDictionary *)dictionary;

@end
