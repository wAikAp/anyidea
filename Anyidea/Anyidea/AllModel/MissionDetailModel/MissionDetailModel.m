//
//  MissionJobModel.m
//  Anyidea
//
//  Created by shingwai chan on 16/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "MissionDetailModel.h"
#import "MJExtension.h"

@implementation MissionDetailModel

-(instancetype)initWithJsonToModel:(NSDictionary *)dic{
    if (self = [super init]) {
        self = [MissionDetailModel mj_objectWithKeyValues:dic];
        self.postsJobUser = [[UserModel alloc]initWithJsonToModel:dic[@"user"]];
    }
    
    return self;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"job_id":@"id",
             @"submit_date":@"submission_ended_at.date",
             @"release_date":@"released_at.date"
             };
}



@end
