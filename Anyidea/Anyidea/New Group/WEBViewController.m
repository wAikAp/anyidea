//
//  WEBViewController.m
//  Anyidea
//
//  Created by shingwai chan on 12/4/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "WEBViewController.h"
#import "SVProgressHUD.h"
#import <WebKit/WebKit.h>
#import "SWScreenHelper.h"

@interface WEBViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (weak, nonatomic) WKWebView *webView;
@end

@implementation WEBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //fix msg: Could not signal service com.apple.WebKit.WebContent: 113: Could not find specified service
    [self.webURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    //   equle self.UIwebView.scalesPageToFit =YES;
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    WKWebView *web= [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, [SWScreenHelper screenWidth],  [SWScreenHelper screenHeight]) configuration:wkWebConfig];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
    [self.view addSubview:web];
    self.webView = web;

    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [SVProgressHUD showWithStatus:@"Loading..."];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    [SVProgressHUD showWithStatus:@"Loading..."];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"load Failed"];
    [SVProgressHUD dismissWithDelay:1.2f];
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    [self dismissSVP];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self dismissSVP];
}

-(void)dealloc{
    [self dismissSVP];
}
-(void)dismissSVP{
    [SVProgressHUD dismiss];
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
