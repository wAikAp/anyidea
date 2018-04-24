//
//  SWUserCenterViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/20.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWUserCenterViewController.h"
#import "SWUserCenterTableViewCell.h"
#import "SWUserCenterHeaderView.h"
#import "SWUserEditingViewController.h"
#import "SWUserIconViewController.h"
#import "SWWorkManagementViewController.h"

@interface SWUserCenterViewController ()<UITableViewDelegate , UITableViewDataSource,SWUserCenterHeaderViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *uiArr;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation SWUserCenterViewController

static NSString *const userCenterCellID = @"SWUserCenterTableViewCell";

-(NSArray *)uiArr
{
    if (!_uiArr) {
        _uiArr = [NSArray arrayWithObjects:@"用戶名",@"用戶身份",@"電子郵件",@"加入時間", nil];
    }
    return _uiArr;
}
-(NSArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSArray arrayWithObjects:@"UserName",@"發佈人",@"willaaaasxxx@gmail.com",@"20-10-2017", nil];
    }
    return _dataArr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setUpData];
}

-(void)setUpUI{
    
    if (!self.title) {
        self.title = @"個人資料";
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(leftNavBarBtnDidClick:)];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:userCenterCellID bundle:nil] forCellReuseIdentifier:userCenterCellID] ;
    SWUserCenterHeaderView *header = [SWUserCenterHeaderView userCenterHeaderView];
    header.delegate = self;
    self.tableView.tableHeaderView = header;
    
    [header.IntroductionBtn setTitle:@"這是我的自我介紹我時代of你的啥的身份就愛上了；分；low解放啦；色即是空能吃嗎，下載查看積極瓦護膚理念是佛千萬困難發卡機平方米" forState:UIControlStateNormal];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
}

-(void)setUpData{
    self.currentUser = YES;
}

-(void)leftNavBarBtnDidClick:(UIBarButtonItem *)barBtn
{
    UIViewController *fromViewController =  [self.navigationController popViewControllerAnimated:YES];
    if (fromViewController == nil) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
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
    return self.uiArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWUserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userCenterCellID forIndexPath:indexPath];
    cell.title.text = self.uiArr[indexPath.row];
    cell.contentLabel.text = self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentUser) {
        if (indexPath.row ==0 || indexPath.row == 2) {//0用戶名 2電子郵件
            SWUserEditingViewController *editVc = [[SWUserEditingViewController alloc]init];
            editVc.text = self.dataArr[indexPath.row];
            [self.navigationController pushViewController:editVc animated:YES];
        }
    }
    
    
}

#pragma mark - SWUserCenterHeaderViewDelegate
-(void)userCenterHeader:(SWUserCenterHeaderView *)header introcutionBtnDidClick:(UIButton *)introcutionBtn
{
    if (self.currentUser) {
        SWUserEditingViewController *editVc = [[SWUserEditingViewController alloc]init];
        [self.navigationController pushViewController:editVc animated:YES];
        
        if ([introcutionBtn.titleLabel.text isEqualToString:@"新增簡介"]) {
            editVc.text = @"";
        }else{
            editVc.text = introcutionBtn.titleLabel.text;
        }
    }
}

-(void)userCenterHeader:(SWUserCenterHeaderView *)header iconBtnDidClick:(UIButton *)iconBtn
{
    SWUserIconViewController *userIconVc = [[SWUserIconViewController alloc]init];
    userIconVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userIconVc animated:YES];
}
-(void)userCenterHeader:(SWUserCenterHeaderView *)header submitedJobsBtnDidClick:(UIButton *)btn
{
    SWWorkManagementViewController *workManagementVc = [[SWWorkManagementViewController alloc]init];
    
    [self.navigationController pushViewController:workManagementVc animated:YES];
    
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
