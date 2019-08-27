//
//  ANnetworkManage.m
//  Anyidea
//
//  Created by shingwai chan on 21/11/2018.
//  Copyright © 2018 shingwai chan. All rights reserved.
//

#import "ANnetworkManage.h"
//#import "AFOAuth2Manager.h"


static NSString *const url_api = @"https://www.anyidea.hk/api";
static NSString *const version = @"/v1";
static NSString *const localeZH = @"/zh";
static NSString *const url_api_ZH = @"https://www.anyidea.hk/api/v1/zh/";
static NSString *const client_id = @"2";
static NSString *const client_secret = @"uYzUQXGh7Vbxy7RrNDcQMDbV2E1bKijsVpngpKLi";
static NSString *const grant_type = @"password";
NSString *FULLURL;


@interface ANnetworkManage()
//@property (nonatomic, strong) NSURL *baseURL;
@end

@implementation ANnetworkManage

+ (instancetype)shareNetWorkManage {
    static ANnetworkManage * instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.afmanage = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:url_api_ZH]];
        instance.afmanage.requestSerializer = [AFJSONRequestSerializer serializer];
        instance.afmanage.responseSerializer = [AFJSONResponseSerializer serializer];
        [instance.afmanage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [instance.afmanage.requestSerializer setTimeoutInterval:15.f];
//        instance.afmanage.requestSerializer.timeoutInterval = 8.f;
        [instance.afmanage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        /*
         [AFHTTPResponseSerializer serializer];
         [AFHTTPRequestSerializer serializer];
         [AFJSONRequestSerializer serializer];
         [AFJSONResponseSerializer serializer];
         */
    });
    
//    FULLURL =  [NSString stringWithFormat:@"%@%@%@",url_api,version,localeZH];
    return instance;
}

-(void)registerWithUserName:(NSString *)usrName userEmail:(NSString *)email userPw:(NSString *)usrPw confirmPw:(NSString *)cPw phoneNo:(NSString *)phone agree:(NSString *)agree subscribe:(NSString *)sub progress:(void (^)(NSProgress * _Nonnull))postProgress success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack{
    NSDictionary *parame = @{
                             @"username":usrName,
                             @"email":email,
                             @"password":usrPw,
                             @"password_confirmation":cPw,
                             @"mobile_phone":phone,
                             @"agree":agree,
                             @"subscribe":sub,
                             @"client_id":client_id,
                             @"client_secret":client_secret,
                             @"grant_type":grant_type
                             };
    [self.afmanage POST:@"register" parameters:parame headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        postProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString*status = responseObject[@"status"];
        if (status.integerValue > 0) {
            
            //success to register
//            dispatch_async(dispatch_get_main_queue(), ^{
                successData(responseObject[@"data"][@"login_data"],nil);
//            });
        }else{
//            NSLog(@"responseObject[errors] = %@",responseObject[@"data"][@"errors"]);
            NSString *errorMsg = responseObject[@"error_message"];
            NSMutableString *errorBody = [NSMutableString string];
            
//            NSArray* userNameArr = responseObject[@"data"][@"errors"][@"username"];
//            NSArray* pwdArr = responseObject[@"data"][@"errors"][@"password"];
//            NSArray* phoneArr = responseObject[@"data"][@"errors"][@"mobile_phone"];
//            NSArray* emailArr = responseObject[@"data"][@"errors"][@"email"];
//            NSArray *agreeArr = responseObject[@"data"][@"errors"][@"agree"];
//
//            for (NSString*str in userNameArr) {
//                
//                errorBody = [NSString stringWithFormat:@"%@%@\n",errorBody,str];
//            }
//            for (NSString*str in pwdArr) {
//                errorBody = [NSString stringWithFormat:@"%@%@\n",errorBody,str];
//            }
//            for (NSString*str in phoneArr) {
//                errorBody = [NSString stringWithFormat:@"%@%@\n",errorBody,str];
//            }
//            for (NSString*str in emailArr) {
//
//                errorBody = [NSString stringWithFormat:@"%@%@\n",errorBody,str];
//            }
//            for (NSString*str in agreeArr) {
//                
//                errorBody = [NSString stringWithFormat:@"%@%@\n",errorBody,str];
//            }
//        
//            
////            successData(nil,[NSString stringWithFormat:@"%@\n%@",errorMsg,errorBody]);
            
            NSDictionary *dic = responseObject[@"data"][@"errors"];
            for (NSString *arrName in dic) {//for in to take the key
                NSArray *arr = dic[arrName];//find value
                for (NSString *str in arr) {
                    [errorBody appendFormat:@"%@\n",str];
                }
            }
        
            successData(nil,[NSString stringWithFormat:@"Registeration Failed\n%@",errorBody]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBack(error);
    }];
}

-(void)loginWithUsrName:(NSString *)usrName usrPw:(NSString *)usrPw success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack{
    
    NSDictionary *parame = @{
                             @"username":usrName,
                             @"password":usrPw,
                             @"client_id":client_id,
                             @"client_secret":client_secret,
                             @"grant_type":grant_type
                             };
    
//    NSDictionary *header = @{@"key":@"Accept",@"value":@"application/json"};
    NSDictionary *header = @{@"Accept":@"application/json"};
//    NSString *loginURL = [FULLURL stringByAppendingString:@"/login"];
    
    self.afmanage.requestSerializer = [AFJSONRequestSerializer serializer];
    self.afmanage.responseSerializer = [AFJSONResponseSerializer serializer];
    /*
    [AFHTTPResponseSerializer serializer];
    [AFHTTPRequestSerializer serializer];
    [AFJSONRequestSerializer serializer];
    [AFJSONResponseSerializer serializer];
    */
    self.afmanage.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];

    [self.afmanage POST:@"login" parameters:parame headers:header constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSString *errorMsg= nil;
        NSString *status = responseObject[@"status"];
        
        if (status.integerValue>0) {
            successData(responseObject[@"data"],nil);
        }else{
            //NSDictionary *dataDic = responseObject[@"data"];
            
            //errorMsg = [NSString stringWithFormat:@"%@,%@",dataDic[@"error"],dataDic[@"message"]];
            
            successData(nil,@"Login failed,\nUser Email or Password wrong.\nPlease try again.");
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //server error
        errorBack(error);
    }];
    
}

