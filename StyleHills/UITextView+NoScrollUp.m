//
//  UITextView+NoScrollUp.m
//  Ketup
//
//  Created by Roger Ly on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITextView+NoScrollUp.h"

@implementation UITextView (NoScrollUp)

-(void)setContentInset:(UIEdgeInsets)s
{
	UIEdgeInsets insets = s;
    
	if(s.bottom>8) insets.bottom = 0;
	insets.top = 0;
    
	[super setContentInset:insets];
}

-(void)setContentOffset:(CGPoint)s
{
	if(self.tracking || self.decelerating){
		//initiated by user...
		self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
	} else {
        
		float bottomOffset = (self.contentSize.height - self.frame.size.height + self.contentInset.bottom);
		if(s.y < bottomOffset && self.scrollEnabled){
			self.contentInset = UIEdgeInsetsMake(0, 0, 8, 0); //maybe use scrollRangeToVisible?
		}
        
	}
    
	[super setContentOffset:s];
}

@end
