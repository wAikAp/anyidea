//
//  SWUserCenterViewController.h
//  Anyidea
//
//  Created by shingwai chan on 2018/2/20.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginUser.h"
#import "LoginUserTokenInfo.h"
#import "UserModel.h"

@interface SWUserCenterViewController : UIViewController
@property (nonatomic, assign) BOOL isCurrentUser;
@property (nonatomic, strong) LoginUser *curLogInUsr;
//@property (nonatomic, strong) LoginUserTokenInfo *curUsrInfo;
@property (nonatomic, assign) BOOL isPresentVc;
@property (nonatomic, strong) UserModel *userModel;

@end
