//
//  SWPortfolioCollectionViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 2018/2/2.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWPortfolioCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *jobImageView;
@property (weak, nonatomic) IBOutlet UILabel *jobTitle;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (nonatomic, assign) BOOL is_protected;
@property (weak, nonatomic) IBOutlet UIButton *priveateBtn;

@end
