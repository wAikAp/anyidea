//
//  SWUserIconViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/3/1.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWUserIconViewController.h"

@interface SWUserIconViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation SWUserIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"個人頭像";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(navRightBtnDidClick)];

   
}

-(void)navRightBtnDidClick{
    
}
- (IBAction)iconViewDidClick:(UITapGestureRecognizer *)sender {
    NSLog(@"tap");
    if (self.navigationController.isNavigationBarHidden) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController setNavigationBarHidden:NO];
        }completion:^(BOOL finished) {
            
        }];
    }else
    {
        self.view.backgroundColor = [UIColor blackColor];
        [UIView animateWithDuration:0.25 animations:^{
            [self.navigationController setNavigationBarHidden:YES];
        }completion:^(BOOL finished) {
            
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
