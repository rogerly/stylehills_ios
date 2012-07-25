//
//  FollowViewController.m
//  StyleHills
//
//  Created by Roger Ly on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FollowViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "AFJSONRequestOperation.h"
#import "FollowCell.h"
#import "Friend.h"
#import "ProfileViewController.h"

@interface FollowViewController ()

@end

@implementation FollowViewController
@synthesize table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil profileID:(NSInteger)pID following:(BOOL)f
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        profileID = pID;
        following = f;
        loaded = NO;
        friends = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (following)
        self.title = @"Following";
    else
        self.title = @"Followers";
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadFriendInfo];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadFriendInfo
{
    NSString *followPart = @"following";
    if (!following)
        followPart = @"followers";
    NSString *profileURL = [NSString stringWithFormat:@"http://www.stylehills.com/api/%@/%d/", followPart, profileID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: profileURL]];
    
    [SVProgressHUD showInView:self.view];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [SVProgressHUD dismiss];
        
        for (NSDictionary *friendInfo in JSON)
        {
            Friend *friend = [[Friend alloc] init];
            [friend loadDataFromDictionary:friendInfo];
            [friends addObject:friend];
        }
        loaded = YES;
        
        [self.table reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [SVProgressHUD dismissWithError:@"Error loading stream info"];
    }];
    [operation start];
}

#pragma mark UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!loaded)
        return 0;

    return friends.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Friend *friend = [friends objectAtIndex:indexPath.row];
    
    NSString *cellType = @"FollowCell";
    FollowCell *cell = (FollowCell *) [tableView dequeueReusableCellWithIdentifier:cellType];
    if (cell == nil)
    {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:cellType owner:self options:nil];
        cell = (FollowCell *)[nibs objectAtIndex:0];
        
        cell.avatar.layer.cornerRadius = 5.0;
        cell.avatar.layer.masksToBounds = YES;
    }
    cell.name.text = friend.name;
    cell.tagline.text = friend.headline;
    cell.location.text = friend.location;
    
    [cell.avatar setImageWithURL:[NSURL URLWithString:friend.avatarURLRetina]];
    
    if (friend.is_following)
        [cell.followButton setBackgroundImage:[UIImage imageNamed:@"followingButton"] forState:UIControlStateNormal];
    else
        [cell.followButton setBackgroundImage:[UIImage imageNamed:@"followButton"] forState:UIControlStateNormal];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Friend *friend = [friends objectAtIndex:indexPath.row];
    ProfileViewController *profileVC = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil profileID:friend.profileID];
    [self.navigationController pushViewController:profileVC animated:YES];
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}
@end
