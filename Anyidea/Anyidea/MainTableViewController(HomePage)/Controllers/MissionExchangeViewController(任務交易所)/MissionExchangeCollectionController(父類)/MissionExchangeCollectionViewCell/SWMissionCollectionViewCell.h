//
//  SWMissionCollectionViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 2017/12/18.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWNewMissionTableViewController;
@class SWHotMissionTableViewController;
@class SWVotingMissionTableViewController;

@interface SWMissionCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)SWNewMissionTableViewController *NewMissionVc;
@property (nonatomic, strong) SWHotMissionTableViewController *HotMissionVc;
@property (nonatomic, strong) SWVotingMissionTableViewController *VotingMissionVc;
@end
