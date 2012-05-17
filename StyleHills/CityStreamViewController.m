//
//  CityStreamViewController.m
//  StyleHills
//
//  Created by Roger Ly on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CityStreamViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "AFJSONRequestOperation.h"
#import "Item.h"

@interface CityStreamViewController ()

@end

@implementation CityStreamViewController
@synthesize table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        loaded = NO;
        items = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadStream];
}

- (void)loadStream
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.stylehills.com/api/city/stream/all/"]];
    
    [SVProgressHUD showInView:self.view];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [SVProgressHUD dismiss];

        [items removeAllObjects];

        for (NSDictionary *item in JSON)
        {
            Item *itemData = [[Item alloc] init];
            [itemData loadDataFromDictionary:item];
            [items addObject:itemData];
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
    
    return ceil((float)(items.count) / 3.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemCell";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        for (int imageCellIndex = 0; imageCellIndex < 3; imageCellIndex++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(88 * imageCellIndex, 0, 88, 88)];
            imageView.tag = 100 + imageCellIndex;
            imageView.hidden = YES;
            [cell addSubview:imageView];
        }
    }
    
    int startIndex = indexPath.row * 3;
    int endIndex = MIN((indexPath.row + 1) * 3, items.count);
    
    int counter = 0;
    for (int i = startIndex; i < endIndex; i++)
    {
        Item* item = [items objectAtIndex:i];
        UIImageView *browseImage = (UIImageView *)[cell viewWithTag:100 + counter];
        [browseImage setImageWithURL:[NSURL URLWithString:[item getThumbnailURL]]];
        browseImage.hidden = NO;

//        UIButton *browseButton = (UIButton *)[cell viewWithTag:200 + counter];
//        browseButton.enabled = YES;
//        browseButton.hidden = NO;
//        browseButton.tag = 10000 + i;
//        [browseButton addTarget:self action:@selector(loadPost:) forControlEvents:UIControlEventTouchUpInside];
        counter++;
    }

    return cell;
}


@end
