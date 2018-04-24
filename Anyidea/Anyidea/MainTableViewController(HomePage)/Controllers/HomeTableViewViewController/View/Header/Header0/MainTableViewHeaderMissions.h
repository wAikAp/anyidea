//
//  MainTableViewHeaderMissions.h
//  Anyidea
//
//  Created by shingwai chan on 2017/12/1.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewHeaderMissions : UIView
@property (weak, nonatomic) IBOutlet UIImageView *greenPointImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *yellowPointImageView;
@property (weak, nonatomic) IBOutlet UIImageView *RedPointImageView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

+(MainTableViewHeaderMissions *)mainTableViewHeaderMissions;


@end
