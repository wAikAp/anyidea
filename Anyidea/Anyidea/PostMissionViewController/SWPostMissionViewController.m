//
//  SWPostMissionViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/3/16.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWPostMissionViewController.h"
#import "SWPostMissionTableViewCell.h"
#import "SWPostMissionTableViewHeader.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQKeyboardManager.h"
#import "SWPostMissionStepThreeTableViewCell.h"
#import "SWPostMissionStepFourTableViewCell.h"

typedef NS_ENUM(NSInteger, step2_StopDate)
{
    step2_StopDate_Submit = 0,
    step2_StopDate_Vote
};

@interface SWPostMissionViewController () <UITableViewDelegate,UITableViewDataSource,SWPostMissionTableViewCellDelegate,SWPostMissionStepThreeTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITableView *tableviewStep1;
@property (weak, nonatomic) IBOutlet UITableView *tableviewStep2;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStep3;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStep4;
@property (nonatomic, strong) NSArray *titleArrStep1;
@property (nonatomic, strong) NSArray *titleArrStep2;
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;
@property (nonatomic, strong) UIDatePicker *datePicker;
//step2 cell indxPath.row用這個判斷當前是哪個時間
@property (nonatomic, assign) NSInteger nowStep2CellIndexPath_row;
@property (nonatomic, strong) NSMutableArray *dateArrStep2;
@property (nonatomic, strong) NSString *step2StopDateOfSubmit;
@property (nonatomic, strong) NSString *step2StopDateOfVote;
@property (nonatomic, strong) SWPostMissionTableViewCell *step2StopDateOfSubmitCell;
@property (nonatomic, strong) SWPostMissionTableViewCell *step2StopDateOfVoteCell;
@property (nonatomic, strong) UIBarButtonItem *leftBarBtn;

@end

static NSString * postMissionCellID = @"SWPostMissionTableViewCell";
static NSString * postMissionStep3CellID = @"SWPostMissionStepThreeTableViewCell";
static NSString * postMissionStep4CellID = @"SWPostMissionStepFourTableViewCell";
@implementation SWPostMissionViewController

-(NSArray *)titleArrStep1
{
    if (!_titleArrStep1) {
        _titleArrStep1 = @[@"1.任務標題",@"2.分類",@"3.公司名稱",@"4.任務背景資料",@"5.作品要求",@"6.任務附件",@"下一步"];
    }
    return _titleArrStep1;
    
}

-(NSArray *)titleArrStep2
{
    if (! _titleArrStep2) {
        _titleArrStep2 = @[@"1.截止投稿時間",@"2.截止投票時間",@"下一步"];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"發佈任務";
    self.scrollview.delegate = self;
    self.tableviewStep1.delegate = self;
    self.tableviewStep1.dataSource = self;
    self.tableviewStep2.delegate  =self;
    self.tableviewStep2.dataSource = self;
    self.tableViewStep3.delegate  =self;
    self.tableViewStep3.dataSource = self;
    self.tableViewStep4.delegate  =self;
    self.tableViewStep4.dataSource = self;

    [self.tableviewStep1 registerNib:[UINib nibWithNibName:postMissionCellID bundle:nil] forCellReuseIdentifier:postMissionCellID];
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
//    header1.frame = CGRectMake(0, 0, header1.frame.size.width, header1.frame.size.height);
//    header2.frame = header3.frame = header4.frame = header1.frame;
    IQKeyboardReturnKeyHandler *returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc]initWithViewController:self];
    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.returnKeyHandler = returnKeyHandler;
    
    //date picker
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    datePicker.minimumDate = [NSDate date];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date] animated:YES];
    self.datePicker = datePicker;
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    
    //nav
    self.leftBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(PreviousStep)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
        if (indexPath.row == 4) {
            cell.textField.placeholder = @"作品尺寸、解像度、顏色及感覺等";
        }else if (indexPath.row == 5){
            cell.attBtn.hidden = NO;
            cell.textField.hidden = YES;
            cell.lineView.hidden = YES;
        }else if (indexPath.row == 6){
            cell.title.hidden = YES;
            cell.textField.hidden = YES;
            cell.lineView.hidden = YES;
            cell.nextBtn.hidden = NO;
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
        if (indexPath.row == 2) {
            cell.title.hidden = YES;
            cell.textField.hidden = YES;
            cell.lineView.hidden = YES;
            cell.nextBtn.hidden = NO;
        }
        return cell;
    }else if (tableView == self.tableViewStep3){
        SWPostMissionStepThreeTableViewCell *step3Cell = [tableView dequeueReusableCellWithIdentifier:postMissionStep3CellID forIndexPath:indexPath];
        step3Cell.delegate = self;
        return step3Cell;
        
    }else{
        SWPostMissionStepFourTableViewCell *step4Cell =[tableView dequeueReusableCellWithIdentifier:postMissionStep4CellID forIndexPath:indexPath];
        return step4Cell;
    }
    
    return [[UITableViewCell alloc]init];
}


-(void)dateChange:(UIDatePicker *)picker{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:picker.date];
    
    //截止投稿時間
    if (self.nowStep2CellIndexPath_row == step2_StopDate_Submit) {
        self.step2StopDateOfSubmit = dateStr;
        self.dateArrStep2[0] = dateStr;
        self.step2StopDateOfSubmitCell.textField.text = dateStr;
    }
    else{//截止投票時間
        self.step2StopDateOfVote = dateStr;
        self.dateArrStep2[1] = dateStr;
        self.step2StopDateOfVoteCell.textField.text = dateStr;
    }
    
}

-(void)PreviousStep
{
    if (self.scrollview.contentOffset.x - self.view.frame.size.width <= 0) {
     
        [self.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    }else
    {
        [self.scrollview setContentOffset:CGPointMake(self.scrollview.contentOffset.x - self.view.frame.size.width, 0) animated:YES];
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
        }else
        {
            
            self.step2StopDateOfVoteCell = cell;
        }
        
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    if (self.scrollview.contentOffset.x > 0) {
        self.navigationItem.leftBarButtonItem = self.leftBarBtn;
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
