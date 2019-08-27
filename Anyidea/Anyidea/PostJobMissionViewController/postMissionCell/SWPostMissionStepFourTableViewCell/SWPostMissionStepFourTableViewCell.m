//
//  SWPostMissionStepFourTableViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/4/9.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWPostMissionStepFourTableViewCell.h"

@implementation SWPostMissionStepFourTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.layer.masksToBounds = YES;
}
- (IBAction)submiBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(stepFourCellSubmitBtnDidClick:)]) {
        [self.delegate stepFourCellSubmitBtnDidClick:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
