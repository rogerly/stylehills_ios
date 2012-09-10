//
//  Like.m
//  StyleHills
//
//  Created by Roger Ly on 8/16/12.
//
//

#import "Like.h"

@implementation Like

@synthesize name, profileID;

- (void)loadDataFromDictionary:(NSDictionary *)dictionary
{
    name = [dictionary objectForKey:@"name"];
    NSNumber *nProfileID = [dictionary objectForKey:@"profile_id"];
    profileID = nProfileID.intValue;
}

@end
