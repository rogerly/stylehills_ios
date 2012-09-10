//
//  ActivityItemCell.m
//  StyleHills
//
//  Created by Roger Ly on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ActivityItemCell.h"
#import "CommentViewController.h"

@implementation ActivityItemCell
@synthesize likes;
@synthesize comments;
@synthesize likeCommentButton;
@synthesize delegate;

@synthesize avatar, name, timeSince, activityDescription, previewImage, contentTypeID, postID;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        avatar.layer.cornerRadius = 5.0;
        avatar.layer.masksToBounds = YES;
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)doLikeComment:(id)sender
{
    CommentViewController *vc = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil contentTypeID:contentTypeID postID:postID];
    
    [[delegate navigationController] pushViewController:vc animated:YES];
}
@end
