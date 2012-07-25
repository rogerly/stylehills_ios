//
//  AlbumPhotoSource.m
//  StyleHills
//
//  Created by Roger Ly on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlbumPhotoSource.h"

@implementation AlbumPhotoSource

@synthesize photos=_photos;
@synthesize numberOfPhotos=_numberOfPhotos;

- (id)initWithPhotos:(NSArray *)photos
{
    if (self = [super init])
    {
        _photos = photos;
        _numberOfPhotos = [_photos count];
    }
    
    return self;
}

- (id <EGOPhoto>)photoAtIndex:(NSInteger)index
{
    return [_photos objectAtIndex:index];
}

@end
