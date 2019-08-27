//
//  SWSubmitJobHeader.h
//  Anyidea
//
//  Created by shingwai chan on 2018/7/7.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWSubmitJobHeader : UIView


@property (weak, nonatomic) IBOutlet UILabel *missionTitle;
@property (weak, nonatomic) IBOutlet UILabel *missionDate;
@property (weak, nonatomic) IBOutlet UILabel *bonusTitle;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;



@property (weak, nonatomic) IBOutlet UIImageView *missionImageView;


+(instancetype)submitHeader;

@end
