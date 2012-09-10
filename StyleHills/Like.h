//
//  Like.h
//  StyleHills
//
//  Created by Roger Ly on 8/16/12.
//
//

#import <Foundation/Foundation.h>

@interface Like : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger profileID;

- (void)loadDataFromDictionary:(NSDictionary *)dictionary;

@end
