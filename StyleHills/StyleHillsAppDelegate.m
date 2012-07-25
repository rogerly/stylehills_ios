//
//  StyleHillsAppDelegate.m
//  StyleHills
//
//  Copyright (c) 2011 Alberto Gimeno Brieba
//  
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//  

#import "StyleHillsAppDelegate.h"
#import "AFURLCache.h"

#import "RootViewController.h"
#import "CityStreamViewController.h"
#import "EGOPhotoViewController.h"
#import "AlbumPhoto.h"
#import "AlbumPhotoSource.h"
#import "ProfileViewController.h"

@implementation StyleHillsAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

+ (StyleHillsAppDelegate*) sharedAppDelegate {
	return (StyleHillsAppDelegate*) [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:184.0/255 green:44.0/255 blue:58.0/255 alpha:1.0]];
    // use custom URLCache to get disk caching on iOS
    AFURLCache *URLCache = [[AFURLCache alloc] initWithMemoryCapacity:1024*1024   // 1MB mem cache
                                                          diskCapacity:1024*1024*5 // 5MB disk cache
                                                              diskPath:[AFURLCache defaultCachePath]];
    
	[NSURLCache setSharedURLCache:URLCache];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:2] forKey:@"profile_id"];
    
    NSInteger profileID = [defaults integerForKey:@"profile_id"];
    
    ProfileViewController *profileView = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil profileID:profileID];
    UINavigationController *profileNavController = [[UINavigationController alloc] initWithRootViewController:profileView];
    
    AlbumPhotoSource *photos = [[AlbumPhotoSource alloc] initWithPhotos:[NSArray arrayWithObjects:[[AlbumPhoto alloc] initWithImageURL:[NSURL URLWithString:@"http://s3.amazonaws.com:80/stylehills_qa/cache%2F65%2F25%2F6525bf35c26f3c93caa216b126333b94.jpg"] name:@"one"], [[AlbumPhoto alloc] initWithImageURL:[NSURL URLWithString:@"http://s3.amazonaws.com:80/stylehills_qa/cache%2F6f%2F35%2F6f35cea35b603c6b642e51fca8c9cf8c.jpg"] name:@"two"], [[AlbumPhoto alloc] initWithImageURL:[NSURL URLWithString:@"http://s3.amazonaws.com:80/stylehills_qa/cache%2F3f%2Fb7%2F3fb7559fe36be92002039a7eeed6e0cb.jpg"] name:@"three"], [[AlbumPhoto alloc] initWithImageURL:[NSURL URLWithString:@"http://s3.amazonaws.com:80/stylehills_qa/cache%2Fde%2F06%2Fde069f0468af2fe07afcf74440dcf41b.jpg"] name:@"four"], nil]];
    
    UIViewController *photoViewController = [[EGOPhotoViewController alloc] initWithPhotoSource:photos];
    UINavigationController *cityStreamNavController = [[UINavigationController alloc] initWithRootViewController:photoViewController];
//    UIViewController *cityStreamViewController = [[CityStreamViewController alloc] initWithNibName:@"CityStreamViewController" bundle:nil];
//    UINavigationController *cityStreamNavController = [[UINavigationController alloc] initWithRootViewController:cityStreamViewController];
    
    viewControllers = [NSArray arrayWithObjects:profileNavController, nil];
//    viewControllers = [NSArray arrayWithObjects:cityStreamNavController, nil];
    
    RootViewController *rootVC = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    [rootVC setViewControllers:viewControllers];
    
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

}

@end
