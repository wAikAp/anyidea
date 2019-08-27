//
//  MissionWorkModel.h
//  Anyidea
//
//  Created by shingwai chan on 18/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MissionWorkModel : NSObject

@property (nonatomic, copy) NSString *work_id;
@property (nonatomic, copy) NSString *work_title;
@property (nonatomic, copy) NSString *created_date;
@property (nonatomic, copy) NSString *timezone_type;
@property (nonatomic, copy) NSString *timezone;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *votes;
@property (nonatomic, copy) NSString *work_description;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *attachment_url;
@property (nonatomic, assign) BOOL is_protected;
@property (nonatomic, assign) BOOL is_winner;
@property (nonatomic, assign) BOOL is_finalist;
@property (nonatomic, assign) BOOL can_vote;
@property (nonatomic, strong) UserModel *postWorkUser;

-(instancetype)initWithJsonToModel:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
