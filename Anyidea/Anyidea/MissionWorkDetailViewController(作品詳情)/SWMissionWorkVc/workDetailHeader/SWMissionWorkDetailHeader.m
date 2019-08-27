//
//  SWMissionWorkDetailHeader.m
//  Anyidea
//
//  Created by shingwai chan on 18/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "SWMissionWorkDetailHeader.h"
#import "SWScreenHelper.h"

@implementation SWMissionWorkDetailHeader

+(instancetype)missionWorkDetailHeader
{
    return [[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] instantiateWithOwner:nil options:nil][0];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [SWScreenHelper viewToCircleView:self.icon];
}
- (IBAction)headButtonDidClick:(UIButton *)sender {
    [self headerViewDidClick:self];
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
