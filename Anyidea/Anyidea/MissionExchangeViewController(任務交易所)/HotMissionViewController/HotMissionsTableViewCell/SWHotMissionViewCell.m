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
#import "SWCalculateTool.h"

@interface SWHotMissionViewCell()
@property (nonatomic, strong) NSArray *statusArr;
@property (weak, nonatomic) IBOutlet UILabel *remainTimelabel;
@end
//contributing
//voting
//ended
@implementation SWHotMissionViewCell


-(void)setMissionStatus:(NSString *)missionStatus{
    _missionStatus = missionStatus;
    self.pointImageView.image = [UIImage imageNamed:missionStatus];
    
}

-(void)setMissionType:(NSString *)missionType{
    _missionType = missionType;
    [self.missionTypeBtn setTitle:missionType forState:UIControlStateNormal];
}

-(void)setSubmitEndDate:(NSString *)submitEndDate{
    _submitEndDate = submitEndDate;
    NSString *timeStr;
    NSString *time;
    NSDateComponents *cmps = [SWCalculateTool calculatTimeDiffFromCurrentToEndTime:submitEndDate];
    if (cmps.year!=0 && cmps.year >0) {
        timeStr = @"年";
        time =[NSString stringWithFormat:@"%ld",cmps.year];
    }else if (cmps.month != 0&& cmps.month>0){
        timeStr = @"月";
        time =[NSString stringWithFormat:@"%ld",cmps.month];
    }else if (cmps.day != 0 && cmps.day > 0){
        timeStr = @"日";
        time =[NSString stringWithFormat:@"%ld",cmps.day];
    }else if (cmps.hour != 0 && cmps.hour > 0){
        timeStr = @"小時";
        time =[NSString stringWithFormat:@"%ld",cmps.hour];
    }else if (cmps.minute != 0 && cmps.minute > 0){
        timeStr = @"分鐘";
        time =[NSString stringWithFormat:@"%ld",cmps.minute];
    }else if (cmps.second != 0 && cmps.second > 0){
        timeStr = @"秒";
        time =[NSString stringWithFormat:@"%ld",cmps.second];
    }else{
        time = @"已完成";
    }
    self.hourLabel.text = timeStr;
    self.remainTimelabel.text = time;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle =UITableViewCellSelectionStyleNone;
}




@end
