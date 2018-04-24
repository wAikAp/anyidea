//
//  MainTableViewHeader.m
//  Anyidea
//
//  Created by shingwai chan on 2017/11/20.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import "MainTableViewHeader.h"
#import "SWScreenHelper.h"

@implementation MainTableViewHeader
+(MainTableViewHeader *)mainTableViewHeader
{
    MainTableViewHeader *header = [[NSBundle mainBundle]loadNibNamed:@"MainTableViewHeader" owner:nil options:nil].firstObject;

    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, header.frame.size.width, header.frame.size.height);
    [header addSubview:effectView];
    [header bringSubviewToFront:header.TitleLabel];
    [header bringSubviewToFront:header.BodyLable];
    
    CGFloat titleFont;
    CGFloat bodyFont;
    NSString *screenType = [SWScreenHelper iphoneScreenType];
    //iphoneSE
    if ([screenType isEqualToString:IPHONESE_SIZE_SCREEN]  ) {
        titleFont = 14.f;
        bodyFont = 12.f;
    }else{
        titleFont = 16.f;
        bodyFont = 13.f;
    }
    header.TitleLabel.font = [UIFont systemFontOfSize:titleFont];
    header.BodyLable.font  =[UIFont systemFontOfSize:bodyFont];
    
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
