//
//  SWUserEditingViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/21.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWUserEditingViewController.h"
#import "UIViewController+BackButtonHandler.h"
#import "UIView+Extension.h"

@interface SWUserEditingViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *pleaseHolderLabel;
@property (nonatomic, weak) UIAlertController *actionSheetVc;
@end

@implementation SWUserEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"編輯";
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    } else {
        // Fallback on earlier versions
    }
    
    self.textView.text = self.text;
    self.textView.delegate = self;
    self.pleaseHolderLabel.text = @"在此輸入你的資料";
    if ([self.textView.text isEqualToString:@""]||[self.textView.text isEqualToString:@"新增簡介"]) {
        
        self.pleaseHolderLabel.hidden = NO;
        self.textView.text = @"";
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
        if (self.actionSheetVc) {//當有對象時 證明actionSheet還沒釋放，不這麼寫的話會重複顯示兩次actionSheet
            return;
        }
        [self showThePopAltView];
    }
}

-(void)showThePopAltView{

    UIAlertController *actionSheetVc = [UIAlertController alertControllerWithTitle:@"正在離開編輯頁" message:@"確定要離開？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.actionSheetVc = nil;
        
    }];
    UIAlertAction *exitNotSave = [UIAlertAction actionWithTitle:@"離開不儲存" style:    UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *exitAndSave = [UIAlertAction actionWithTitle:@"離開并儲存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //support ipad 用AlertVC不加這個會崩
    actionSheetVc.popoverPresentationController.sourceView = self.view;
    //彈出位置
//    actionSheetVc.popoverPresentationController.sourceRect = CGRectMake(100, 0, 100, 44);
    self.actionSheetVc = actionSheetVc;
    [actionSheetVc addAction:cancel];
    [actionSheetVc addAction:exitNotSave];
    [actionSheetVc addAction:exitAndSave];
    [self.navigationController presentViewController:actionSheetVc animated:YES completion:nil];
//    NSLog(@"frame = %@",self.view);
    
    
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
