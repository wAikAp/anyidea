//
//  SWUserCenterHeaderView.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/21.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWUserCenterHeaderView.h"
#import "SWScreenHelper.h"

@interface SWUserCenterHeaderView ()


@end

@implementation SWUserCenterHeaderView


+(instancetype)userCenterHeaderView
{
    SWUserCenterHeaderView *header = [[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] instantiateWithOwner:nil options:nil][0];
    header.IntroductionBtn.titleLabel.numberOfLines = 0;
    return header;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [SWScreenHelper viewToCircleView:self.iconBtn];
}

- (IBAction)iconBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterHeader:iconBtnDidClick:)]) {
        [self.delegate userCenterHeader:self iconBtnDidClick:sender];
    }
}

- (IBAction)introcutionBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterHeader:introcutionBtnDidClick:introcutionLabel:)]) {
        [self.delegate userCenterHeader:self introcutionBtnDidClick:sender introcutionLabel:self.introductionLabel];
    }
}
- (IBAction)submitedJobsBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterHeader:submitedJobsBtnDidClick:)]) {
        [self.delegate userCenterHeader:self submitedJobsBtnDidClick:sender];
    }
}
- (IBAction)logoutBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterHeader:logoutBtnDidClick:)]) {
        [self.delegate userCenterHeader:self logoutBtnDidClick:sender];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
