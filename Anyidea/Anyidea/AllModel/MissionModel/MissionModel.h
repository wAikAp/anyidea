//
//  MissionModel.h
//  Anyidea
//
//  Created by shingwai chan on 15/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MissionModel : NSObject

@property (nonatomic, copy) NSString *missionId;
@property (nonatomic, copy) NSString *job_title;
@property (nonatomic, copy) NSString *reward_amount;
@property (nonatomic, copy) NSString *job_type;
@property (nonatomic, copy) NSString *works_count;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *status_display;
@property (nonatomic, copy) NSString *reward_amount_display;
@property (nonatomic, copy) NSString *job_type_display;
@property (nonatomic, copy) NSString *submitEndDate;
@property (nonatomic, copy) NSString *releasDate;

@property (nonatomic, strong) NSDictionary *released_at;
@property (nonatomic, strong) NSDictionary *submission_ended_at;

-(instancetype)initWithJsonToModel:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