//get user Info
-(void)getUsrInfoWithAccessTkn:(NSString *)tkn tknType:(NSString *)tknType success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack{
    
    NSString *call = @"user/profile/view";
//    NSString* url = [FULLURL stringByAppendingString:call];
    //access tkn
    NSString *Authorization = [NSString stringWithFormat:@"%@ %@",tknType,tkn];
//    NSLog(@"Authorization = %@",Authorization);
    
    self.afmanage.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    NSDictionary *header = @{@"Authorization":Authorization , @"Accept":@"application/json"};
    self.afmanage.responseSerializer = [AFJSONResponseSerializer serializer];
    //auth need put to header to verification
    [self.afmanage POST:call parameters:nil headers:header  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *errorMsg= nil;
        NSString *status = responseObject[@"status"];
        //success get  info
        if ( status.integerValue>0) {
            successData(responseObject[@"data"],nil);
        }else{
            errorMsg = [NSString stringWithFormat:@"%@,%@",responseObject[@"error_code"],responseObject[@"error_message"]];
            successData(nil,errorMsg);
        }
//        NSLog(@"AFNsuccess - %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //server error
        NSLog(@"getUsrInfoWithAccessTkn: ANFerror - %@",error);
        errorBack(error);
    }];
}


//get home page missions
-(void)getNewMissionsWithSearch:(NSString *)searStr status:(NSString *)status page:(NSString *)page success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack{
//    [self.afmanage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    self.afmanage.requestSerializer.timeoutInterval = 15.f;
    //        instance.afmanage.requestSerializer.timeoutInterval = 8.f;
//    [self.afmanage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSString *url = @"job/list/view";
    NSDictionary *paramter = @{@"search":searStr,@"status":status,@"page":page};
    [self.afmanage POST:url parameters:paramter headers:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /*
        NSString *errorMsg= nil;
        NSString *currentPage;
        NSString *reStatus = responseObject[@"status"];
        if (reStatus.integerValue == 1) {
            currentPage = responseObject[@"data"][@"current_page"];
//            NSLog(@"getNewMissionsWithSearch success: \n%@",responseObject[@"data"][@"items"]);
            NSArray *dataArr = responseObject[@"data"][@"items"];
            successData(dataArr,errorMsg);
        }else{
            errorMsg = @"request error";
            successData(nil,errorMsg);
        }
        */
        
            successData(responseObject,nil);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"getNewMissionsWithSearch server error: \n%@",error);
        errorBack(error);
    }];
    
}


