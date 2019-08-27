//
//  SWUserModel.m
//  Anyidea
//
//  Created by shingwai chan on 2018/5/22.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWUserModel.h"
#import "MJExtension.h"

@implementation SWUserModel

+(instancetype)userModel{
    NSString *jsonString = @"{\"name\":\"Jack\", \"userID\":\"1101211a\", \"token\":\"Null\"}";
    //NSLog(@"json = %@",jsonString);
    
    SWUserModel *user = [SWUserModel mj_objectWithKeyValues:jsonString];
    //NSLog(@"model = %@",user);
    return user;
    
}

@end
