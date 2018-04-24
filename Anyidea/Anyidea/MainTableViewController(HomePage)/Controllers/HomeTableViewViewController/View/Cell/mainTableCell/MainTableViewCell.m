//
//  MainTableViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2017/11/13.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import "MainTableViewCell.h"
//#import "Masonry.h"
#import "SWScreenHelper.h"

@interface MainTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end


@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.priceLabel setFont:[UIFont boldSystemFontOfSize:32]];
}

-(void)setPhotoImage:(UIImage *)photoImage
{
    _photoImage = photoImage;
    self.photoImageView.image = photoImage;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat titleFont;
    CGFloat bodyFont;
    CGFloat priceFont;
    if ([[SWScreenHelper iphoneScreenType] isEqualToString:IPHONESE_SIZE_SCREEN]) {
        titleFont = 15;
        bodyFont = 13;
        priceFont = 18;
    }else
    {
        titleFont = 17;
        bodyFont = 14;
        priceFont = 20;
    }
    self.typeLabel.font = [UIFont boldSystemFontOfSize:bodyFont];
    self.workTitle.font = [UIFont boldSystemFontOfSize:titleFont];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:priceFont];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
