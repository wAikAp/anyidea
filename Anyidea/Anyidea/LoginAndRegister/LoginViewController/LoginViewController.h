//
//  LoginViewController.h
//  Anyidea
//
//  Created by shingwai chan on 2018/1/15.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

@class LoginUser;
#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, copy) void(^loginSuccessBlock)(LoginUser *useroModel);
//-(void)successLoginBlock:(void (^)(LoginUser* useroModel))successData;

@end
