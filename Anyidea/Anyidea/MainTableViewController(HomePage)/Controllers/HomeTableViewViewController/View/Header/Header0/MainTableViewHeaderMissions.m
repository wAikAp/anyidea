//
//  MainTableViewHeaderMissions.m
//  Anyidea
//
//  Created by shingwai chan on 2017/12/1.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import "MainTableViewHeaderMissions.h"
#import "SWScreenHelper.h"


@implementation MainTableViewHeaderMissions

+(MainTableViewHeaderMissions *)mainTableViewHeaderMissions
{
    MainTableViewHeaderMissions *header = [[NSBundle mainBundle]loadNibNamed:@"MainTableViewHeaderMissions" owner:nil options:nil].firstObject;
    
    header.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, header.frame.size.height);
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, header.frame.size.width, header.frame.size.height);
    [header addSubview:effectView];
    [header bringSubviewToFront:header.titleLabel];
    [header bringSubviewToFront:header.RedPointImageView];
    [header bringSubviewToFront:header.greenPointImageView];
    [header bringSubviewToFront:header.yellowPointImageView];
    [header bringSubviewToFront:header.label1];
    [header bringSubviewToFront:header.label2];
    [header bringSubviewToFront:header.label3];
    
    CGFloat titleFont;
    CGFloat labelFont;
    NSString *screenType = [SWScreenHelper iphoneScreenType];
    //iphoneSE
    if ([screenType isEqualToString:IPHONESE_SIZE_SCREEN]  ) {
        titleFont = 14;
        labelFont = 12;

    }else{
        titleFont = 16;
        labelFont = 13;
    }
    header.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    header.label1.font = [UIFont systemFontOfSize:labelFont];
    header.label2.font = [UIFont systemFontOfSize:labelFont];
    header.label3.font = [UIFont systemFontOfSize:labelFont];
    return header;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
