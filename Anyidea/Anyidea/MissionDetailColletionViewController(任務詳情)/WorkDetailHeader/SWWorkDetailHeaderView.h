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

@property (weak, nonatomic) IBOutlet UILabel *missionBackgroundDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *missionRequirementsLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
+(instancetype)workDetailHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *workNumberLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *missionRequirementsLabelConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *missionBackgroundDetailLabelConstraintHeight;

@property (nonatomic, weak) id<SWWorkDetailHeaderViewDelegate> delegate;


@end
