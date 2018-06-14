//
//  SWBannerModel.m
//  Anyidea
//
//  Created by shingwai chan on 2018/5/22.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWBannerModel.h"
#import "MJExtension.h"

@implementation SWBannerModel

+(instancetype)bannerModelWithDic:(NSDictionary *)dic
{
    SWBannerModel *model  = [SWBannerModel mj_objectWithKeyValues:dic];
    
    return model;
}
@end
