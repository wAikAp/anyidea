//
//  LoginUserTokenInfo.h
//  Anyidea
//
//  Created by shingwai chan on 17/12/2018.
//  Copyright © 2018 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginUserTokenInfo : NSObject
@property (nonatomic, copy) NSString *token_type;
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *expires_in;
@property (nonatomic, copy) NSString *refresh_token;

//+(instancetype)loginUsrToken:(NSDictionary *)dic;
+(instancetype)shareLogingUsrToken;
-(instancetype)initWithJsonToModel:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
