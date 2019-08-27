//
//  PostMissionSucceedViewController.m
//  Anyidea
//
//  Created by shingwai chan on 18/3/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "PostMissionSucceedViewController.h"

@interface PostMissionSucceedViewController ()

@end

@implementation PostMissionSucceedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.jobTitleLabel.text = self.jobTitleLabelStr;
    self.jobTypeLabel.text = self.jobTitleLabelStr;
    self.companyNameLabel.text = self.companyNameLabelStr;
    self.submitEndDateLabel.text = self.submitEndDateLabelStr;
    self.finalLabel.text = self.finalLabelStr;
    self.jobVibLabel.text = self.jobVibLabelStr;
    self.jobAmountLabel.text = self.jobAmountLabelStr;
    
    
}
- (IBAction)backBtnDidClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
