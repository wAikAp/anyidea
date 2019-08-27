//
//  SWPostMissionViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/3/16.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWPostMissionViewController.h"
#import "PostMissionSucceedViewController.h"
#import "SWPostMissionTableViewCell.h"
#import "SWPostMissionTableViewHeader.h"
#import "SWPostMissionStepOneTableViewCell.h"
#import "SWPostMissionStepThreeTableViewCell.h"
#import "SWPostMissionStepFourTableViewCell.h"
#import "SWPostMissionAttachmentCell.h"
#import "UIView+Extension.h"
#import "SVProgressHUD.h"
#import <Photos/Photos.h>

#import "IQKeyboardReturnKeyHandler.h"
#import "IQKeyboardManager.h"
#import "Masonry.h"

#import "LoginUser.h"
#import "LoginUserTokenInfo.h"
#import "ANnetworkManage.h"


typedef NS_ENUM(NSInteger, step2_StopDate)
{
    step2_StopDate_Submit = 0,
    step2_StopDate_Vote
};

@interface SWPostMissionViewController () <UITableViewDelegate,UITableViewDataSource,SWPostMissionTableViewCellDelegate,SWPostMissionStepThreeTableViewCellDelegate,SWPostMissionStepFourTableViewCellDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,SWPostMissionAttachmentCellDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottom;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITableView *tableviewStep1;
@property (weak, nonatomic) IBOutlet UITableView *tableviewStep2;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStep3;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStep4;
@property (nonatomic, strong) NSArray *titleArrStep1;
@property (nonatomic, strong) NSArray *titleArrStep2;
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;
@property (nonatomic, strong) UIDatePicker *datePicker;
//step2 cell indxPath.row用這個判斷當前是哪個時間 use this property to decide witch time cell
@property (nonatomic, assign) NSInteger nowStep2CellIndexPath_row;
@property (nonatomic, strong) NSMutableArray *dateArrStep2;
@property (nonatomic, strong) NSString *step2StopDateOfSubmit;
@property (nonatomic, strong) NSString *step2StopDateOfVote;
@property (nonatomic, strong) SWPostMissionTableViewCell *step2StopDateOfSubmitCell;
@property (nonatomic, strong) SWPostMissionTableViewCell *step2StopDateOfVoteCell;
@property (nonatomic, strong) UIBarButtonItem *leftBarBtn;
@property (nonatomic, strong) UIBarButtonItem *rightBarBtn;
@property (weak, nonatomic) IBOutlet UILabel *altLabel;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *HUDView;
@property (nonatomic, strong) UIImagePickerController *pickerVc;
@property (nonatomic, weak) UIButton *attBtn;
@property (weak, nonatomic) NSLayoutConstraint *attBtnHeightConstraint;
@property (weak, nonatomic) NSLayoutConstraint *lineBottomConstraint;
@property (nonatomic, weak) SWPostMissionAttachmentCell *attCell;

@property (strong, nonatomic)IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *jobTypePickerArr;
//data
@property (nonatomic, weak) UITextField *job_title_textField;
@property (nonatomic, weak) UITextField *job_type_textField;
@property (nonatomic, weak) UITextField *company_name_textFiled;
@property (nonatomic, weak) UITextView *job_description_textFiled;
@property (nonatomic, weak) UITextView *works_requirements_textfield;
@property (nonatomic, copy) NSString *submission_ended_at;
@property (nonatomic, weak) UITextField *subEndDateTextField;
@property (nonatomic, weak) UITextField *endVoteTextField;
@property (nonatomic, weak) UITextField *reward_amount_textField;
@property (weak, nonatomic) UISegmentedControl *numberOfFinal;
@property (weak, nonatomic) UISegmentedControl *jobVisibility;
@property (nonatomic, weak) UILabel *jobTitleLabelStp4;
@property (nonatomic, weak) UILabel *jobAmountLabelStp4;
@property (nonatomic, weak) UILabel *submitEndLabelStp4;
@property (nonatomic, weak) UILabel *isPrivateLabelStp4;
@property (nonatomic, weak) UILabel *totalAmountStp4;
@property (nonatomic, strong) UIImage *attImage;

@end

