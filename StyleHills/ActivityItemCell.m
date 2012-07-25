//
//  ActivityItemCell.m
//  StyleHills
//
//  Created by Roger Ly on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ActivityItemCell.h"

@implementation ActivityItemCell
@synthesize likes;
@synthesize comments;
@synthesize likeCommentButton;

@synthesize avatar, name, timeSince, activityDescription, previewImage;

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

- (IBAction)doLikeComment:(id)sender {
}
@end
