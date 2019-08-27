//
//  SWUserIconViewController.h
//  Anyidea
//
//  Created by shingwai chan on 2018/3/1.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWUserIconViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *navTitle;
@end
