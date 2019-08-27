//
//  SWAlertController.m
//  Anyidea
//
//  Created by shingwai chan on 17/12/2018.
//  Copyright © 2018 shingwai chan. All rights reserved.
//

#import "SWAlertController.h"

@interface SWAlertController ()

@end

@implementation SWAlertController

+(void)showAlertControllerwithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle curviewController:(nonnull UIViewController *)cruVc{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alertVc addAction:ok];
    [cruVc presentViewController:alertVc animated:YES completion:nil];
    
}

+(instancetype)showAlertControllerwithTitle:(NSString *)title message:(NSString *)message curviewController:(UIViewController *)cruVc{
    SWAlertController *alertVc = [SWAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [cruVc presentViewController:alertVc animated:YES completion:nil];
    return alertVc;
}

-(void)dissmissTheAlertVc:(UIViewController *)cruVc{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
