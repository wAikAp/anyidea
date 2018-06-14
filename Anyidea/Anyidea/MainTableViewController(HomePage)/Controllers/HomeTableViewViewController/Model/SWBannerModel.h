//
//  SWBannerModel.h
//  Anyidea
//
//  Created by shingwai chan on 2018/5/22.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWBannerModel : NSObject
@property (nonatomic, copy) NSString *url;
+(instancetype)bannerModelWithDic:(NSDictionary *)dic;

@end
