//
//  SWUserCenterHeaderView.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/21.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWUserCenterHeaderView.h"

@interface SWUserCenterHeaderView ()


@end

@implementation SWUserCenterHeaderView


+(instancetype)userCenterHeaderView
{
    SWUserCenterHeaderView *header = [[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] instantiateWithOwner:nil options:nil][0];
    header.IntroductionBtn.titleLabel.numberOfLines = 0;
    return header;
}
- (IBAction)iconBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterHeader:iconBtnDidClick:)]) {
        [self.delegate userCenterHeader:self iconBtnDidClick:sender];
    }
}

- (IBAction)introcutionBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterHeader:introcutionBtnDidClick:)]) {
        [self.delegate userCenterHeader:self introcutionBtnDidClick:sender];
    }
}
- (IBAction)submitedJobsBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterHeader:submitedJobsBtnDidClick:)]) {
        [self.delegate userCenterHeader:self submitedJobsBtnDidClick:sender];
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
