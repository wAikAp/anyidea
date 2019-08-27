//
//  LoginUserTokenInfo.m
//  Anyidea
//
//  Created by shingwai chan on 17/12/2018.
//  Copyright © 2018 shingwai chan. All rights reserved.
//

#import "LoginUserTokenInfo.h"
#import "MJExtension.h"

@implementation LoginUserTokenInfo

+(instancetype)shareLogingUsrToken{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/*
+(instancetype)loginUsrToken:(NSDictionary *)dic{

    LoginUserTokenInfo *userTkn =[LoginUserTokenInfo mj_objectWithKeyValues:dic];
    return userTkn;
}
*/

-(instancetype)initWithJsonToModel:(NSDictionary *)dic{
    
    LoginUserTokenInfo *usrTkoMde = [LoginUserTokenInfo shareLogingUsrToken];
    LoginUserTokenInfo *model = [LoginUserTokenInfo mj_objectWithKeyValues:dic];
    [usrTkoMde mj_setKeyValues:model];
    return usrTkoMde;
}


@end
