//
//  ANnetworkManage.h
//  Anyidea
//
//  Created by shingwai chan on 21/11/2018.
//  Copyright © 2018 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN


@interface ANnetworkManage : NSObject

@property(nonatomic,strong)AFHTTPSessionManager *afmanage;
/**
 *
 *  Singleton to creat network magage
 */
+(instancetype)shareNetWorkManage;

/**
 *  register
 *  Success will call back the register error (>0 is success) in success data
 *  ErrorBack call back the server error
 */
-(void)registerWithUserName:(NSString *)usrName userEmail:(NSString *)email userPw:(NSString *)usrPw confirmPw:(NSString *)cPw phoneNo:(NSString *)phone agree:(NSString *)agree subscribe:(NSString *)sub progress:(void (^)(NSProgress * _Nonnull))postProgress success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBac;
/**
 *  Login
 *  Success will call back the login error in success data
 *  ErrorBack call back the server error
 */
-(void)loginWithUsrName:(NSString *)usrName usrPw:(NSString *)usrPw success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack;

//user info
-(void)getUsrInfoWithAccessTkn:(NSString *)tkn tknType:(NSString *)tknType success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack;
//new mission
-(void)getNewMissionsWithSearch:(NSString *)searStr status:(NSString *)status page:(NSString *)page success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack;
/*
 * get mission detail
 * api: job view
 */
-(void)getMissionDetailWithMissionID:(NSString *)mission_id success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack;

//mission works(jobs)
-(void)getMissionWorkListWithMissionID:(NSString *)mission_id andPage:(nonnull NSString *)page success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack;
//work(jobs) detail
-(void)getWorkDetailWithWorkID:(NSString *)work_id success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack;

//work vote
-(void)workVote:(NSString *)work_id andAccessTkn:(NSString *)tkn tknType:(NSString *)tknType success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError * _Nonnull))errorBack;

//submit job
-(void)workSubmitWithMissionJobId:(NSString *)missionJob_id andAccessTkn:(NSString *)tkn tknType:(NSString *)tknType andImage:(UIImage *)image work_title:(NSString *)work_title work_description:(NSString *)work_description work_visibility:(NSString *)work_visibility success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError * _Nonnull))errorBack;

//job create
-(void)postMissionJobCreateWithAccessTkn:(NSString *)tkn tknType:(NSString *)tknType andjobTitle:(NSString *)job_title jobType:(NSString *)job_type copanyName:(NSString *)company_name jobDesc:(NSString *)job_description workRequirements:(NSString *)work_requirements jobAtt:(UIImage *)job_attachment submissionEndDate:(NSString *)submission_ended_at rewardAmount:(NSString *)reward_amount numberOfFinalists:(NSString *)number_of_finalists jobVisibility:(NSString *)job_visibility success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError * _Nonnull))errorBack;


-(void)logOutWithAccessToken:(NSString *)access_tkn andTokenyType:(NSString *)tkn_type success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack;

-(void)get;

@end

NS_ASSUME_NONNULL_END