static NSString * postMissionCellID = @"SWPostMissionTableViewCell";
static NSString * postMissionStep1CellID = @"SWPostMissionStepOneTableViewCell";
static NSString * postMissionStep3CellID = @"SWPostMissionStepThreeTableViewCell";
static NSString * postMissionStep4CellID = @"SWPostMissionStepFourTableViewCell";
static NSString * postMissionAttachmentStep1CellID = @"SWPostMissionAttachmentCell";
@implementation SWPostMissionViewController

-(NSArray *)titleArrStep1
{
    if (!_titleArrStep1) {
        _titleArrStep1 = @[@"1.任務標題",@"2.分類",@"3.公司名稱",@"4.任務背景資料",@"5.作品要求",@"6.任務附件"];
    }
    return _titleArrStep1;
    
}

-(NSArray *)titleArrStep2
{
    if (! _titleArrStep2) {
        _titleArrStep2 = @[@"1.截止投稿時間",@"2.截止投票時間"];
    }
    return _titleArrStep2;
}

-(NSMutableArray *)dateArrStep2
{
    if (! _dateArrStep2) {
        _dateArrStep2 = [NSMutableArray array];
        [_dateArrStep2 addObject:@" "];
        [_dateArrStep2 addObject:@" "];
    }
    return _dateArrStep2;
}
-(NSArray *)jobTypePickerArr
{
    if (!_jobTypePickerArr) {
        _jobTypePickerArr = @[@"商標",@"卡片",@"信封及信紙",@"戶外橫額",@"易拉架",@"單張及刊物",@"海報",@"宣傳單張",@"宣傳刊物",@"多媒體",@"網頁設計",@"網上廣告",@"品牌視覺設計",@"展板"];
    }
    return _jobTypePickerArr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"發佈任務";
    self.scrollview.delegate = self;
    self.tableviewStep1.delegate = self;
    self.tableviewStep1.estimatedRowHeight = 300;
    self.tableviewStep1.dataSource = self;
    self.tableviewStep2.delegate  =self;
    self.tableviewStep2.dataSource = self;
    self.tableViewStep3.delegate  =self;
    self.tableViewStep3.dataSource = self;
    self.tableViewStep4.delegate  =self;
    self.tableViewStep4.dataSource = self;

    [self.tableviewStep1 registerNib:[UINib nibWithNibName:postMissionCellID bundle:nil] forCellReuseIdentifier:postMissionCellID];
    [self.tableviewStep1 registerNib:[UINib nibWithNibName:postMissionStep1CellID bundle:nil] forCellReuseIdentifier:postMissionStep1CellID];
    [self.tableviewStep1 registerNib:[UINib nibWithNibName:postMissionAttachmentStep1CellID bundle:nil] forCellReuseIdentifier:postMissionAttachmentStep1CellID];
    [self.tableviewStep2 registerNib:[UINib nibWithNibName:postMissionCellID bundle:nil] forCellReuseIdentifier:postMissionCellID];
    [self.tableViewStep3 registerNib:[UINib nibWithNibName:postMissionStep3CellID bundle:nil] forCellReuseIdentifier:postMissionStep3CellID];
    [self.tableViewStep4 registerNib:[UINib nibWithNibName:postMissionStep4CellID bundle:nil] forCellReuseIdentifier:postMissionStep4CellID];

    SWPostMissionTableViewHeader *header1 = [SWPostMissionTableViewHeader postMissionTableViewHeaderAndStep:1];
    SWPostMissionTableViewHeader *header2 = [SWPostMissionTableViewHeader postMissionTableViewHeaderAndStep:2];
    SWPostMissionTableViewHeader *header3 = [SWPostMissionTableViewHeader postMissionTableViewHeaderAndStep:3];
    SWPostMissionTableViewHeader *header4 = [SWPostMissionTableViewHeader postMissionTableViewHeaderAndStep:4];
    self.tableviewStep1.tableHeaderView = header1;
    self.tableviewStep2.tableHeaderView = header2;
    self.tableViewStep3.tableHeaderView = header3;
    self.tableViewStep4.tableHeaderView = header4;
    
    IQKeyboardReturnKeyHandler *returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc]initWithViewController:self];
    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.returnKeyHandler = returnKeyHandler;
    
    //date picker
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    datePicker.minimumDate = [NSDate date];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date] animated:YES];
    self.datePicker = datePicker;
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    
    //nav
    self.leftBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(PreviousStep)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep)];
    self.rightBarBtn = self.navigationItem.rightBarButtonItem;
    
    //blur and label
    self.HUDView.hidden = YES;
    self.altLabel.hidden = YES;
    self.altLabel.text = @"登入後才能發佈任務";
    [self.altLabel sizeToFit];
    
    
    //pickerview
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerView reloadAllComponents];
    
    //imagePicker
    UIImagePickerController *pickController = [[UIImagePickerController alloc]init];
    pickController.delegate = self;
    pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickController.view.backgroundColor = [UIColor whiteColor];
    pickController.allowsEditing = YES;
    self.pickerVc = pickController;
    
    //NSNotificationCenter
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SuccessPostJobCreate:) name:@"SuccessPostJobCreate" object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    LoginUser *usr = [LoginUser shareLogingUser];
    self.HUDView.alpha = 0;
    self.altLabel.alpha = 0;
    [UIView animateWithDuration:0.25f animations:^{
        if (!usr.logined) {
            [self nonHiddenHUDviewWithStr:@"登入後才能發佈任務"];
        }else{
            if (!usr.is_publisher) {
                [self nonHiddenHUDviewWithStr:@"請先註冊為發佈人"];
            }else{
                self.altLabel.hidden = YES;
                self.HUDView.hidden = YES;
                self.navigationItem.rightBarButtonItem = self.rightBarBtn;
            }
        }
    }];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (@available(iOS 11.0, *)) {
        
    }else{
        //        self.tableviewStep1.y = self.tableviewStep2.y = self.tableViewStep3.y = self.tableViewStep4.y += 0;
        self.scrollview.y = 64;
        self.scrollview.height = self.tabBarController.tabBar.y;
        
    }
}

