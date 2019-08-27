//
//  SWMissionWorkDetaiilTableViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 18/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWMissionWorkDetaiilTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *workImage;
@property (weak, nonatomic) IBOutlet UIButton *privateBtn;
@property (nonatomic, assign) BOOL is_protected;
@end

NS_ASSUME_NONNULL_END
