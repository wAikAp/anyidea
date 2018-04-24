//
//  SignInViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/15.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SignInViewController.h"
#import "SWScreenHelper.h"

#import "Masonry.h"
#import "IQKeyboardReturnKeyHandler.h"

@interface SignInViewController ()
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

@property (nonatomic, strong) NSArray *labelArr;
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}


-(void)setUpUI{
    self.title = @"註冊";
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didTapSelfView:)];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didTapSelfView:)];
    
    [swipeUp setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [swipeDown setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    
    [self.view addGestureRecognizer:swipeUp];
    [self.view addGestureRecognizer:swipeDown];
    
    IQKeyboardReturnKeyHandler *returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc]initWithViewController:self];
    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.returnKeyHandler = returnKeyHandler;
    
    //iPhoneSe
    if ([[SWScreenHelper iphoneScreenType] isEqualToString:IPHONESE_SIZE_SCREEN]) {
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
-(void)didTapSelfView:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)subscription:(UIButton *)sender {
    self.subscriptionBtn.selected = !self.subscriptionBtn.selected;
    
}
- (IBAction)agreeBtnDidClick:(UIButton *)sender {
    self.agreeBtn.selected = !self.agreeBtn.selected;
}
- (IBAction)AgreementDidClick:(UIButton *)sender {
}

#pragma mark - dealloc
-(void)dealloc
{
    NSLog(@"SignViewC dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
