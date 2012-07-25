//
//  Friend.h
//  StyleHills
//
//  Created by Roger Ly on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Friend : NSObject
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) NSString *avatarURLRetina;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *headline;
@property (strong, nonatomic) NSString *location;
@property (assign, nonatomic) BOOL is_following;
@property (assign, nonatomic) NSInteger profileID;

- (void)loadDataFromDictionary:(NSDictionary *)dictionary;

@end
