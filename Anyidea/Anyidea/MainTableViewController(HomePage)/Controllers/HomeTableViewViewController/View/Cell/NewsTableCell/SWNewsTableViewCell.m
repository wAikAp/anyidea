//
//  SWNewsTableViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/6.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWNewsTableViewCell.h"
#import "SWScreenHelper.h"

@implementation SWNewsTableViewCell

+(CGFloat)newsTableCellFixHeight
{
    NSString *screenType = [SWScreenHelper iphoneScreenType];
    if ([screenType  isEqualToString:IPHONEPLUSE_SIZE_SCREEN]) {//plus
        return 250;
    }else if ([screenType isEqualToString:IPHONE6_SIZE_SCREEN]){//6
        return 260;
    }else if([screenType isEqualToString:IPHONESE_SIZE_SCREEN]){//se
        return 260;
    }
    return 240;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSString *screenType = [SWScreenHelper iphoneScreenType];
    if ([screenType isEqualToString:IPHONESE_SIZE_SCREEN]) {
        self.newsTitle.font = [UIFont systemFontOfSize:14];
        self.postUserName.font = [UIFont systemFontOfSize:12];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
