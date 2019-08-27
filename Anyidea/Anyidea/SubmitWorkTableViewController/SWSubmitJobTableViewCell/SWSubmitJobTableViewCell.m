//
//  SWSubmitJobTableViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/7/7.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWSubmitJobTableViewCell.h"
#import "MissionWorkModel.h"
#import "UIView+Extension.h"

@interface SWSubmitJobTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *workTitleLbael;
@property (weak, nonatomic) IBOutlet UILabel *workAttachmentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *workDescriptionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *attachmentBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *attTipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicTipsLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *publicSwichBtn;
@property (weak, nonatomic) IBOutlet UITextView *workDescTextView;
@property (weak, nonatomic) IBOutlet UITextField *workTitleTextFiled;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;

@end


@implementation SWSubmitJobTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagePickerVcFinishedPickCallBack:) name:@"imagePickerVcFinishedPickCallBack" object:nil];
    self.textView.layer.borderColor = [UIColor colorWithRed:(235)/255.0 green:(235)/255.0 blue:(235)/255.0 alpha:1].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.cornerRadius = 6;
    self.textView.layer.masksToBounds = YES;
    
    self.workTitleLbael.text = @"作品名稱";
    self.workAttachmentTitleLabel.text = @"作品附件";
    self.workDescriptionTitleLabel.text = @"作品描述";
    self.publicTitleLabel.text = @"作品顯示";
    self.publicTipsLabel.text = @"除此任務發佈者外，是否讓其它登記用戶檢視此作品，此可增加其它用戶對您的認識。\n保密只限於投稿中狀態，任務結束投稿所有作品均會開放展示。";
    self.attTipsLabel.text = @" ";
    NSArray *segmentArr = @[@"公開",@"保密"];
    for (int i = 0; i < segmentArr.count; ++i) {
        [self.publicSwichBtn setTitle:segmentArr[i] forSegmentAtIndex:i];
    }
    
    
    
}
-(void)imagePickerVcFinishedPickCallBack:(NSNotification *)notif{
    UIImage *image = notif.object;
    [self.attachmentBtn setImage:image forState:UIControlStateNormal];
    self.attachmentBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.attachmentBtn setTitle:@"" forState:UIControlStateNormal];
    self.attBtnWidth.constant = 120.f;
    self.attBtnHeight.constant = 120.f;
    self.textViewHeight.constant = 100.f;
    self.attTipsLabel.text = @"再次點擊圖片可以換另一張";
    
    [self layoutSubviews];
}

- (IBAction)attBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(submitJobCelldidClickAttBtn:)]) {
         [self.delegate submitJobCelldidClickAttBtn:sender];
        
    }
    
}
- (IBAction)submitDidClick:(UIButton *)sender {
    MissionWorkModel *workModel = [[MissionWorkModel alloc]init];
    workModel.work_title = self.workTitleTextFiled.text;
    workModel.work_description = self.workDescTextView.text;
    workModel.is_protected = self.publicSwichBtn.selectedSegmentIndex;//0:public 1:pravite
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubmiWorkCellSubmitBtnDidClick" object:workModel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
