//
//  IDPAppDelegate.m
//  iOSProject
//
//  Created by Oleksa Korin on 6/8/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPAppDelegate.h"

#import "IDPUsersViewController.h"
#import "IDPUser.h"

@interface IDPAppDelegate ()

@end

@implementation IDPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    
    IDPUsersViewController *controller = [IDPUsersViewController new];
    controller.user = [IDPUser new];
    
    window.rootViewController = controller;
    window.backgroundColor = [UIColor greenColor];
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
