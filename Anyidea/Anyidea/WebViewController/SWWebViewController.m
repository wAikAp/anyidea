//
//  SWWebViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/3/4.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWWebViewController.h"

@interface SWWebViewController ()

@end

@implementation SWWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:web];
    NSURL *url = [NSURL URLWithString:@"http://dev01.anyidea.hk/zh/about"];
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
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
