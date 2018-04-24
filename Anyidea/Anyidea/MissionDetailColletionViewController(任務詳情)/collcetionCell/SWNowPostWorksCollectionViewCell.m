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

@end


@implementation SWNowPostWorksCollectionViewCell

//self = [[NSBundle mainBundle]loadNibNamed:@"SWNowPostWorksTableViewCell" owner:nil options:nil].lastObject;
//dequeueReusableCellWithIdentifier:這個方法會自動加載xib，不用再用上面那個方法去手動加載xib

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