-(void)nonHiddenHUDviewWithStr:(NSString *)str{
    self.HUDView.alpha = 0.7f;
    self.altLabel.alpha = 1;
    self.altLabel.text = str;
    self.altLabel.hidden = NO;
    self.HUDView.hidden = NO;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview data
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableviewStep1) {
        return self.titleArrStep1.count;
    }else if (tableView == self.tableviewStep2){
        return self.titleArrStep2.count;
    }else if (tableView == self.tableViewStep3){
        return 1;
    }else{
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView==self.tableviewStep1) {
        SWPostMissionTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:postMissionCellID forIndexPath:indexPath];
        cell.title.text = self.titleArrStep1[indexPath.row];
        cell.delegate = self;
        [self.returnKeyHandler addTextFieldView:cell.textField];
        cell.step = @"step1";
        cell.textField.placeholder = @"";
        /*Data settting*/
        if (indexPath.row==0) {//title
            self.job_title_textField = cell.textField;
        }else if(indexPath.row ==1){
            self.job_type_textField = cell.textField;
//            cell.textField.delegate = self;
            cell.textField.inputView = self.pickerView;
        }else if (indexPath.row==2){
            self.company_name_textFiled = cell.textField;
        }else if (indexPath.row == 3) {
            
            SWPostMissionStepOneTableViewCell* job_descriptionCell = [tableView dequeueReusableCellWithIdentifier:postMissionStep1CellID forIndexPath:indexPath];
            self.job_description_textFiled = job_descriptionCell.textView;
            job_descriptionCell.title.text = self.titleArrStep1[indexPath.row];
            
            return job_descriptionCell;
            
        }else if(indexPath.row==4){
            
            SWPostMissionStepOneTableViewCell* works_requirementsCell = [tableView dequeueReusableCellWithIdentifier:postMissionStep1CellID forIndexPath:indexPath];
            self.works_requirements_textfield = works_requirementsCell.textView;
            works_requirementsCell.title.text = self.titleArrStep1[indexPath.row];
            
            return works_requirementsCell;
        }else if (indexPath.row == 5){
            SWPostMissionAttachmentCell *attCell = [tableView dequeueReusableCellWithIdentifier:postMissionAttachmentStep1CellID forIndexPath:indexPath];
            attCell.title.text = self.titleArrStep1[indexPath.row];
            self.attBtnHeightConstraint = attCell.attBtnHightConstraint;
            self.attBtn = attCell.attBtn;
            self.attCell = attCell;
            attCell.delegate = self;
            return attCell;
            
        }
        return cell;
    }else if(tableView == self.tableviewStep2) {
        SWPostMissionTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:postMissionCellID forIndexPath:indexPath];
        cell.title.text = self.titleArrStep1[indexPath.row];
        cell.delegate = self;
        [self.returnKeyHandler addTextFieldView:cell.textField];
        cell.title.text = self.titleArrStep2[indexPath.row];
        cell.step = @"step2";
        cell.indxpath_Row = indexPath.row;
        
        if (indexPath.row == 1) {
            cell.textField.userInteractionEnabled = NO;
            self.endVoteTextField = cell.textField;
            
        }else{
            self.subEndDateTextField = cell.textField;
        }
            
        return cell;
    }else if (tableView == self.tableViewStep3){
        SWPostMissionStepThreeTableViewCell *step3Cell = [tableView dequeueReusableCellWithIdentifier:postMissionStep3CellID forIndexPath:indexPath];
        step3Cell.delegate = self;
        step3Cell.amountTextField.delegate = self;
        self.reward_amount_textField = step3Cell.amountTextField;
        self.numberOfFinal = step3Cell.numberOfFinal;
        self.jobVisibility = step3Cell.jobVisibility;
        return step3Cell;
        
    }else{
        SWPostMissionStepFourTableViewCell *step4Cell =[tableView dequeueReusableCellWithIdentifier:postMissionStep4CellID forIndexPath:indexPath];
        step4Cell.delegate = self;
        self.jobTitleLabelStp4 = step4Cell.jobTitle;
        self.jobAmountLabelStp4 = step4Cell.amountTitle;
        self.submitEndLabelStp4 = step4Cell.jobDateLabel;
        self.isPrivateLabelStp4 = step4Cell.jobPrivateLabel;
        self.totalAmountStp4 = step4Cell.totalAmountLabel;
        
        return step4Cell;
    }
    
    return [[UITableViewCell alloc]init];
}



