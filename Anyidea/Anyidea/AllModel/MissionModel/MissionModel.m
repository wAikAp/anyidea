//
//  MissionModel.m
//  Anyidea
//
//  Created by shingwai chan on 15/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "MissionModel.h"
#import "MJExtension.h"

@implementation MissionModel

-(instancetype)initWithJsonToModel:(NSDictionary *)dic{
    
    if (self = [super init]) {
        self = [MissionModel mj_objectWithKeyValues:dic];
    }
    return self;
    
}

//id change to missionId 
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"missionId":@"id",
             @"submitEndDate":@"submission_ended_at.date",
             @"releasDate":@"released_at.date"
             };
}

@end
