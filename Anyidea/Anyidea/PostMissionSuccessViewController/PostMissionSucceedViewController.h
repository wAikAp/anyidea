//
//  PostMissionSucceedViewController.h
//  Anyidea
//
//  Created by shingwai chan on 18/3/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostMissionSucceedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *submitEndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobVibLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobAmountLabel;


@property (nonatomic, copy) NSString *jobTitleLabelStr;
@property (nonatomic, copy) NSString *jobTypeLabelStr;
@property (nonatomic, copy) NSString *companyNameLabelStr;
@property (nonatomic, copy) NSString *submitEndDateLabelStr;
@property (nonatomic, copy) NSString *finalLabelStr;
@property (nonatomic, copy) NSString *jobVibLabelStr;
@property (nonatomic, copy) NSString *jobAmountLabelStr;

@end

NS_ASSUME_NONNULL_END