-(void)getMissionDetailWithMissionID:(NSString *)mission_id success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack{

    NSString *url = [NSString stringWithFormat:@"job/%@/view",mission_id];
    [self.afmanage POST:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /*
        NSString *status = responseObject[@"status"];
        NSString *errorMsg= nil;
        if(status.integerValue==1){
            successData(responseObject[@"data"],errorMsg);
        }else{
            errorMsg = [NSString stringWithFormat:@"%@ %@",responseObject[@"error_code"],responseObject[@"error_message"]];
            successData(nil,errorMsg);
        }
        */
        successData(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"AFN MissionJobDetail error =  %@",error);
        errorBack(error);
    }];
}

-(void)getMissionWorkListWithMissionID:(NSString *)mission_id andPage:(nonnull NSString *)page success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack{
    NSString *url = @"work/list/view";
    NSDictionary *para = @{
                           @"job_id" :mission_id,
                           @"page" : page
                           };
    [self.afmanage POST:url parameters:para headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"getMissionWorkListWithMissionID success= %@",responseObject);
        
        /*NSString *status = responseObject[@"status"];
        NSString *errorMsg= nil;
        if(status.integerValue==1){
            successData(responseObject[@"data"][@"items"],errorMsg);
        }else{
            errorMsg = [NSString stringWithFormat:@"%@ %@",responseObject[@"error_code"],responseObject[@"error_message"]];
            successData(nil,errorMsg);
        }*/
//        dispatch_async(dispatch_get_main_queue(), ^{
        
            successData(responseObject[@"items"],nil);
//        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AFN getMissionWorkListWithMissionID error = %@",error);
        errorBack(error);
    }];
}

-(void)getWorkDetailWithWorkID:(NSString *)work_id success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack{
    
    NSString *url = [NSString stringWithFormat: @"work/%@/view",work_id];
    [self.afmanage POST:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /*
        NSString *status = responseObject[@"status"];
        NSString *errorMsg= nil;
        if(status.integerValue==1){
            successData(responseObject[@"data"],errorMsg);
        }else{
            errorMsg = [NSString stringWithFormat:@"%@ %@",responseObject[@"error_code"],responseObject[@"error_message"]];
            successData(nil,errorMsg);
        }
        */
        successData(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBack(error);
//        NSLog(@"AFN WorkDetail error =  %@",error);
    }];
}

-(void)workVote:(NSString *)work_id andAccessTkn:(NSString *)tkn tknType:(NSString *)tknType success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError * _Nonnull))errorBack
{
    
    NSString *url = [NSString stringWithFormat: @"work/%@/vote",work_id];
    NSString *Authorization = [NSString stringWithFormat:@"%@ %@",tknType,tkn];
    NSDictionary *header = @{@"Authorization":Authorization , @"Accept":@"application/json"};
    [self.afmanage POST:url parameters:nil headers:header progress:^(NSProgress * _Nonnull uploadProgress) {
        //uploadProgress
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"success = %@",responseObject);
        successData(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error =  %@",error);
        errorBack(error);
    }];
}

