//
//  SWHotMissionView.m
//  Anyidea
//
//  Created by shingwai chan on 2017/12/18.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import "SWHotMissionViewCell.h"
#import "Masonry.h"
#import "SWScreenHelper.h"

@interface SWHotMissionViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraints;

@end

@implementation SWHotMissionViewCell


-(void)layoutSubviews
{
    [super layoutSubviews];
    if ([[SWScreenHelper iphoneScreenType] isEqualToString:IPHONESE_SIZE_SCREEN]) {
        self.imageWidthConstraints.constant = 60;
        self.imageHeightConstraints.constant = 60;
    }
}

@end
