//
//  SWMissionWorkDetailHeader.h
//  Anyidea
//
//  Created by shingwai chan on 18/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SWMissionWorkDetailHeader;
@protocol SWMissionWorkDetailHeaderDelegate <NSObject>

-(void)headerViewTopViewDidClick:(UIView *)header;

@end

@interface SWMissionWorkDetailHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIButton *winTag;
@property (weak, nonatomic) IBOutlet UILabel *workTitle;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *workTitleDisplay;
@property (weak, nonatomic) IBOutlet UILabel *descDisplay;

+(instancetype)missionWorkDetailHeader;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *workIdLabel;
@property (nonatomic, weak) id<SWMissionWorkDetailHeaderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
