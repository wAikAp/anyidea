//
//  SWPortfolioCollectionViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/2.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWPortfolioCollectionViewCell.h"

@implementation SWPortfolioCollectionViewCell

-(void)setIs_protected:(BOOL)is_protected{
    _is_protected = is_protected;
    self.priveateBtn.hidden = !is_protected;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.jobImageView.layer.cornerRadius = 8;
    self.jobImageView.layer.masksToBounds = YES;
}

@end
