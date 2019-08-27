//
//  SearchFooterView.m
//  Anyidea
//
//  Created by shingwai chan on 28/4/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "SearchFooterView.h"

@implementation SearchFooterView

+(instancetype)searchFooterView{
    return [[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] instantiateWithOwner:nil options:nil][0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
