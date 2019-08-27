//
//  SWNewMissionTableViewController.h
//  Anyidea
//
//  Created by shingwai chan on 2017/12/18.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWNewMissionTableViewController;

@protocol SWNewMissionTableViewControllerDelegate <NSObject>

-(void)missionTableViewControllerDidScroll:(SWNewMissionTableViewController *)newMissionVC andScrollView:(UIScrollView *)scrollView;



@end


@interface SWNewMissionTableViewController : UITableViewController

//This @property is MainNavController also is SWMissionExchangeViewController NavController
//這個navVc是父控制器  SWMissionExchangeViewController的Nav
@property (nonatomic, strong) UINavigationController *mainNavVc;

//delegate
@property (nonatomic, weak) id<SWNewMissionTableViewControllerDelegate> delegate;

//When top statusBar did click run this founction also euql Scroll to top;
-(void)selectCellWithIndexPath:(NSIndexPath *)indexPath;

@end
