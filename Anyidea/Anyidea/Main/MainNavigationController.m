//
//  MainNavigationController.m
//  Anyidea
//
//  Created by shingwai chan on 2017/11/20.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import "MainNavigationController.h"
#import "UIViewController+MMDrawerController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(void)initialize
{
    if (self == [MainNavigationController class]) {
        UINavigationBar *navbar = [UINavigationBar appearance];
        navbar.barStyle = UIBarStyleBlack;
//        [navbar setBackgroundColor:[UIColor colorWithRed:(237)/255.0 green:(15)/255.0 blue:(24)/255.0 alpha:1.0]];
        navbar.barTintColor = [UIColor colorWithRed:(237)/255.0 green:(15)/255.0 blue:(24)/255.0 alpha:1.0];
        navbar.tintColor = [UIColor whiteColor];
//        navbar.translucent = NO;
        
//
//        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//
//        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//            statusBar.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(15)/255.0 blue:(24)/255.0 alpha:1.0];
//        }
        
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
}

@end
