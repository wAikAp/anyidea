//
//  SWSubmitJobHeader.m
//  Anyidea
//
//  Created by shingwai chan on 2018/7/7.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWSubmitJobHeader.h"
@interface SWSubmitJobHeader()
@property (weak, nonatomic) IBOutlet UILabel *missionFixLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateFixLabel;
@property (weak, nonatomic) IBOutlet UILabel *missionBonusFixLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *idFxLabel;

@end

@implementation SWSubmitJobHeader

+(instancetype)submitHeader{
    return [[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] instantiateWithOwner:nil options:nil][0];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.dateFixLabel.text = @"投稿日期至:";
    self.missionFixLabel.text = @"任務標題:";
    self.missionBonusFixLabel.text = @"中標獎金:";
    self.idFxLabel.text = @"JobID:";
    self.tipsLabel.text = @"小提示:\n請上載原創作品。\nAnyidea 為確保「交易平台」的原意不被濫用，我們保留對提交作品參賽的最終決定權。";
    
//    self.missionTitle.text = @"Logo & Banner Desig";
//    self.missionDate.text = @"1 week from now 2018-07-14 23:59:59";
//    self.bonusTitle.text = @"HK$1000";
    
}

@end
