//
//  LoginViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/15.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

/*UI*/
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SWScreenHelper.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "SWAlertController.h"
#import "UIView+Extension.h"
#import "SVProgressHUD.h"
#import "WEBViewController.h"

/*network*/
#import "ANnetworkManage.h"

/*data*/
#import "ConfigString.h"
#import "LoginUserTokenInfo.h"
#import "LoginUser.h"


@interface LoginViewController () <UITextFieldDelegate>
@property (nonatomic, weak) UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passWordLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *faceBookBtnTopConstraint;

@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;
@property (nonatomic, strong) LoginUserTokenInfo *userTknIf;
@property (nonatomic, strong) LoginUser *user;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfoWithAccessTknByNotifiation:) name:LogIn_Success object:nil];
    [self setUpUI];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)setUpUI {
   
    self.title = @"登入";
    UIView *logInView = [[NSBundle mainBundle]loadNibNamed:@"loginView" owner:self options:nil].lastObject;
    logInView.frame = self.view.bounds;
    logInView.y = getRectNavAndStatusHight;
    self.loginView = logInView;
    [self.view addSubview:logInView];
    self.passWordTextField.secureTextEntry = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didTapSelfView:)];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didTapSelfView:)];
    
    [swipeUp setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [swipeDown setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:swipeUp];
    [self.view addGestureRecognizer:swipeDown];
    
    IQKeyboardReturnKeyHandler *returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc]initWithViewController:self];
    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.returnKeyHandler = returnKeyHandler;
    self.passWordTextField.delegate = self;
    
    if ([[SWScreenHelper iphoneScreenType] isEqualToString:IPHONESE_SIZE_SCREEN]) {
        self.faceBookBtnTopConstraint.constant = 10;
        self.lineTopConstraint.constant = 10;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.passWordTextField == textField) {
        [self loginBtnDidClick:self.loginBtn];
    }
    return YES;
}

-(void)didTapSelfView:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

-(void)leftBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

static     CGFloat DESC = 1.35f;

- (IBAction)loginBtnDidClick:(UIButton *)sender {
    
    __block BOOL loginSces = NO;
    if ([self.userNameTextField.text isEqualToString: @""] || [self.userNameTextField.text isEqualToString: @" "]) {
        
        [SWAlertController showAlertControllerwithTitle:@"請輸入用戶名" message:@"請輸入有效用戶名" actionTitle:@"ok" curviewController:self];
        return;
        
    }else if([self.passWordTextField.text  isEqualToString: @""]){
        [SWAlertController showAlertControllerwithTitle:@"請輸入密碼" message:@"請輸入密碼" actionTitle:@"ok" curviewController:self];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在登入..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    [[ANnetworkManage shareNetWorkManage] loginWithUsrName:self.userNameTextField.text usrPw:self.passWordTextField.text  success:^(id  _Nonnull responseObject,NSString *errorMsg) {
//        NSLog(@"%@ , %@",responseObject,errorMsg);
        if(responseObject){
            //login success
            //show the success message
            LoginUserTokenInfo *userTknIf = [[LoginUserTokenInfo alloc]initWithJsonToModel:responseObject];
            self.userTknIf = userTknIf;
            //get the user info
            //[self getUserInfoWithAccessTkn:self.userTknIf.access_token tknType:self.userTknIf.token_type];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"登入成功!"];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD dismissWithDelay:DESC];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:LogIn_Success object:userTknIf];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    });
            });
            
            loginSces = YES;
        }else{
            //login error
            NSLog(@"login error calss = %@\nError Message = %@",self.class,errorMsg);
            [SVProgressHUD showErrorWithStatus:errorMsg];
            [SVProgressHUD dismissWithDelay:4.f];
        }

    } Error:^(NSError * errorBack) {
//        NSLog(@"failure - %@",errorBack);
        [SVProgressHUD showErrorWithStatus:@"Network error，請稍後重試"];
        [SVProgressHUD dismissWithDelay:DESC*1.2f];
    }];
    
    
    
}

//-(void)getUserInfoWithAccessTkn:(NSString *)aTkn tknType:(NSString *)tknTpye{
-(void)getUserInfoWithAccessTknByNotifiation:(NSNotification *)Notification{
    LoginUserTokenInfo *userTknIf = Notification.object;
    [[ANnetworkManage shareNetWorkManage] getUsrInfoWithAccessTkn:userTknIf.access_token tknType:userTknIf.token_type success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
        if(responseObject){
            LoginUser *user = [[LoginUser alloc]initWithJsonToModel:responseObject];
            user.logined = YES;
            self.user = user;
            [[NSNotificationCenter defaultCenter] postNotificationName:Get_User_Data_Success object:user];
//            if (self.loginSuccessBlock) {
//                self.loginSuccessBlock(user);
//            }
        }else{
            NSLog(@"getUserInfoWithAccessTkn: 獲取info錯誤 - %@",errorMsg);
            [SVProgressHUD showErrorWithStatus:@"獲取info錯誤，請稍後重試"];
            [SVProgressHUD dismissWithDelay:DESC*1.2f];
        }
        
    } Error:^(NSError * _Nonnull errorBack) {
        //NSLog(@"服務器錯誤");
        [SVProgressHUD showErrorWithStatus:@"獲取user info錯誤，請稍後重試"];
        [SVProgressHUD dismissWithDelay:DESC*1.2f];
    }];
}

- (IBAction)FaceBookSignInBtnDidClick:(UIButton *)sender {
}
- (IBAction)googleSignInDidClick:(UIButton *)sender {
}
- (IBAction)newAcSignInDidClick:(UIButton *)sender {
    
    
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
    
}
- (IBAction)forgetPassWordBtnDidClick:(UIButton *)sender {
    WEBViewController *webVc = [WEBViewController new];
    webVc.webURL = @"https://www.anyidea.hk/zh/password/reset";
    [self.navigationController pushViewController:webVc animated:YES];
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
