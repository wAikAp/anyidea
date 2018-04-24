//
//  WorkDetailedViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2017/11/20.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#import "WorkDetailedViewController.h"

@interface WorkDetailedViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UIButton *testBtn;

@end

@implementation WorkDetailedViewController


+(instancetype)workDetailedViewController {
    WorkDetailedViewController *workVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WorkDetailedViewController"];
    return workVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerImageView.image = [UIImage imageNamed:self.imageName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)testBtnDidClick:(UIButton *)sender {
    
    NSInteger autoNum = arc4random();
//    NSLog(@"點了 %ld",(long)autoNum);
    if ([self.workVcDelegate respondsToSelector:@selector(workVC:autoNum:)]) {
        [self.workVcDelegate workVC:self autoNum:autoNum];
    }
  //block
    if (self.workVCDidClickTestBtnBlock) {
        self.workVCDidClickTestBtnBlock(autoNum);
    }
}


@end
