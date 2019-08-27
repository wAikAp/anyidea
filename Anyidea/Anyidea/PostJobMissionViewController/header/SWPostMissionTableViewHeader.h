//
//  SWPostMissionTableViewHeader.h
//  Anyidea
//
//  Created by shingwai chan on 2018/3/16.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWPostMissionTableViewHeader : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *progressView1;
@property (weak, nonatomic) IBOutlet UIView *progressView2;
@property (weak, nonatomic) IBOutlet UIView *progressView3;
@property (weak, nonatomic) IBOutlet UIView *progressView4;

+(instancetype)postMissionTableViewHeaderAndStep:(NSInteger)step;

@end