-(BOOL)checkJobField{
    NSString *altStr = @"";
    if ([self.job_title_textField.text isEqualToString:@""]) {
        altStr = [altStr stringByAppendingString:@"任務標題不能留空\n"];
        
    }
    if ([self.job_type_textField.text isEqualToString:@""]) {
        altStr = [altStr stringByAppendingString:@"任務類型不能留空\n"];
    }
    if ([self.company_name_textFiled.text isEqualToString:@""]) {
        altStr = [altStr stringByAppendingString:@"公司名不能留空\n"];
    }
    if ([self.job_description_textFiled.text isEqualToString:@""]) {
        altStr = [altStr stringByAppendingString:@"任務背景資料不能留空\n"];
    }
    if ([self.works_requirements_textfield.text isEqualToString:@""]) {
        altStr = [altStr stringByAppendingString:@"作品要求不能留空\n"];
    }
    if ([self.reward_amount_textField.text isEqualToString:@""]) {
        altStr = [altStr stringByAppendingString:@"任務獎金不能留空\n"];
    }
    if ([self.submission_ended_at isEqualToString:@""] || self.submission_ended_at==nil) {
        altStr = [altStr stringByAppendingString:@"任務截止投稿時間不能留空\n"];
    }
    
    
    if (![altStr isEqualToString:@""]) {// user no input
        
        [SVProgressHUD showErrorWithStatus:altStr];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD dismissWithDelay:2.5f];
//        [self PreviousStep];
        return NO;
    }
    self.jobTitleLabelStp4.text = self.job_title_textField.text;
    self.jobAmountLabelStp4.text = self.reward_amount_textField.text;
    self.submitEndLabelStp4.text = self.submission_ended_at;
    self.isPrivateLabelStp4.text = [NSString stringWithFormat:@"%@",self.jobVisibility.selectedSegmentIndex? @"保密":@"公開"];
    self.totalAmountStp4.text = self.reward_amount_textField.text;
    return YES;
}

#pragma mark - UIPickerViewDataSource delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.jobTypePickerArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.jobTypePickerArr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.job_type_textField.text = [self.jobTypePickerArr objectAtIndex:row];
}

#pragma mark - text field delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [self verifyNumber:string];
}

- (BOOL)verifyNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

