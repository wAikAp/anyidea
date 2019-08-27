//
//  SWAlertController.h
//  Anyidea
//
//  Created by shingwai chan on 17/12/2018.
//  Copyright © 2018 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWAlertController : UIAlertController

/*
 * title & message
 * curviewController 
 * defaul style UIAlertControllerStyleAlert
 * defaul cancel
 */
+(void)showAlertControllerwithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle curviewController:(UIViewController *)cruVc;

+(instancetype)showAlertControllerwithTitle:(NSString *)title message:(NSString *)message curviewController:(UIViewController *)cruVc;

-(void)dissmissTheAlertVc:(UIViewController *)cruVc;

@end

NS_ASSUME_NONNULL_END
