//
//  SWPostMissionTableViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/3/16.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWPostMissionTableViewCell.h"


@interface SWPostMissionTableViewCell()<UITextFieldDelegate>


@end
@implementation SWPostMissionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineView.backgroundColor = [UIColor grayColor];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChangeToEditing) forControlEvents:UIControlEventEditingDidBegin];
    [self.textField addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEnd];
    
}

-(void)textFieldDidChangeToEditing{
    self.lineView.backgroundColor = [UIColor redColor];
    if ([self.delegate respondsToSelector:@selector(postMissionTableCellTextFieldDidChangeToEditing:textField: )]) {
        [self.delegate postMissionTableCellTextFieldDidChangeToEditing:self textField:self.textField];
    }
}
-(void)textFieldDidEndEditing{
    self.lineView.backgroundColor = [UIColor grayColor];
}

- (IBAction)attBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(postMissionTableCellAttBtnDidClick:attBtn:)]) {
        [self.delegate postMissionTableCellAttBtnDidClick:self attBtn:sender];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.step isEqualToString:@"step2"]) {
        return NO;
    }
    return YES;
}
- (IBAction)nextBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(postMissionTableCellNextBtnDidClick:nextBtn:)]) {
        [self.delegate postMissionTableCellNextBtnDidClick:self nextBtn:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
    // Configure the view for the selected state
}

@end
