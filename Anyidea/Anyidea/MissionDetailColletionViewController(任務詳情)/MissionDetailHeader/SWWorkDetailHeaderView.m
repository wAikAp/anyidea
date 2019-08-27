//
//  SWWorkDetailHeaderView.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/27.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWWorkDetailHeaderView.h"
#import "SWScreenHelper.h"

@interface SWWorkDetailHeaderView()
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation SWWorkDetailHeaderView

+(instancetype)workDetailHeaderView
{
    return [[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] instantiateWithOwner:nil options:nil][0];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewDidClick:)];
    [SWScreenHelper viewToCircleView:self.iconImageView];
    [self.topView addGestureRecognizer:tap];
}

-(void)headerViewDidClick:(UIView *)topHeaderView{
    
    if ([self.delegate respondsToSelector:@selector(headerViewTopViewDidClick:)]) {
        [self.delegate headerViewTopViewDidClick:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
