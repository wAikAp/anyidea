//
//  SWPostMissionTableViewHeader.m
//  Anyidea
//
//  Created by shingwai chan on 2018/3/16.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWPostMissionTableViewHeader.h"

@implementation SWPostMissionTableViewHeader

//237 28 36
+(instancetype)postMissionTableViewHeaderAndStep:(NSInteger)step
{
    SWPostMissionTableViewHeader *header = [[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] instantiateWithOwner:nil options:nil][0];
    CGFloat raduis = 3;
    header.progressView1.layer.cornerRadius = raduis;
    header.progressView1.layer.masksToBounds = YES;
    header.progressView2.layer.cornerRadius = raduis;
    header.progressView2.layer.masksToBounds = YES;
    header.progressView3.layer.cornerRadius = raduis;
    header.progressView3.layer.masksToBounds = YES;
    header.progressView4.layer.cornerRadius = raduis;
    header.progressView4.layer.masksToBounds = YES;
    
    switch (step) {
        case 1:
            header.title.text = @"STEP1:基本信息";
            header.progressView1.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(28)/255.0 blue:(36)/255.0 alpha:1.0];
            break;
        case 2:
            header.title.text = @"STEP2:分配時間";
            header.progressView2.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(28)/255.0 blue:(36)/255.0 alpha:1.0];
            break;
        case 3:
            header.title.text = @"STEP3:獎金設定";
            header.progressView3.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(28)/255.0 blue:(36)/255.0 alpha:1.0];
            break;
        case 4:
            header.title.text = @"LAST:確認任務";
            header.progressView1.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(28)/255.0 blue:(36)/255.0 alpha:1.0];
             header.progressView2.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(28)/255.0 blue:(36)/255.0 alpha:1.0];
             header.progressView3.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(28)/255.0 blue:(36)/255.0 alpha:1.0];
            break;
        default:
            break;
    }
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
