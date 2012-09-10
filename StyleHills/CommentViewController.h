//
//  CommentViewController.h
//  StyleHills
//
//  Created by Roger Ly on 8/14/12.
//
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@class Friend;
@class Item;

@interface CommentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, HPGrowingTextViewDelegate>
{
    NSMutableArray *comments;
    NSMutableArray *likes;
    
    BOOL loaded;
    
    NSInteger contentTypeID;
    NSInteger postID;
    
    Item *item;
    Friend *owner;

    HPGrowingTextView *growingMessageView;
}

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet UIButton *covetButton;
- (IBAction)doCovet:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *clipboardButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;

@property (strong, nonatomic) IBOutlet UITableViewCell *contentCell;
@property (strong, nonatomic) IBOutlet UIImageView *previewImage;
@property (strong, nonatomic) IBOutlet UIImageView *contentOwnerAvatar;
@property (strong, nonatomic) IBOutlet UILabel *contentOwner;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIButton *readMoreButton;
@property (strong, nonatomic) IBOutlet UILabel *postedDate;

@property (strong, nonatomic) IBOutlet UITableViewCell *covetedCell;
@property (strong, nonatomic) IBOutlet UIButton *coveter;
@property (strong, nonatomic) IBOutlet UIButton *others;
@property (strong, nonatomic) IBOutlet UILabel *andText;
@property (strong, nonatomic) IBOutlet UILabel *covetedThisText;

@property (strong, nonatomic) IBOutlet UIView *messageBar;
@property (strong, nonatomic) IBOutlet UILabel *helperText;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
- (IBAction)sendComment:(id)sender;

-(void)loadCommentInfo;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contentTypeID:(NSInteger)contentTypeID postID:(NSInteger)postID;

@end
