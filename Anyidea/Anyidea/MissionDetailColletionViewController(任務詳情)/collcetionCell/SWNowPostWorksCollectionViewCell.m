//
//  SWNowPostWorksCollectionViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/22.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWNowPostWorksCollectionViewCell.h"
#import "SWScreenHelper.h"

@interface SWNowPostWorksCollectionViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jobImageViewHeightConstrains;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jobImageViewWidthtConstrains;
@property (weak, nonatomic) IBOutlet UILabel *winner_final_Label;
@property (weak, nonatomic) IBOutlet UIButton *is_protected_btn;
@property (weak, nonatomic) IBOutlet UIImageView *winner_final_ImageView;
@end


@implementation SWNowPostWorksCollectionViewCell

//self = [[NSBundle mainBundle]loadNibNamed:@"SWNowPostWorksTableViewCell" owner:nil options:nil].lastObject;
//dequeueReusableCellWithIdentifier:這個方法會自動加載xib，不用再用上面那個方法去手動加載xib

-(void)setWinner_or_finalList:(NSString *)winner_or_final{
    _winner_or_finalList = winner_or_final;
    if ([winner_or_final isEqualToString:@"winner"]) {
        self.winner_final_ImageView.image = [UIImage imageNamed:@"winner"];
        self.winner_final_Label.text = @"中標作品";
    }else if([winner_or_final isEqualToString:@"final_list"]){
        self.winner_final_ImageView.image = [UIImage imageNamed:@"final_list"];
        self.winner_final_Label.text = @"入圍作品";
    }else{
        self.winner_final_ImageView.image = nil;
        self.winner_final_Label.text = @" ";
    }
}
-(void)setIs_protected:(BOOL)is_protected{
    _is_protected = is_protected;
    self.is_protected_btn.hidden = !is_protected;
    if (is_protected) {
        self.workImageView.image = nil;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[SWScreenHelper iphoneScreenType] isEqualToString:IPHONESE_SIZE_SCREEN]) {
        self.jobImageViewHeightConstrains.constant = 120;
        self.jobImageViewWidthtConstrains.constant = 120;
        
    }

}
- (IBAction)likeBtnDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(nowPostWorksLikeBtnDidClick:btn:)]) {
        [self.delegate nowPostWorksLikeBtnDidClick:self btn:sender];
    }
    
}

@end
