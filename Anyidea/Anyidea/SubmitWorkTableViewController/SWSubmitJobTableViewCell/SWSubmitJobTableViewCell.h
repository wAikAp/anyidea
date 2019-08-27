//
//  SWSubmitJobTableViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 2018/7/7.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWSubmitJobTableViewCellDelegate <NSObject>

-(void)submitJobCelldidClickAttBtn:(UIButton *)btn;


@end

@interface SWSubmitJobTableViewCell : UITableViewCell
@property (nonatomic, weak) id<SWSubmitJobTableViewCellDelegate> delegate;
@end
