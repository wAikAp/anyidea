//
//  WorkDetailedViewController.h
//  Anyidea
//
//  Created by shingwai chan on 2017/11/20.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WorkDetailedViewController;

@protocol WorkDetailedViewControllerDelegate <NSObject>

-(void)workVC:(WorkDetailedViewController *)workVC autoNum:(NSInteger)autoNum;

@end


@interface WorkDetailedViewController : UIViewController

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) NSUInteger index_row;

@property (nonatomic , weak) id <WorkDetailedViewControllerDelegate> workVcDelegate;

@property (nonatomic , copy) void(^workVCDidClickTestBtnBlock)(NSInteger autoNum);


+(instancetype)workDetailedViewController;


@end
