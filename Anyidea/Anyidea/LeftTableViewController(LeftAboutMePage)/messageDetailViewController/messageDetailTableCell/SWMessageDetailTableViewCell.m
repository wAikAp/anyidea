//
//  SWMessageDetailTableViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/6.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWMessageDetailTableViewCell.h"

@implementation SWMessageDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bonusBtn.layer.cornerRadius = 5;
    self.bonusBtn.layer.masksToBounds = YES;
    self.bonusBtn.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(15)/255.0 blue:(24)/255.0 alpha:1.0];

}

@end
