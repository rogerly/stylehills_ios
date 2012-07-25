//
//  FollowViewController.h
//  StyleHills
//
//  Created by Roger Ly on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    BOOL following;
    NSInteger profileID;
    NSMutableArray *friends;
    BOOL loaded;
}

@property (strong, nonatomic) IBOutlet UITableView *table;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil profileID:(NSInteger)profileID following:(BOOL)following;

- (void)loadFriendInfo;

@end
