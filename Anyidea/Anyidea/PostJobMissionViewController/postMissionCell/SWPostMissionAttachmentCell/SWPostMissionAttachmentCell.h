//
//  SWPostMissionAttachmentCell.h
//  Anyidea
//
//  Created by shingwai chan on 18/3/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SWPostMissionAttachmentCell;
@protocol SWPostMissionAttachmentCellDelegate <NSObject>
@optional
-(void)postMissionAttachmentBtnDidClick:(SWPostMissionAttachmentCell *)cell attBtn:(UIButton *)attBtn;

@end

@interface SWPostMissionAttachmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *attBtn;
@property (nonatomic, strong) UIImage *attImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attBtnHightConstraint;
@property (nonatomic, weak) id<SWPostMissionAttachmentCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
