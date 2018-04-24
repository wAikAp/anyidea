//
//  SWPostMissionStepThreeTableViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/4/9.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWPostMissionStepThreeTableViewCell.h"

@implementation SWPostMissionStepThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    
}
- (IBAction)nextBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(postMissionStepThreeCell:nextBtnDidClick:)]) {
        [self.delegate postMissionStepThreeCell:self nextBtnDidClick:sender];
    }
}

@end
