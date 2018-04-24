//
//  AppDelegate.m
//  Anyidea
//
//  Created by shingwai chan on 2017/11/8.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MainNavigationController.h"
#import "SWPostMissionViewController.h"
#import "IQKeyboardManager.h"
#import "SWPostMissionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    UITabBarController *centerVC = [storyBoard instantiateViewControllerWithIdentifier:@"MainTabBarVC"];
    SWPostMissionViewController *postMissionVc = [[SWPostMissionViewController alloc]init];
    
    [centerVC addChildViewController:[[UINavigationController alloc]initWithRootViewController:postMissionVc]];
    postMissionVc.tabBarItem.title = @"發佈任務";
    postMissionVc.tabBarItem.image = [UIImage imageNamed:@"PostItem"];
    centerVC.selectedIndex = 1;
    
    UIViewController *aboutMeVc = [storyBoard instantiateViewControllerWithIdentifier:@"MainLeftVC"];
    
    UIViewController *menuVc = [storyBoard instantiateViewControllerWithIdentifier:@"MainRightVC"];
    
    MMDrawerController *drawerController = [[MMDrawerController alloc]initWithCenterViewController:centerVC leftDrawerViewController:aboutMeVc rightDrawerViewController:menuVc];
    
    
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [drawerController setShowsShadow:YES];
    [drawerController setMaximumRightDrawerWidth:[UIScreen mainScreen].bounds.size.width *2.3/5];
    [drawerController setMaximumLeftDrawerWidth:[UIScreen mainScreen].bounds.size.width *2/3 ];
    drawerController.shadowRadius = 1;
    drawerController.shadowOpacity = 1;
    /*
     +(MMDrawerControllerDrawerVisualStateBlock)slideAndScaleVisualStateBlock;
     //滑动渐现
     +(MMDrawerControllerDrawerVisualStateBlock)slideVisualStateBlock;
     //立方动画
     +(MMDrawerControllerDrawerVisualStateBlock)swingingDoorVisualStateBlock;
     //视差动画
     +(MMDrawerControllerDrawerVisualStateBlock)parallaxVisualStateBlockWithParallaxFactor:(CGFloat)parallaxFactor;
     */
    [drawerController setDrawerVisualStateBlock:[MMDrawerVisualState slideVisualStateBlock]];
    

    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    window.rootViewController = drawerController;
    [window makeKeyAndVisible];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
