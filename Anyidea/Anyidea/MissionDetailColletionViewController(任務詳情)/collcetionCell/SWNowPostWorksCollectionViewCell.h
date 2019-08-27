//
//  SWNowPostWorksCollectionViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 2018/1/22.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWNowPostWorksCollectionViewCell;
@protocol SWNowPostWorksCollectionViewCellDelegate <NSObject>

-(void)nowPostWorksLikeBtnDidClick:(SWNowPostWorksCollectionViewCell *)cell btn:(UIButton *)btn;

@end

@interface SWNowPostWorksCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *workTitle;
@property (weak, nonatomic) IBOutlet UIImageView *workImageView;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel;
@property (weak, nonatomic) IBOutlet UIButton *voteBtn;
@property (nonatomic, copy) NSString *winner_or_finalList;
@property (nonatomic, assign) BOOL is_protected;
@property (nonatomic, copy) NSString *workid;
@property (nonatomic, weak) id<SWNowPostWorksCollectionViewCellDelegate> delegate;

@end
