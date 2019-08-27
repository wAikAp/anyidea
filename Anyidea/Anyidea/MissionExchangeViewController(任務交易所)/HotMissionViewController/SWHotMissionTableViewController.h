//
//  SWHotMissionTableViewController.h
//  Anyidea
//
//  Created by shingwai chan on 2017/12/19.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWHotMissionTableViewController;
@protocol SWHotMissionTableViewControllerDelegate <NSObject>

-(void)hotMissionTableViewControllerDidScore:(SWHotMissionTableViewController *)hotMissionVc andScrollView:(UIScrollView *)scrollView;

@end

@interface SWHotMissionTableViewController : UITableViewController
//This @property is MainNavController also is SWMissionExchangeViewController NavController
//這個navVc是父控制器  SWMissionExchangeViewController的Nav
@property (nonatomic, strong) UINavigationController *mainNavVc;

@property(nonatomic,weak) id<SWHotMissionTableViewControllerDelegate> delegate;

//When top statusBar did click run this founction also euql Scroll to top;
-(void)selectCellWithIndexPath:(NSIndexPath *)indexPath;


@end
