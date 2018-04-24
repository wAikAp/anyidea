//
//  SWMissionWorkDetailCollectionReusableHeaderView.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/5.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWMissionWorkDetailCollectionReusableHeaderView.h"


@implementation SWMissionWorkDetailCollectionReusableHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconDidClick)];
    [self.icon addGestureRecognizer:tap];
}

-(void)iconDidClick{
    NSLog(@"click");
    if ([self.delegate respondsToSelector:@selector(headerIconDidClick:)]) {
        [self.delegate headerIconDidClick:self];
    }
}

@end
