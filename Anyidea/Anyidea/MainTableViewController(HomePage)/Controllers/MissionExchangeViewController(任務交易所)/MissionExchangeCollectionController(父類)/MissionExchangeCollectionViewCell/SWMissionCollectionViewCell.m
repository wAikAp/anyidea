
//
//  SWMissionCollectionViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2017/12/18.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import "SWMissionCollectionViewCell.h"
#import "SWNewMissionTableViewController.h"
#import "SWHotMissionTableViewController.h"
#import "SWVotingMissionTableViewController.h"

@implementation SWMissionCollectionViewCell

-(void)setNewMissionVc:(SWNewMissionTableViewController *)NewMissionVc
{
    _NewMissionVc = NewMissionVc;
   
    
    [self.contentView addSubview:NewMissionVc.view];
}

-(void)setHotMissionVc:(SWHotMissionTableViewController *)HotMissionVc
{
    _HotMissionVc = HotMissionVc;

    [self.contentView addSubview:HotMissionVc.view];
}

-(void)setVotingMissionVc:(SWVotingMissionTableViewController *)VotingMissionVc
{
    _VotingMissionVc = VotingMissionVc;

    [self.contentView addSubview:VotingMissionVc.view];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.NewMissionVc.view.frame = self.bounds;
    self.HotMissionVc.view.frame = self.bounds;
    self.VotingMissionVc.view.frame = self.bounds;
}

@end


