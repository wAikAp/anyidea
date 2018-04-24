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
@property (weak, nonatomic) IBOutlet UIImageView *jobImageView;


@property (nonatomic, weak) id<SWNowPostWorksCollectionViewCellDelegate> delegate;

@end
