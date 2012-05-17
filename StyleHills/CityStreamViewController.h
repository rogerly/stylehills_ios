//
//  CityStreamViewController.h
//  StyleHills
//
//  Created by Roger Ly on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"

@interface CityStreamViewController : ListViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *items;
    BOOL loaded;
}

@property (strong, nonatomic) IBOutlet UITableView *table;

- (void)loadStream;

@end
