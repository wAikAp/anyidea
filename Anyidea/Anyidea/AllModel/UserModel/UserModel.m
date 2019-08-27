//
//  UserModel.m
//  Anyidea
//
//  Created by shingwai chan on 12/4/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "UserModel.h"
#import "MJExtension.h"

@implementation UserModel

-(instancetype)initWithJsonToModel:(NSDictionary *)dic{
    if (self = [super init]) {
        self = [UserModel mj_objectWithKeyValues:dic];
    }
    
    return self;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"user_id":@"id"};
}

@end
