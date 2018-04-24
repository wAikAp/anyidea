//
//  SWUserEditingViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/21.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWUserEditingViewController.h"
#import "UIViewController+BackButtonHandler.h"

@interface SWUserEditingViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *pleaseHolderLabel;
@property (nonatomic, weak) UIAlertController *actionSheet;
@end

@implementation SWUserEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = self.text;
    self.textView.delegate = self;
    self.pleaseHolderLabel.text = @"在此輸入你的資料";
    if ([self.textView.text isEqualToString:@""]) {
        
        self.pleaseHolderLabel.hidden = NO;
    }else{
        
        self.pleaseHolderLabel.hidden = YES;
    }
    
    
}
- (IBAction)saveBtnDidClick:(UIButton *)sender {
    NSLog(@"%@",self.textView.text);
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.pleaseHolderLabel.hidden = YES;
}


#pragma mark - PopViewControllerDelegate
//Click leftItemBtn will run
-(BOOL)navigationShouldPopOnBackButton
{
    [self showThePopAltView];
    return NO;

}

- (void)willMoveToParentViewController:(UIViewController*)parent{
    if (parent == nil) {//即將退出及側滑時調用
        if (self.actionSheet) {//當有對象時 證明actionSheet還沒釋放，不這麼寫的話會重複顯示兩次actionSheet
            return;
        }
        [self showThePopAltView];
    }
}

-(void)showThePopAltView{

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"正在離開編輯頁" message:@"確定要離開？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.actionSheet = nil;
        
    }];
    UIAlertAction *exitNotSave = [UIAlertAction actionWithTitle:@"離開不儲存" style:    UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *exitAndSave = [UIAlertAction actionWithTitle:@"離開并儲存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.actionSheet = actionSheet;
    
    [actionSheet addAction:cancel];
    [actionSheet addAction:exitNotSave];
    [actionSheet addAction:exitAndSave];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void)dealloc{
    NSLog(@"釋放");
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
