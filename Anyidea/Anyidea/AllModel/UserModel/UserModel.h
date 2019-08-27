//
//  UserModel.h
//  Anyidea
//
//  Created by shingwai chan on 12/4/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject


@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *bad_points;
@property (nonatomic, copy) NSString *profile_picture;
@property (nonatomic, copy) NSString *good_points;

-(instancetype)initWithJsonToModel:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
