//
//  SWNewsTableViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 2018/2/6.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWNewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *postUserName;
+(CGFloat)newsTableCellFixHeight;
@end
