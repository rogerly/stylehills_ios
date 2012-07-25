//
//  AlbumPhotoSource.h
//  StyleHills
//
//  Created by Roger Ly on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGOPhotoGlobal.h"

@interface AlbumPhotoSource : NSObject <EGOPhotoSource>
{
    NSArray *_photos;
    NSInteger _numberOfPhotos;
}

- (id)initWithPhotos:(NSArray *)photos;

@end
