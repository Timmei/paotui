//
//  AppDelegate.m
//  Paotui
//
//  Created by Tim on 14-9-9.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "AppDelegate.h"
//#import "APIKey.h"
#import <MAMapKit/MAMapKit.h>
#import "LoginViewController.h"

const static NSString *APIKey = @"85c55e3c31092ca99c32049d46e0f8d1";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
 
    
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserViewController *userView = [story instantiateViewControllerWithIdentifier:@"user"];
    [userView.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.75, [UIScreen mainScreen].bounds.size.height)];
    
    HomeViewController *homeView = [story instantiateViewControllerWithIdentifier:@"home"];
    
    [QHSliderViewController sharedSliderController].LeftVC = (UIViewController*)userView;
    
    [QHSliderViewController sharedSliderController].MainVC = (UIViewController*)homeView;
    
    UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:[QHSliderViewController sharedSliderController]];
    self.window.rootViewController = naviC;
//    self.window.rootViewController = homeView;
    
    [self performSelector:@selector(aaaa) withObject:nil afterDelay:0.5];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)aaaa
{
    if (1==2) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        LoginViewController *loginView = [story instantiateViewControllerWithIdentifier:@"login"];
        [[QHSliderViewController sharedSliderController].navigationController presentViewController:loginView animated:YES completion:nil];
        
//        [[QHSliderViewController sharedSliderController].navigationController pushViewController:loginView animated:YES];
      
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
