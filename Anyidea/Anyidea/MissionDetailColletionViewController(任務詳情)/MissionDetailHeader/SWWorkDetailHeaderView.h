//
//  SWWorkDetailHeaderView.h
//  Anyidea
//
//  Created by shingwai chan on 2018/1/27.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWWorkDetailHeaderView;
@protocol SWWorkDetailHeaderViewDelegate <NSObject>

-(void)headerViewTopViewDidClick:(UIView *)header;

@end

@interface SWWorkDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *postsJobUidLabel;
@property (weak, nonatomic) IBOutlet UILabel *postsJobtUserNmaeLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *missionTitle;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel1;
@property (weak, nonatomic) IBOutlet UILabel *workCountLabel1;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;


@property (weak, nonatomic) IBOutlet UILabel *missionTpyeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *winAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *final_inAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *submitDate;
@property (weak, nonatomic) IBOutlet UILabel *votingDate;


@property (weak, nonatomic) IBOutlet UILabel *missionBackgroundDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *missionRequirementsLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
+(instancetype)workDetailHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *workCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *missionRequirementsLabelConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *missionBackgroundDetailLabelConstraintHeight;

@property (nonatomic, weak) id<SWWorkDetailHeaderViewDelegate> delegate;


@end
