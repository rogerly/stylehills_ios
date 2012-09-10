//
//  ActivityItemCell.h
//  StyleHills
//
//  Created by Roger Ly on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityItemCell : UITableViewCell
{
    __unsafe_unretained UIViewController *delegate;
}

@property (unsafe_unretained, nonatomic) UIViewController *delegate;

@property (assign, nonatomic) NSInteger contentTypeID;
@property (assign, nonatomic) NSInteger postID;

@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *timeSince;
@property (strong, nonatomic) IBOutlet UILabel *activityDescription;
@property (strong, nonatomic) IBOutlet UIImageView *previewImage;
@property (strong, nonatomic) IBOutlet UIButton *likeCommentButton;
- (IBAction)doLikeComment:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *likes;
@property (strong, nonatomic) IBOutlet UILabel *comments;

@end
