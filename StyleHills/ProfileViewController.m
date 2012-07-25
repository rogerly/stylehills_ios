//
//  ProfileViewController.m
//  StyleHills
//
//  Created by Roger Ly on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "AFJSONRequestOperation.h"
#import "Item.h"
#import "YouTubeActivityItemCell.h"
#import "BlogPostActivityItemCell.h"
#import "AlbumActivityItemCell.h"
#import "StatusActivityItemCell.h"
#import "FollowViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize table;
@synthesize profileInfoCell;
@synthesize avatar;
@synthesize name;
@synthesize tagline;
@synthesize location;
@synthesize profileDetailsCell;
@synthesize numFollowers;
@synthesize numFollowing;
@synthesize numArticles;
@synthesize numPhotos;
@synthesize profileFollowCell;
@synthesize followButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil profileID:(NSInteger)pID
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        profileID = pID;
        loaded = NO;
        items = [[NSMutableArray alloc] initWithCapacity:0];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    avatar.layer.cornerRadius = 5.0;
    avatar.layer.masksToBounds = YES;
}

- (void)viewDidUnload
{
    table = nil;
    [self setTable:nil];
    [self setName:nil];
    [self setTagline:nil];
    [self setLocation:nil];
    [self setProfileInfoCell:nil];
    [self setNumFollowers:nil];
    [self setNumFollowing:nil];
    [self setNumArticles:nil];
    [self setNumPhotos:nil];
    [self setProfileDetailsCell:nil];
    [self setFollowButton:nil];
    [self setProfileFollowCell:nil];
    [self setAvatar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadProfileInfo];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadProfileInfo
{
    NSString *profileURL = [NSString stringWithFormat:@"http://www.stylehills.com/api/profile/%d/", profileID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: profileURL]];
    
    [SVProgressHUD showInView:self.view];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [SVProgressHUD dismiss];
        
        id userInfo = [JSON objectForKey:@"user"];
        
        name.text = [userInfo stringForKey:@"name"];
        self.title = name.text;
        tagline.text = [userInfo stringForKey:@"headline"];
        location.text = [NSString stringWithFormat:@"%@, %@", [userInfo stringForKey:@"closest_city"], [[userInfo objectForKey:@"country"] stringForKey:@"name"]];
        NSNumber *nFollowers = [userInfo objectForKey:@"followers_count"];
        numFollowers.text = [NSString stringWithFormat:@"%d", nFollowers.intValue];
        NSNumber *nFollowing = [userInfo objectForKey:@"following_count"];
        numFollowing.text = [NSString stringWithFormat:@"%d", nFollowing.intValue];
        NSNumber *nArticles = [userInfo objectForKey:@"articles_count"];
        numArticles.text = [NSString stringWithFormat:@"%d", nArticles.intValue];
        NSNumber *nPhotos = [userInfo objectForKey:@"photos_count"];
        numPhotos.text = [NSString stringWithFormat:@"%d", nPhotos.intValue];
        [avatar setImageWithURL:[NSURL URLWithString:[userInfo stringForKey:@"profile_image_iphone_retina"]]];

        for (NSDictionary *item in [JSON objectForKey:@"items"])
        {
            Item *activity = [[Item alloc] init];
            [activity loadDataFromDictionary:item];
            [items addObject:activity];
        }
        
        loaded = YES;
        [self.table reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [SVProgressHUD dismissWithError:@"Error loading stream info"];
    }];
    [operation start];
}

- (void)showFollowViewControllerAsFollowing:(BOOL)following
{
    FollowViewController *vc = [[FollowViewController alloc] initWithNibName:@"FollowViewController" bundle:nil profileID:profileID following:following];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)doFollowing:(id)sender
{
    [self showFollowViewControllerAsFollowing:YES];
}

- (IBAction)doFollowers:(id)sender
{
    [self showFollowViewControllerAsFollowing:NO];
}

