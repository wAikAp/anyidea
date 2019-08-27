//
//  SWWorkManagementViewHeader.m
//  Anyidea
//
//  Created by shingwai chan on 2018/4/9.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWWorkManagementViewHeader.h"

@implementation SWWorkManagementViewHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)workManagementViewHeader
{
    SWWorkManagementViewHeader *header = [[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] instantiateWithOwner:nil options:nil][0];
    header.autoresizingMask = UIViewAutoresizingNone;
    return header;
}

@end
