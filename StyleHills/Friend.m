//
//  Friend.m
//  StyleHills
//
//  Created by Roger Ly on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Friend.h"

@implementation Friend

@synthesize avatarURL, avatarURLRetina, name, headline, location, is_following, profileID;

- (id)init
{
    if (self == nil)
    {
        self = [super init];
    }
    return self;
}

- (void)loadDataFromDictionary:(NSDictionary *)dictionary
{
    profileID = [[dictionary objectForKey:@"id"] intValue];
    
    avatarURL = [dictionary objectForKey:@"iphone_owner_avatar"];
    avatarURLRetina = [dictionary objectForKey:@"iphone_owner_avatar_retina"];
    
    name = [dictionary objectForKey:@"name"];
    
    headline = [dictionary objectForKey:@"headline"];
    if ([dictionary objectForKey:@"closest_city"] != nil)
        location = [NSString stringWithFormat:@"%@, %@", [dictionary objectForKey:@"closest_city"], [[dictionary objectForKey:@"country"] objectForKey:@"name"]];
    else
        location = [[dictionary objectForKey:@"country"] objectForKey:@"name"];
    
    is_following = [[dictionary objectForKey:@"is_following"] boolValue];
}

@end
