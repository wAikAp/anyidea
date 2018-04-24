//
//  LoginViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/15.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "LoginViewController.h"
#import "SignInViewController.h"
#import "SWScreenHelper.h"
#import "IQKeyboardReturnKeyHandler.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (nonatomic, weak) UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passWordLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *faceBookBtnTopConstraint;

@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

-(void)setUpUI {
   
    self.title = @"登入";
    UIView *logInView = [[NSBundle mainBundle]loadNibNamed:@"loginView" owner:self options:nil].lastObject;
    logInView.frame = self.view.bounds;
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
    NSLog(@"done");
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

- (IBAction)loginBtnDidClick:(UIButton *)sender {
 
}
- (IBAction)FaceBookSignInBtnDidClick:(UIButton *)sender {
}
- (IBAction)googleSignInDidClick:(UIButton *)sender {
}
- (IBAction)newAcSignInDidClick:(UIButton *)sender {
    
    
    [self.navigationController pushViewController:[[SignInViewController alloc]init] animated:YES];
    
}
- (IBAction)forgetPassWordBtnDidClick:(UIButton *)sender {
}

#pragma mark - dealloc
-(void)dealloc
{
    NSLog(@"LoginVC dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
