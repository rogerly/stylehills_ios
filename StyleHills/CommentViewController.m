//
//  CommentViewController.m
//  StyleHills
//
//  Created by Roger Ly on 8/14/12.
//
//

#import <QuartzCore/QuartzCore.h>
#import "CommentViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "AFJSONRequestOperation.h"
#import "Comment.h"
#import "Like.h"
#import "Item.h"
#import "Friend.h"
#import "StyleHillsAppDelegate.h"

@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize table;
@synthesize titleView;
@synthesize covetButton;
@synthesize clipboardButton;
@synthesize shareButton;
@synthesize contentCell;
@synthesize previewImage;
@synthesize contentOwnerAvatar;
@synthesize contentOwner;
@synthesize content;
@synthesize readMoreButton;
@synthesize postedDate;
@synthesize covetedCell;
@synthesize coveter;
@synthesize others;
@synthesize andText;
@synthesize covetedThisText;
@synthesize messageBar;
@synthesize helperText;
@synthesize messageButton;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contentTypeID:(NSInteger)cID postID:(NSInteger)pID
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        contentTypeID = cID;
        postID = pID;
        
        comments = [[NSMutableArray alloc] initWithCapacity:0];
        likes = [[NSMutableArray alloc] initWithCapacity:0];

        item = [[Item alloc] init];
        owner = [[Friend alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = titleView;
    
    [self loadCommentInfo];
    
    [contentCell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"commentTopCellBackground.png"]]];

    growingMessageView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(5, 6, 227, 31)];
    growingMessageView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    growingMessageView.minNumberOfLines = 1;
    growingMessageView.maxNumberOfLines = 6;
    growingMessageView.font = [UIFont systemFontOfSize:14.0f];
    growingMessageView.delegate = self;
    growingMessageView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    growingMessageView.backgroundColor = [UIColor whiteColor];
    [helperText removeFromSuperview];
    [growingMessageView addSubview:helperText];
    helperText.center = CGPointMake(helperText.center.x - 7, helperText.center.y - 7);
    [growingMessageView bringSubviewToFront:growingMessageView.internalTextView];
    growingMessageView.internalTextView.backgroundColor = [UIColor clearColor];

    UIImage *rawEntryBackground = [UIImage imageNamed:@"messageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    entryImageView.frame = CGRectMake(5, 0, 227, 44);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *rawBackground = [UIImage imageNamed:@"messageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(0, 0, messageBar.frame.size.width, messageBar.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    growingMessageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [messageBar addSubview:imageView];
    [messageBar bringSubviewToFront:helperText];
    [messageBar addSubview:growingMessageView];
    [messageBar addSubview:entryImageView];
    [messageBar bringSubviewToFront:messageButton];
}

- (void)viewDidUnload
{
    [self setTitleView:nil];
    [self setContentCell:nil];
    [self setTable:nil];
    [self setPreviewImage:nil];
    [self setContentOwner:nil];
    [self setContent:nil];
    [self setReadMoreButton:nil];
    [self setPostedDate:nil];
    [self setCoveter:nil];
    [self setOthers:nil];
    [self setCovetedCell:nil];
    [self setContentOwnerAvatar:nil];
    [self setAndText:nil];
    [self setCovetedThisText:nil];
    [self setCovetButton:nil];
    [self setClipboardButton:nil];
    [self setShareButton:nil];
    [self setMessageBar:nil];
    [self setHelperText:nil];
    [self setMessageButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sendComment:(id)sender {
}

- (void)loadCommentInfo
{
    NSString *commentURL = [NSString stringWithFormat:@"http://www.stylehills.com/api/comments/%d/%d/", contentTypeID, postID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: commentURL]];
    
    [SVProgressHUD showInView:self.view];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [SVProgressHUD dismiss];
        
        for (NSDictionary *commentInfo in [JSON objectForKey:@"comments"])
        {
            Comment *comment = [[Comment alloc] init];
            [comment loadDataFromDictionary:commentInfo];
            [comments addObject:comment];
        }

        for (NSDictionary *likeInfo in [JSON objectForKey:@"likes"])
        {
            Like *like = [[Like alloc] init];
            [like loadDataFromDictionary:likeInfo];
            [likes addObject:like];
        }
        
        [item loadDataFromDictionary:[JSON objectForKey:@"item"]];

        [owner loadDataFromDictionary:[JSON objectForKey:@"owner"]];
        [contentOwnerAvatar setImageWithURL:[NSURL URLWithString:[[JSON objectForKey:@"owner"] objectForKey:@"profile_image_iphone_retina"]]];

        loaded = YES;
        
        [self.table reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [SVProgressHUD dismissWithError:@"Error loading comment info"];
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
    
    int numComments = [comments count];
    if ([likes count] > 0)
        return 2;
//        numComments++;

    return 1;
//    return numComments + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return contentCell.frame.size.height;
        case 1:
            return covetedCell.frame.size.height;
    }
    
    return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [previewImage setImageWithURL:[NSURL URLWithString:[item thumbnailURLRetina]]];
        contentOwner.text = owner.name;
        [contentOwnerAvatar setImageWithURL:[NSURL URLWithString:item.avatarURLRetina]];
        content.text = item.content;
        postedDate.text = [NSString stringWithFormat:@"%@ ago", item.timeSince];
        return contentCell;
    }
    
    if (indexPath.row == 1 && [likes count] > 0)
    {
        Like *lastLike = (Like *)[likes objectAtIndex:0];
        NSString *lastCoveter = lastLike.name;
        if ([StyleHillsAppDelegate currentProfile] == lastLike.profileID)
        {
            if ([likes count] == 1)
            {
                lastCoveter = @"You";
            }
            else
            {
                lastCoveter = [(Like *)[likes objectAtIndex:1] name];
            }
        }
        
        int nOthers = [likes count] - 1;
        CGSize lastCoveterSize = [lastCoveter sizeWithFont:coveter.titleLabel.font constrainedToSize:CGSizeMake(120, 999999) lineBreakMode:UILineBreakModeTailTruncation];
        
        NSString *otherString = [NSString stringWithFormat:@"%d others", nOthers];
        if (nOthers == 1)
            otherString = @"1 other";

        coveter.frame = CGRectMake(coveter.frame.origin.x, coveter.frame.origin.y, lastCoveterSize.width, coveter.frame.size.height);
        [coveter setTitle:lastCoveter forState:UIControlStateHighlighted];
        [coveter setTitle:lastCoveter forState:UIControlStateNormal];
        [coveter setTitle:lastCoveter forState:UIControlStateSelected];
        coveter.titleLabel.text = lastCoveter;
        
        if (nOthers == 0)
        {
            others.hidden = YES;
            andText.hidden = YES;
            covetedThisText.frame = CGRectMake(coveter.frame.origin.x + coveter.frame.size.width, covetedThisText.frame.origin.y, covetedThisText.frame.size.width, covetedThisText.frame.size.height);
        }
        else
        {
            andText.frame = CGRectMake(coveter.frame.origin.x + coveter.frame.size.width, andText.frame.origin.y, andText.frame.size.width, andText.frame.size.height);

            CGSize othersSize = [otherString sizeWithFont:others.titleLabel.font constrainedToSize:CGSizeMake(320, 999999) lineBreakMode:UILineBreakModeTailTruncation];
            others.frame = CGRectMake(andText.frame.origin.x + andText.frame.size.width, others.frame.origin.y, othersSize.width, others.frame.size.height);
            [others setTitle:otherString forState:UIControlStateHighlighted];
            [others setTitle:otherString forState:UIControlStateNormal];
            [others setTitle:otherString forState:UIControlStateSelected];
            covetedThisText.frame = CGRectMake(others.frame.origin.x + others.frame.size.width, covetedThisText.frame.origin.y, covetedThisText.frame.size.width, covetedThisText.frame.size.height);
        }
        
        [covetButton setSelected:NO];
        for (Like *like in likes)
            if (like.profileID == [StyleHillsAppDelegate currentProfile])
                [covetButton setSelected:YES];
        
        return covetedCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Friend *friend = [friends objectAtIndex:indexPath.row];
//    ProfileViewController *profileVC = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil profileID:friend.profileID];
//    [self.navigationController pushViewController:profileVC animated:YES];
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (IBAction)doCovet:(id)sender {
}

#pragma mark HPGrowingTextViewDelegate

- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)textView
{
//    keyboardOverlay.hidden = NO;
    [UIView beginAnimations:@"scrollMessageView" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    messageBar.transform = CGAffineTransformMakeTranslation(0, -214);
    [UIView commitAnimations];
}

- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)textView
{
    [UIView beginAnimations:@"scrollMessageView" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];
    messageBar.transform = CGAffineTransformMakeTranslation(0, 0);
    [UIView commitAnimations];
    [textView resignFirstResponder];
//    keyboardOverlay.hidden = YES;
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = messageBar.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	messageBar.frame = r;
}

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL enable = YES;
    if (growingTextView.text.length == range.length && text.length == 0)
        enable = NO;
    self.messageButton.enabled = enable;
    helperText.hidden = enable;
    return YES;
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

@end
