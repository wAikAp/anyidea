//
//  MainTableViewHeader.h
//  Anyidea
//
//  Created by shingwai chan on 2017/11/20.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewHeader : UIView

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *BodyLable;

+(MainTableViewHeader *)mainTableViewHeader;


@end
