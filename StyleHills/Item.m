//
//  Item.m
//  StyleHills
//
//  Created by Roger Ly on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Item.h"

@implementation Item

@synthesize thumbnailURL, thumbnailURLRetina, commentThumbnailURL, commentThumbnailURLRetina, avatarURL, avatarURLRetina, numComments, numLikes, title, content, type, timeSince, actionDescription, name, contentTypeID, postID;

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
    thumbnailURL = [dictionary objectForKey:@"iphone_thumbnail"];
    thumbnailURLRetina = [dictionary objectForKey:@"iphone_thumbnail_retina"];
    commentThumbnailURL = [dictionary objectForKey:@"iphone_comment_thumbnail"];
    commentThumbnailURLRetina = [dictionary objectForKey:@"iphone_comment_thumbnail_retina"];
    avatarURL = [dictionary objectForKey:@"iphone_owner_avatar"];
    avatarURLRetina = [dictionary objectForKey:@"iphone_owner_avatar_retina"];
    
    name = [dictionary objectForKey:@"name"];
    
    NSNumber *nComments = [dictionary objectForKey:@"num_comments"];
    numComments = nComments.intValue;

    NSNumber *nLikes = [dictionary objectForKey:@"num_likes"];
    numLikes = nLikes.intValue;
    
    title = [dictionary objectForKey:@"title"];
    content = [dictionary objectForKey:@"content"];
    type = [dictionary objectForKey:@"type"];
    
    timeSince = [dictionary objectForKey:@"time_since"];
    
    actionDescription = [dictionary objectForKey:@"action_description"];
    
    NSNumber *nContentTypeID = [dictionary objectForKey:@"content_type_id"];
    contentTypeID = nContentTypeID.intValue;

    NSNumber *nPostID = [dictionary objectForKey:@"id"];
    postID = nPostID.intValue;
}

@end
