//1111222
//  SWWorkDetailTableViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 2018/1/22.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWWorkDetailTableViewCell;
@protocol SWWorkDetailTableViewCellDelegate <NSObject>

//-(void)detailViewY:(CGFloat)y;

@end

@interface SWWorkDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *imageArr;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic, weak) id<SWWorkDetailTableViewCellDelegate> detailViewDelegate;

@end
