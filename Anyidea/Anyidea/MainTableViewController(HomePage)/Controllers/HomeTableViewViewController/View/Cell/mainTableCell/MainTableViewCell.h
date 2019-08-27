//
//  MainTableViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 2017/11/13.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImage *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *workTitle;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



@end
