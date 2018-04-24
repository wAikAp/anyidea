//
//  SWMessageDetailViewHeader.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/12.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWMessageDetailViewHeader.h"
#import "Masonry.h"
#import "SWScreenHelper.h"

@implementation SWMessageDetailViewHeader

+(instancetype)messageDetailViewHeader
{
    SWMessageDetailViewHeader * header  = [[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] instantiateWithOwner:nil options:nil][0];

    return header;
}
- (void)awakeFromNib {
    [super awakeFromNib ];
    self.autoresizingMask = UIViewAutoresizingNone;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
