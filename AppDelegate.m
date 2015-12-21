//
//  AppDelegate.m
//  CRTestingProject
//
//  Created by caine on 12/10/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+CRColor.h"
#import "CRTabBarController.h"
#import "CRTestingRootViewController.h"
#import "SunDec13TestingViewController.h"

#import "CRNavigationController.h"
#import "FriDec18ViewController.h"

#import "CRTestingFunc.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CRTabBarController *CRTabBar = (CRTabBarController *)self.window.rootViewController;
    
    CRTestingRootViewController *one = ({
        CRTestingRootViewController *one = [CRTestingRootViewController new];
        one.view.backgroundColor = [UIColor CRColorType:CRColorTypeGoogleMapBlue];
        one.title = @"first";
        one;
    });
    
    CRTestingRootViewController *two = ({
        CRTestingRootViewController *two = [CRTestingRootViewController new];
        two.view.backgroundColor = [UIColor CRColorType:CRColorTypeGoogleTomato];
        two.title = @"second";
        two;
    });
    
    CRTestingRootViewController *three = ({
        CRTestingRootViewController *three = [CRTestingRootViewController new];
        three.view.backgroundColor = [UIColor CRColorType:CRColorTypeGoogleYellow];
        three.title = @"second";
        three;
    });
    
    SunDec13TestingViewController *sunDec13 = [SunDec13TestingViewController new];
    sunDec13.title = @"sunDec13";
    
    FriDec18ViewController *tabFriDec18 = [FriDec18ViewController new];
    tabFriDec18.title = @"tabFriDec18";
    
    FriDec18ViewController *friDec18 = [FriDec18ViewController new];
    friDec18.title = @"friDec18";
    CRNavigationController *navigation = [[CRNavigationController alloc] initWithRootViewController:friDec18];
    navigation.title = @"navigation";
    
    CRTabBar.items = @[ sunDec13, navigation, three, tabFriDec18 ];
    
    
    [CRTestingFunc runTesting];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
