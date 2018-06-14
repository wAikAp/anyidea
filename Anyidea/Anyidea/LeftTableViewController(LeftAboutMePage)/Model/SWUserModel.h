//
//  SWUserModel.h
//  Anyidea
//
//  Created by shingwai chan on 2018/5/22.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SWUserModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *token;

+(instancetype)userModel;

@end
