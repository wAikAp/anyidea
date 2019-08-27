//
//  SWPostMissionAttachmentCell.m
//  Anyidea
//
//  Created by shingwai chan on 18/3/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "SWPostMissionAttachmentCell.h"
#import "UIView+Extension.h"

@implementation SWPostMissionAttachmentCell
-(void)setAttImage:(UIImage *)attImage{
    _attImage = attImage;
    [self.attBtn setImage:attImage forState:UIControlStateNormal];
    [self layoutSubviews]; 
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.attBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (IBAction)attBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(postMissionAttachmentBtnDidClick:attBtn:)]) {
        [self.delegate postMissionAttachmentBtnDidClick:self attBtn:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
