//
//  SWPostMissionStepThreeTableViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/4/9.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWPostMissionStepThreeTableViewCell.h"

@implementation SWPostMissionStepThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipsLabel.text = @"小提示:\n您的任務款項全額預付到anyidea後，ANYIDEA便會於24小時內公佈此任務。 anyidea 為確保「交易平台」的原意不被濫用，並保護創意人應有合理的回報，現設定最低收費一項。因創意的價值並無規範，所以 Anyidea 會以每個任務的複雜性作出衡量。如有不合理情況，anyidea會向客戶的獎金提出建議，並有權拒絕該任務的發放。低於 HKD$1800 的任務將會被 anyidea 重新審視，客戶或需增加款項或修改項目。";
    self.tips2Label.text = @"部份項目最低獎金為:\nHKD$1800 ：Logo\nHKD$2300： Logo + Namecard\nHKD$3000： Logo + Namecard + Letterhead + Envelope";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    
}
- (IBAction)nextBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(postMissionStepThreeCell:nextBtnDidClick:)]) {
        [self.delegate postMissionStepThreeCell:self nextBtnDidClick:sender];
    }
}

@end
