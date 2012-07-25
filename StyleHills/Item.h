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
}

@property (strong, nonatomic) NSString *thumbnailURL;
@property (strong, nonatomic) NSString *thumbnailURLRetina;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) NSString *avatarURLRetina;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *timeSince;
@property (strong, nonatomic) NSString *actionDescription;
@property (assign, nonatomic) NSInteger numComments;
@property (assign, nonatomic) NSInteger numLikes;

- (void)loadDataFromDictionary:(NSDictionary *)dictionary;

@end
