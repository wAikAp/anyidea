//
//  SWMissionWorkDetailCollectionReusableHeaderView.h
//  Anyidea
//
//  Created by shingwai chan on 2018/2/5.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWMissionWorkDetailCollectionReusableHeaderView;
@protocol SWMissionWorkDetailCollectionReusableHeaderViewDelegate<NSObject>

-(void)headerIconDidClick:(SWMissionWorkDetailCollectionReusableHeaderView *)header;

@end

@interface SWMissionWorkDetailCollectionReusableHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic, weak) id<SWMissionWorkDetailCollectionReusableHeaderViewDelegate> delegate;
@end
