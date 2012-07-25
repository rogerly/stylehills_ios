//
//  ProfileViewController.h
//  StyleHills
//
//  Created by Roger Ly on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger profileID;
    NSMutableArray *items;
    
    BOOL loaded;
}
@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) IBOutlet UITableViewCell *profileInfoCell;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *tagline;
@property (strong, nonatomic) IBOutlet UILabel *location;

@property (strong, nonatomic) IBOutlet UITableViewCell *profileDetailsCell;
@property (strong, nonatomic) IBOutlet UILabel *numFollowers;
@property (strong, nonatomic) IBOutlet UILabel *numFollowing;
@property (strong, nonatomic) IBOutlet UILabel *numArticles;
@property (strong, nonatomic) IBOutlet UILabel *numPhotos;

@property (strong, nonatomic) IBOutlet UITableViewCell *profileFollowCell;
@property (strong, nonatomic) IBOutlet UIButton *followButton;

- (IBAction)doFollowing:(id)sender;
- (IBAction)doFollowers:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil profileID:(NSInteger)profileID;

- (void)loadProfileInfo;
@end
