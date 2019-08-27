//
//  SWHotMissionView.h
//  Anyidea
//
//  Created by shingwai chan on 2017/12/18.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWHotMissionViewCell: UITableViewCell

//UI
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pointImageView;
@property (weak, nonatomic) IBOutlet UIButton *missionTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *TabBtnOne;

//data
@property (nonatomic, copy) NSString *missionStatus;
@property (nonatomic, copy) NSString *submitEndDate;
@property (nonatomic, copy) NSString *missionType;

@end
