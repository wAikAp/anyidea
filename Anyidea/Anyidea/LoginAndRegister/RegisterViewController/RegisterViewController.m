//
//  SignInViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/15.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "RegisterViewController.h"
#import "SWScreenHelper.h"
#import "ConfigString.h"
#import "WEBViewController.h"

#import "Masonry.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "SVProgressHUD.h"

#import "ANnetworkManage.h"
#import "LoginUserTokenInfo.h"
#import "LoginUser.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmPassWrodLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextBox;
@property (weak, nonatomic) IBOutlet UITextField *emailTextBox;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextBox;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassWrodTextBox;
@property (weak, nonatomic) IBOutlet UITextField *photoNoText;
@property (weak, nonatomic) IBOutlet UILabel *phoneNoLabel;
@property (nonatomic, assign) CGFloat stautsBarHeight;
@property (weak, nonatomic) IBOutlet UIButton *subscriptionBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn1;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn2;
@property (weak, nonatomic) IBOutlet UIButton *agreementBtn;
//Constraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *welcomeLabelConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subscriptionBtnTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *agreeBtnTopConstraint;

@property (nonatomic, strong) LoginUserTokenInfo *tkInfo;

@property (nonatomic, strong) NSArray *labelArr;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //call back the user token
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logInSuccessCallBackUserTknByNotification:) name:LogIn_Success object:nil];
    [self setUpUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpUI{
    self.title = @"註冊";
    IQKeyboardReturnKeyHandler *returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc]initWithViewController:self];
    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.returnKeyHandler = returnKeyHandler;
    
    //iPhoneSe
    if ([[SWScreenHelper iphoneScreenType] isEqualToString:IPHONE6_SIZE_SCREEN]) {
        self.labelArr = [NSArray arrayWithObjects:self.userNameLabel,self.emailLabel,self.passwordLabel,self.confirmPassWrodLabel,self.phoneNoLabel,self.titleLabel, nil];
        for (UILabel *label in self.labelArr) {
            label.font = [UIFont boldSystemFontOfSize:15];
        }
        self.welcomeLabelConstraint.constant = 15;
        self.userNameabelTopConstraint.constant = 10;
        self.subscriptionBtnTopConstraint.constant = 10;
        self.agreeBtnTopConstraint.constant = 5;
        UIFont *font = [UIFont boldSystemFontOfSize:13];
        self.agreeBtn1.titleLabel.font = font;
        self.agreeBtn2.titleLabel.font = font;
        self.agreementBtn.titleLabel.font = font;
    }
    
    
}
-(void)logInSuccessCallBackUserTknByNotification:(NSNotification *)callBackNotif{
    LoginUserTokenInfo* tkifo = callBackNotif.object;
    NSLog(@"register and login successfully! %@",tkifo);
    [[ANnetworkManage shareNetWorkManage] getUsrInfoWithAccessTkn:tkifo.access_token tknType:tkifo.token_type success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
        if (responseObject) {
            LoginUser *user = [[LoginUser alloc]initWithJsonToModel:responseObject];
            user.logined = YES;
            //post success get user data notification to update UI
            [[NSNotificationCenter defaultCenter] postNotificationName:Get_User_Data_Success object:user];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            NSLog(@"logInSuccessCallBackUserTknByNotification: Error = %@", errorMsg);
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    } Error:^(NSError * _Nonnull errorBack) {
        //server error
        NSLog(@"logInSuccessCallBackUserTknByNotification: 網絡或服務器問題:\nError = %@",errorBack);
        [SVProgressHUD showErrorWithStatus:@"網絡錯誤，請稍後重試"];
    }];
}

- (IBAction)submitRegister:(UIButton *)sender {
    NSString *sub = self.subscriptionBtn.selected? @"1":@"0";
    NSString *agree = self.agreeBtn.selected? @"1":@"";
    
    [SVProgressHUD showWithStatus:@"Loading...."];
    [[ANnetworkManage shareNetWorkManage] registerWithUserName:self.userNameTextBox.text userEmail:self.emailTextBox.text userPw:self.passWordTextBox.text confirmPw:self.confirmPassWrodTextBox.text phoneNo:self.photoNoText.text agree:agree subscribe:sub progress:^(NSProgress * progress) {
    
    } success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
        [SVProgressHUD dismiss];
//         NSLog(@"responseObject = %@", responseObject);
        if (responseObject) {
            LoginUserTokenInfo *tkInfo = [[LoginUserTokenInfo alloc]initWithJsonToModel:responseObject];
            self.tkInfo = tkInfo;
            [SVProgressHUD showSuccessWithStatus:@"恭喜，註冊成功！"];
            //post notice to login
            NSNotification *notifi = [[NSNotification alloc]initWithName:LogIn_Success object:tkInfo userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notifi];
            
        }else{
            NSLog(@"submitRegisterVc: error = %@", errorMsg);
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    } Error:^(NSError * _Nonnull errorBack) {
        NSLog(@"submitRegisterError: 網絡或服務器問題:\n%@",errorBack);
        [SVProgressHUD showErrorWithStatus:@"網絡錯誤，請稍後重試"];
    }];
}

- (IBAction)subscription:(UIButton *)sender {
    self.subscriptionBtn.selected = !self.subscriptionBtn.selected;
    
}
- (IBAction)agreeBtnDidClick:(UIButton *)sender {
    self.agreeBtn.selected = !self.agreeBtn.selected;
}
- (IBAction)AgreementDidClick:(UIButton *)sender {
    WEBViewController *webVc = [WEBViewController new];
    webVc.webURL = @"https://www.anyidea.hk/zh/terms";
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark - dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LogIn_Success object:nil];
    NSLog(@"Register dealloc");
}

@end