#pragma mark UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (loaded)
        return 2;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int currentProfileID = [defaults integerForKey:@"profile_id"];
        if (currentProfileID == profileID)
            return 2;
        return 3;
    }
    
    return items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                return profileInfoCell.frame.size.height;
                
            case 1:
                return profileDetailsCell.frame.size.height;
                
            case 2:
                return profileFollowCell.frame.size.height;
        }
    }
    
    Item *item = [items objectAtIndex:indexPath.row];
    if ([item.type isEqualToString:@"externalblogpost"] || [item.type isEqualToString:@"post"])
        return 351;
    
    if ([item.type isEqualToString:@"status"])
    {
        CGSize statusSize = [item.title sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(280, 999999) lineBreakMode:UILineBreakModeWordWrap];
        return 110 - 21 + statusSize.height;
    }

    return 290;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                return profileInfoCell;
                
            case 1:
                return profileDetailsCell;
                
            case 2:
                return profileFollowCell;
        }
    }
    
    Item *item = [items objectAtIndex:indexPath.row];
    
    NSString *cellType = @"YouTubeActivityItemCell";
    ActivityItemCell *cell = nil;
    if ([item.type isEqualToString:@"albumupdate"])
    {
        cellType = @"AlbumActivityItemCell";
        cell = (AlbumActivityItemCell *) [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil)
        {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:cellType owner:self options:nil];
            cell = (AlbumActivityItemCell *)[nibs objectAtIndex:0];
        }
    }
    else if ([item.type isEqualToString:@"externalblogpost"] || [item.type isEqualToString:@"post"])
    {
        cellType = @"BlogPostActivityItemCell";
        cell = (BlogPostActivityItemCell *) [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil)
        {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:cellType owner:self options:nil];
            cell = (BlogPostActivityItemCell *)[nibs objectAtIndex:0];
        }
        
        [[(BlogPostActivityItemCell *)cell title] setText:item.title];
        [[(BlogPostActivityItemCell *)cell content] setText:item.content];
    }
    else if ([item.type isEqualToString:@"status"])
    {
        cellType = @"StatusActivityItemCell";
        cell = (StatusActivityItemCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil)
        {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:cellType owner:self options:nil];
            cell = (StatusActivityItemCell *)[nibs objectAtIndex:0];
            
            UILabel *statusLabel = [(StatusActivityItemCell *)cell status];
            
            CGSize statusSize = [item.title sizeWithFont:statusLabel.font constrainedToSize:CGSizeMake(statusLabel.frame.size.width, 999999) lineBreakMode:UILineBreakModeWordWrap];
            
            statusLabel.frame = CGRectMake(statusLabel.frame.origin.x, statusLabel.frame.origin.y, statusLabel.frame.size.width, statusSize.height);
            
            statusLabel.text = item.title;
        }
    }
    else
    {
        cellType = @"YouTubeActivityItemCell";
        cell = (YouTubeActivityItemCell *) [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil)
        {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:cellType owner:self options:nil];
            cell = (YouTubeActivityItemCell *)[nibs objectAtIndex:0];
        }
    }
    
    cell.name.text = item.name;
    CGSize nameSize = [item.name sizeWithFont:cell.name.font constrainedToSize:CGSizeMake(500, 999999) lineBreakMode:UILineBreakModeWordWrap];
    
    cell.timeSince.text = [NSString stringWithFormat:@"%@ ago", item.timeSince];

    cell.activityDescription.text = item.actionDescription;
    cell.activityDescription.frame = CGRectMake(nameSize.width + cell.name.frame.origin.x + 3, cell.activityDescription.frame.origin.y, cell.activityDescription.frame.size.width, cell.activityDescription.frame.size.height);

    cell.avatar.layer.cornerRadius = 5.0;
    cell.avatar.layer.masksToBounds = YES;
    cell.previewImage.layer.borderColor = [UIColor darkGrayColor].CGColor;
    cell.previewImage.layer.borderWidth = 1.0;
    [cell.avatar setImageWithURL:[NSURL URLWithString:item.avatarURLRetina]];
    
    if (item.thumbnailURLRetina)
    {
        [cell.previewImage setImageWithURL:[NSURL URLWithString:item.thumbnailURLRetina]];
    }
    
    if (item.numLikes == 1)
        cell.likes.text = @"1 person";
    else
        cell.likes.text = [NSString stringWithFormat:@"%d people", item.numLikes];

    if (item.numComments == 1)
        cell.comments.text = @"1 person";
    else
        cell.comments.text = [NSString stringWithFormat:@"%d people", item.numComments];

    return cell;
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}
@end