#pragma mark - SWPostMissionStepFourTableViewCellDelegate submit job create
-(void)stepFourCellSubmitBtnDidClick:(SWPostMissionStepFourTableViewCell *)cell
{
    if (![self checkJobField]) {
        [self PreviousStep];
        return;
    }
    [SVProgressHUD showWithStatus:@"Loading..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    LoginUserTokenInfo *info = [LoginUserTokenInfo shareLogingUsrToken];
    
    //change jobtype to numberstr
    NSString *jobType = [NSString stringWithFormat:@"%ld",[self.jobTypePickerArr indexOfObject: self.job_type_textField.text]+1];
    NSString *numberOfFina = [self.numberOfFinal titleForSegmentAtIndex:self.numberOfFinal.selectedSegmentIndex];
    NSString *jobVisibility = self.jobVisibility.selectedSegmentIndex? @"2":@"3";
    
    [[ANnetworkManage shareNetWorkManage] postMissionJobCreateWithAccessTkn:info.access_token tknType:info.token_type andjobTitle:self.job_title_textField.text jobType:jobType copanyName:self.company_name_textFiled.text jobDesc:self.job_description_textFiled.text workRequirements:self.works_requirements_textfield.text jobAtt:self.attImage submissionEndDate:self.submission_ended_at rewardAmount:self.reward_amount_textField.text numberOfFinalists:numberOfFina jobVisibility:jobVisibility success:^(id  _Nonnull responseObject, NSString * errorMsg) {
        if (responseObject == nil) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"成功發佈"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SuccessPostJobCreate" object:nil];
        }
        [SVProgressHUD dismissWithDelay:1.5f];
    } Error:^(NSError * error) {
        NSLog(@"error = %@",error);
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"網絡錯誤，請稍後重試-code:%ld",error.code]];
    }];
}

#pragma mark - datePicker call back
-(void)dateChange:(UIDatePicker *)picker{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:picker.date];
    
    //截止投稿時間
    if (self.nowStep2CellIndexPath_row == step2_StopDate_Submit) {
        self.step2StopDateOfSubmit = dateStr;
        self.dateArrStep2[0] = dateStr;
        self.step2StopDateOfSubmitCell.textField.text = dateStr;
        self.submission_ended_at = dateStr;
        //截止投票是截止投稿的七天后
        NSTimeInterval  oneDay = 24*60*60*1;
        NSDate *endVoteDate = [[NSDate alloc] initWithTimeInterval:oneDay * 7 sinceDate:picker.date];
        NSString *dateStr1 = [formatter stringFromDate:endVoteDate];
        self.endVoteTextField.text = dateStr1;
    }
    /*
    else{//截止投票時間
        self.step2StopDateOfVote = dateStr;
        self.dateArrStep2[1] = dateStr;
        self.step2StopDateOfVoteCell.textField.text = dateStr;
    }
    */
}
#pragma mark - page func
-(void)PreviousStep
{
    if (self.scrollview.contentOffset.x - self.view.frame.size.width <= 0) {
     
        [self.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    }else
    {
        [self.scrollview setContentOffset:CGPointMake(self.scrollview.contentOffset.x - self.view.frame.size.width, 0) animated:YES];
    }
  
}

-(void)nextStep{
    ////防止暴力点击
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextStepClicked)object:self.rightBarBtn];
    [self performSelector:@selector(nextStepClicked )withObject:self.rightBarBtn afterDelay:0.2f];
}

