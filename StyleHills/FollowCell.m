//
//  FollowCell.m
//  StyleHills
//
//  Created by Roger Ly on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FollowCell.h"

@implementation FollowCell
@synthesize avatar;
@synthesize name;
@synthesize tagline;
@synthesize location;
@synthesize followButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)doFollow:(id)sender {
}
@end
