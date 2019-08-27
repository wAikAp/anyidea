//
//  SWPostMissionTableViewCell.h
//  Anyidea
//
//  Created by shingwai chan on 2018/3/16.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWPostMissionTableViewCell;
@protocol SWPostMissionTableViewCellDelegate <NSObject>
@optional
-(void)postMissionTableCellAttBtnDidClick:(SWPostMissionTableViewCell *)cell attBtn:(UIButton *)attBtn;
-(void)postMissionTableCellTextFieldDidChangeToEditing:(SWPostMissionTableViewCell *)cell textField:(UITextField *)textField;
-(void)postMissionTableCellNextBtnDidClick:(SWPostMissionTableViewCell *)cell nextBtn:(UIButton *)nextBtn;
@end

@interface SWPostMissionTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *step;
@property (nonatomic, assign) NSInteger indxpath_Row;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic, strong) NSString *textFieldPlaceHolder;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *attBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;



@property (nonatomic, weak) id<SWPostMissionTableViewCellDelegate> delegate;

@end
