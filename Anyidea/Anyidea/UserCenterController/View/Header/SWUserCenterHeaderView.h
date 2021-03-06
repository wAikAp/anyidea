//
//  SWUserCenterHeaderView.h
//  Anyidea
//
//  Created by shingwai chan on 2018/2/21.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWUserCenterHeaderView;
@protocol SWUserCenterHeaderViewDelegate <NSObject>
//簡介按鈕事件
-(void)userCenterHeader:(SWUserCenterHeaderView *)header introcutionBtnDidClick:(UIButton *)introcutionBtn introcutionLabel:(UILabel *)introcutionLabel;
//頭像按鈕事件
-(void)userCenterHeader:(SWUserCenterHeaderView *)header iconBtnDidClick:(UIButton *)iconBtn;
//已提交作品按鈕事件
-(void)userCenterHeader:(SWUserCenterHeaderView *)header submitedJobsBtnDidClick:(UIButton *)btn;
//logout
-(void)userCenterHeader:(SWUserCenterHeaderView *)header logoutBtnDidClick:(UIButton *)btn;
@end


@interface SWUserCenterHeaderView : UIView
//頭像
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
//用戶名
@property (weak, nonatomic) IBOutlet UIButton *userNameBtn;
//簡介label
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
//讚好數量
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
//提交數量
@property (weak, nonatomic) IBOutlet UIButton *submitJobsBtn;
//炸彈數量
@property (weak, nonatomic) IBOutlet UIButton *bombBtn;
//修改簡介btn
@property (weak, nonatomic) IBOutlet UIButton *IntroductionBtn;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtnImage;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtnText;
@property (nonatomic, weak) id<SWUserCenterHeaderViewDelegate> delegate;

+(instancetype)userCenterHeaderView;

@end