//这里才真正做下一步
-(void)nextStepClicked{
    if (self.scrollview.contentOffset.x >= (self.scrollview.contentSize.width - self.view.frame.size.width)){
        [self.scrollview setContentOffset:CGPointMake(self.scrollview.contentOffset.x , 0) animated:YES];
        
    }else{
        [self.scrollview setContentOffset:CGPointMake(self.scrollview.contentOffset.x + self.view.frame.size.width, 0) animated:YES];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    if (self.scrollview.contentOffset.x > 0) {
        self.navigationItem.leftBarButtonItem = self.leftBarBtn;
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    //    NSLog(@"content of set = %f, width = %f",self.scrollview.contentOffset.x,self.scrollview.contentSize.width);
    if (self.scrollview.contentOffset.x >= (self.scrollview.contentSize.width - self.view.frame.size.width)) {
        
        self.navigationItem.rightBarButtonItem = nil;
        if(![self checkJobField]){
            [self PreviousStep];
        }
        
    }else
    {
        self.navigationItem.rightBarButtonItem = self.rightBarBtn;
    }
    
}

#pragma mark - cellDelegate Step1
-(void)postMissionTableCellTextFieldDidChangeToEditing:(SWPostMissionTableViewCell *)cell textField:(UITextField *)textField
{
    if ([cell.step isEqualToString:@"step2"]) {
        
        cell.textField.inputView = self.datePicker;
        //記錄當前是在哪一個cell(是投稿時間還是截止投票時間)
        self.nowStep2CellIndexPath_row = cell.indxpath_Row;
        //把cell整個對象記錄起來
        if (cell.indxpath_Row==step2_StopDate_Submit) {
            
            self.step2StopDateOfSubmitCell = cell;
        }else{
            
            self.step2StopDateOfVoteCell = cell;
        }
        
    }
}
-(void)postMissionAttachmentBtnDidClick:(SWPostMissionAttachmentCell *)cell attBtn:(UIButton *)attBtn{
//    [self checkPhotoLibraryAndOpenPhotoPicker];
    [self checkDevicePermissionAndPhotoLibraryAuth];
}


#pragma mark - imagePicker
-(void)alertActionShow{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"App獲取不了相冊權限" message:@"請在本機中設置允許訪問相冊權限" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *set = [UIAlertAction actionWithTitle:@"前往設置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [actionSheet addAction:set];
    [actionSheet addAction:ok];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
- (void)checkDevicePermissionAndPhotoLibraryAuth{
    
    BOOL auth = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    if (!auth) return;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) { //pop up the alterBox
        if (status == PHAuthorizationStatusAuthorized) { // has right
            dispatch_async(dispatch_get_main_queue(),^{

                self.pickerVc.sourceType   = UIImagePickerControllerSourceTypePhotoLibrary;
                self.pickerVc.allowsEditing = NO;
                [self presentViewController:self.pickerVc animated:YES completion:nil];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(),^{ // no right
                [self alertActionShow];
            });
            
        }
    }];
}


#pragma mark - picker call back
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    if (picker.allowsEditing) {
        image = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    }
    self.attImage = image;
    self.attCell.attImage = image;
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"imagePickerVcFinishedPickCallBack" object:image];
    //    NSLog(@"call = %@",image);
    
    //    UIImageWriteToSavedPhotosAlbum(image, self, selectorToCall, NULL);
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}



-(void)postMissionTableCellNextBtnDidClick:(SWPostMissionTableViewCell *)cell nextBtn:(UIButton *)nextBtn
{
    [self.scrollview setContentOffset:CGPointMake(self.scrollview.contentOffset.x + self.view.frame.size.width, 0) animated:YES];
}
#pragma mark - cellDelegate Step3
-(void)postMissionStepThreeCell:(SWPostMissionStepThreeTableViewCell *)cell nextBtnDidClick:(UIButton *)nextBtn
{
    [self.scrollview setContentOffset:CGPointMake(self.scrollview.contentOffset.x + self.view.frame.size.width, 0) animated:YES];
}
#pragma mark - NSNotification call back
-(void)SuccessPostJobCreate:(NSNotification *)notif{
    PostMissionSucceedViewController *succVC = [[PostMissionSucceedViewController alloc]init];
    succVC.jobTitleLabelStr = self.job_title_textField.text;
    succVC.jobTypeLabelStr = self.job_type_textField.text;
    succVC.jobVibLabelStr = [self.jobVisibility titleForSegmentAtIndex:self.jobVisibility.selectedSegmentIndex];
    succVC.finalLabelStr = [self.numberOfFinal titleForSegmentAtIndex:self.numberOfFinal.selectedSegmentIndex];
    succVC.submitEndDateLabelStr = self.submission_ended_at;
    succVC.jobAmountLabelStr = self.reward_amount_textField.text;
    succVC.companyNameLabelStr = self.company_name_textFiled.text;
    [self.navigationController presentViewController:succVC animated:YES completion:nil];
    
    self.endVoteTextField.text = 
    self.jobTitleLabelStp4.text =
    self.jobAmountLabelStp4.text =
    self.totalAmountStp4.text =
    self.isPrivateLabelStp4.text =
    self.submitEndLabelStp4.text =
    self.reward_amount_textField.text =
    self.job_description_textFiled.text =
    self.works_requirements_textfield.text =
    self.company_name_textFiled.text =
    self.submission_ended_at =
    self.subEndDateTextField.text =
    self.job_type_textField.text =
    self.job_title_textField.text = @"";
    [self.attBtn setImage:[UIImage imageNamed:@"addButton"] forState:UIControlStateNormal];
    [self.scrollview setContentOffset:CGPointMake(0, 0) animated:NO];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = self.rightBarBtn;
                                                            
}

#pragma mark - dealloc
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
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
