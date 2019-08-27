//
//  MissionWorkModel.m
//  Anyidea
//
//  Created by shingwai chan on 18/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "MissionWorkModel.h"
#import "MJExtension.h"

@implementation MissionWorkModel

-(instancetype)initWithJsonToModel:(NSDictionary *)dic{
    if (self = [super init]) {
        self = [MissionWorkModel mj_objectWithKeyValues:dic];
        self.postWorkUser = [UserModel mj_objectWithKeyValues:dic[@"user"]];
    }
    
    return self;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"work_id":@"id",
             @"created_date":@"created_at.date",
             @"timezone_type":@"created_at.timezone_type",
             @"timezone":@"created_at.timezone"
             };
}

@end
