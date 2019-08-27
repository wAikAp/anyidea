//
//  LoginUser.h
//  Anyidea
//
//  Created by shingwai chan on 11/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginUser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) BOOL is_designer;
@property (nonatomic, assign) BOOL is_publisher;
@property (nonatomic, copy) NSString *profile_picture_url;
@property (nonatomic, copy) NSString *bad_points;
@property (nonatomic, copy) NSString *good_points;
@property (nonatomic, assign) BOOL logined;

+(instancetype)shareLogingUser;
//single case
-(instancetype)initWithJsonToModel:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
