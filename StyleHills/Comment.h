//
//  Comment.h
//  StyleHills
//
//  Created by Roger Ly on 8/16/12.
//
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) NSString *avatarURLRetina;
@property (strong, nonatomic) NSString *timeSince;

- (void)loadDataFromDictionary:(NSDictionary *)dictionary;

@end
