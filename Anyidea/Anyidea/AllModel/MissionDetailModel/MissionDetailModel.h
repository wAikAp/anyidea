//
//  MissionJobModel.h
//  Anyidea
//
//  Created by shingwai chan on 16/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MissionDetailModel : NSObject

@property (nonatomic, copy) NSString *job_id;
@property (nonatomic, assign) NSInteger publisher_id;
@property (nonatomic, assign) NSInteger job_visibility;

@property (nonatomic, copy) NSString *publisher_name;
@property (nonatomic, copy) NSString *job_title;
@property (nonatomic, copy) NSString *reward_amount;
@property (nonatomic, copy) NSString *number_of_finalists;
@property (nonatomic, copy) NSString *job_type;
@property (nonatomic, copy) NSString *release_date;
@property (nonatomic, copy) NSString *submit_date;
@property (nonatomic, copy) NSString *works_count;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *company_name;
@property (nonatomic, copy) NSString *job_description;
@property (nonatomic, copy) NSString *works_requirements;
@property (nonatomic, copy) NSString *reward_amount_display;
@property (nonatomic, copy) NSString *winner_amount;
@property (nonatomic, copy) NSString *winner_amount_display;

@property (nonatomic, assign) CGFloat finalist_amount;
@property (nonatomic, copy) NSString *finalist_amount_display;
@property (nonatomic, copy) NSString *selected_finalist;
@property (nonatomic, copy) NSString *job_type_display;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *status_display;
@property (nonatomic, copy) NSString *job_attachment;
@property (nonatomic, strong) UserModel *postsJobUser;
-(instancetype)initWithJsonToModel:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
