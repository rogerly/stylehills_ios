//
//  Comment.m
//  StyleHills
//
//  Created by Roger Ly on 8/16/12.
//
//

#import "Comment.h"

@implementation Comment

@synthesize comment, name, avatarURL, avatarURLRetina, timeSince;

- (void)loadDataFromDictionary:(NSDictionary *)dictionary
{
    comment = [dictionary objectForKey:@"comment"];
    name = [[dictionary objectForKey:@"owner"] objectForKey:@"name"];
    avatarURL = [[dictionary objectForKey:@"owner"] objectForKey:@"profile_image_iphone"];
    avatarURLRetina = [[dictionary objectForKey:@"owner"] objectForKey:@"profile_image_iphone_retina"];
    timeSince = [dictionary objectForKey:@"time_since"];
}

@end
