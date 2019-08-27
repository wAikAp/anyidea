//
//  LoginUser.m
//  Anyidea
//
//  Created by shingwai chan on 11/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "LoginUser.h"
#import "MJExtension.h"

@implementation LoginUser

+(instancetype)shareLogingUser{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(instancetype)initWithJsonToModel:(NSDictionary *)dic{
    
    LoginUser *usrMode = [LoginUser shareLogingUser];
    [usrMode mj_setKeyValues:[LoginUser mj_objectWithKeyValues:dic]];
    return usrMode;
}

@end
