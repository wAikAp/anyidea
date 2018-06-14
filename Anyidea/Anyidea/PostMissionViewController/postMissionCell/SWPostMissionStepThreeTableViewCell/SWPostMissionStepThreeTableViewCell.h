//
//  SWPostMissionStepThreeTableViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 2018/4/9.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWPostMissionStepThreeTableViewCell;
@protocol SWPostMissionStepThreeTableViewCellDelegate<NSObject>

-(void)postMissionStepThreeCell:(SWPostMissionStepThreeTableViewCell *)cell nextBtnDidClick:(UIButton *)nextBtn;

@end

@interface SWPostMissionStepThreeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *tips2Label;

@property (nonatomic, weak) id<SWPostMissionStepThreeTableViewCellDelegate> delegate;

@end
