//
//  Item.m
//  StyleHills
//
//  Created by Roger Ly on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Item.h"

@implementation Item

- (id)init
{
    if (self == nil)
    {
        self = [super init];
    }
    return self;
}

- (NSString *)getThumbnailURL
{
    return thumbnailURLRetina;
}

- (void)loadDataFromDictionary:(NSDictionary *)dictionary
{
    thumbnailURL = [dictionary objectForKey:@"iphone_thumbnail"];
    thumbnailURLRetina = [dictionary objectForKey:@"iphone_thumbnail_retina"];
}

@end
