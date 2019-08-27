//
//  SWPostMissionStepFourTableViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 2018/4/9.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWPostMissionStepFourTableViewCell;
@protocol SWPostMissionStepFourTableViewCellDelegate <NSObject>

@optional
-(void)stepFourCellSubmitBtnDidClick:(SWPostMissionStepFourTableViewCell *)cell;

@end

@interface SWPostMissionStepFourTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobTitle;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *amountTitle;
@property (weak, nonatomic) IBOutlet UILabel *jobDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobPrivateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;

@property (nonatomic, weak) id<SWPostMissionStepFourTableViewCellDelegate> delegate;
@end
