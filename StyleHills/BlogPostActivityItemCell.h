//
//  BlogPostActivityItemCell.h
//  StyleHills
//
//  Created by Roger Ly on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivityItemCell.h"

@interface BlogPostActivityItemCell : ActivityItemCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *content;

@end