-(void)workSubmitWithMissionJobId:(NSString *)missionJob_id andAccessTkn:(NSString *)tkn tknType:(NSString *)tknType andImage:(UIImage *)image work_title:(NSString *)work_title work_description:(NSString *)work_description work_visibility:(NSString *)work_visibility success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError * _Nonnull))errorBack{
    
    NSString *url =[NSString stringWithFormat: @"job/%@/submit",missionJob_id];
    
    NSString *Authorization = [NSString stringWithFormat:@"%@ %@",tknType,tkn];
    NSDictionary *header = @{@"Authorization":Authorization , @"Accept":@"application/json"};

    
    self.afmanage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    [self.afmanage POST:url parameters:nil headers:header constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *work_title_data = [work_title dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:work_title_data name:@"work_title"];
        NSData *work_description_data = [work_description dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:work_description_data name:@"work_description"];
        NSData *work_visibility_data = [work_visibility dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:work_visibility_data name:@"work_visibility"];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@%@%@.jpg",missionJob_id,work_title,[formatter stringFromDate:[NSDate date]]];
        //MIMEType application/octet-stream
        [formData appendPartWithFileData:imageData name:@"work_attachment" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successData(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBack(error);
//        NSLog(@"error: %@",error);
    }];
}

-(void)postMissionJobCreateWithAccessTkn:(NSString *)tkn tknType:(NSString *)tknType andjobTitle:(NSString *)job_title jobType:(NSString *)job_type copanyName:(NSString *)company_name jobDesc:(NSString *)job_description workRequirements:(NSString *)work_requirements jobAtt:(UIImage *)job_attachment submissionEndDate:(NSString *)submission_ended_at rewardAmount:(NSString *)reward_amount numberOfFinalists:(NSString *)number_of_finalists jobVisibility:(NSString *)job_visibility success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError * _Nonnull))errorBack{
//    job_type = @"1";
    NSString *Authorization = [NSString stringWithFormat:@"%@ %@",tknType,tkn];
    
    NSDictionary *header = @{@"Authorization":Authorization , @"Accept":@"application/json"};
    NSDictionary *para = @{
                           @"job_title":job_title,
                           @"job_type":job_type,
                           @"company_name":company_name,
                           @"job_description":job_description,
                           @"works_requirements":work_requirements,
                           @"submission_ended_at":submission_ended_at,
                           @"reward_amount":reward_amount,
                           @"number_of_finalists":number_of_finalists,
                           @"job_visibility":job_visibility
                           };
    self.afmanage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [self.afmanage POST:@"job/create" parameters:nil headers:header constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       
        NSData *job_title_data = [job_title dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:job_title_data name:@"job_title"];
       
        NSData *job_type_data = [job_type dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:job_type_data name:@"job_type"];
       
        NSData *company_name_data = [company_name dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:company_name_data name:@"company_name"];
        
        NSData *job_description_data = [job_description dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:job_description_data name:@"job_description"];
      
        NSData * work_requirements_data = [work_requirements dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:work_requirements_data name:@"works_requirements"];
        
        NSData * submission_ended_at_data = [submission_ended_at dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:submission_ended_at_data name:@"submission_ended_at"];
        
        NSData * reward_amount_data = [reward_amount dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:reward_amount_data name:@"reward_amount"];
        
        NSData * number_of_finalists_data = [number_of_finalists dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:number_of_finalists_data name:@"number_of_finalists"];
        
        NSData * job_visibility_data = [job_visibility dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:job_visibility_data name:@"job_visibility"];
        
        if (job_attachment != nil) {
            
            NSData *imageData = UIImageJPEGRepresentation(job_attachment, 0.6);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *fileName = [NSString stringWithFormat:@"%@%@%@.jpg",job_title,job_type,[formatter stringFromDate:[NSDate date]]];
            //MIMEType application/octet-stream
            [formData appendPartWithFileData:imageData name:@"job_attachment" fileName:fileName mimeType:@"image/jpeg"];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = responseObject[@"status"];
        if (status.integerValue<0) {
            NSString *errMsg = @"";
            errMsg = [NSString stringWithFormat:@"%@\n%@",responseObject[@"error_code"],responseObject[@"error_message"]];
            successData(nil,errMsg);
        }else{
            successData(responseObject,nil);
        }
//        NSLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error = %@",error);
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
//        NSLog(@"%@,Failure error serialised:%@\njob_type:%@--%@--%@",self.class,serializedData,    [NSString stringWithFormat:@"%@",serializedData[@"data"][@"errors"][@"job_type"][0]],[NSString stringWithFormat:@"%@",serializedData[@"data"][@"errors"][@"job_type"][1]],[NSString stringWithFormat:@"%@",serializedData[@"data"][@"errors"][@"works_requirements"][0]]);
        errorBack(error);
    }];
}


-(void)logOutWithAccessToken:(NSString *)access_tkn andTokenyType:(NSString *)tkn_type success:(void (^)(id responseObject,NSString *errorMsg))successData Error:(void (^)(NSError *errorBack))errorBack{
    NSString *Authorization = [NSString stringWithFormat:@"%@ %@",tkn_type,access_tkn];
    
    NSDictionary *header = @{@"Authorization":Authorization , @"Accept":@"application/json"};
    [self.afmanage.requestSerializer setTimeoutInterval:6.f];
    [self.afmanage POST:@"logout" parameters:nil headers:header progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"success %@",responseObject);
        if (successData) {
            
            successData(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"logout error %@",error);
        if (errorBack) {
            errorBack(error);
        }
    }];
}

-(void)get{
    
    NSString *nonCall = @"/non-existing-call";
    NSString* geturl = [[NSString alloc]initWithFormat:@"%@%@%@%@",url_api,version,localeZH,nonCall];
    AFHTTPSessionManager *afmanage = [AFHTTPSessionManager manager];
    [afmanage GET:geturl parameters:NULL headers:NULL progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"success -get- %@",responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure -get-");
    }];
}




@end
