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
#import "SVProgressHUD.h"

#import "ConfigString.h"
#import "ANnetworkManage.h"
//sd image
#import "UIButton+WebCache.h"

@interface SWUserCenterViewController ()<UITableViewDelegate , UITableViewDataSource,SWUserCenterHeaderViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *uiArr;
@property (nonatomic, strong) NSArray *dataArr;


@property (nonatomic, weak) SWUserCenterHeaderView *centerHeader;

@end

@implementation SWUserCenterViewController

static NSString *const userCenterCellID = @"SWUserCenterTableViewCell";

-(NSArray *)uiArr
{
    if (!_uiArr) {
        _uiArr = @[@"用戶名",@"用戶身份",@"電子郵件"/*,@"加入時間"*/];
    }
    return _uiArr;
}
-(NSArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSArray arrayWithObjects:@"loading...",@"loading...",@"loading...",@"loading...", nil];
    }
    return _dataArr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mapData];
    [self setUpUI];
    NSString *name;
//    NSString *usrID;
    NSString *bad_points;
    NSString *good_points;
    NSString *pictureURL;
    if (self.isCurrentUser) {
//        [self.centerHeader.userNameBtn setTitle:self.curLogInUsr.name forState:UIControlStateNormal];
//        [self.centerHeader.iconBtn sd_setImageWithURL:[NSURL URLWithString:self.curLogInUsr.profile_picture_url] forState:UIControlStateNormal];
        
        self.centerHeader.logoutBtnImage.hidden = NO;
        self.centerHeader.logoutBtnText.hidden = NO;
        name = self.curLogInUsr.name;
        pictureURL = self.curLogInUsr.profile_picture_url;
        good_points = self.curLogInUsr.good_points;
        bad_points = self.curLogInUsr.bad_points;
        
    }else{
        self.centerHeader.logoutBtnImage.hidden = YES;
        self.centerHeader.logoutBtnText.hidden = YES;
        name = self.userModel.username;
        pictureURL = self.userModel.profile_picture;
        
        good_points = self.userModel.good_points;
        bad_points = self.userModel.bad_points;
       
    }
    [self.centerHeader.userNameBtn setTitle:name forState:UIControlStateNormal];
    [self.centerHeader.iconBtn sd_setImageWithURL:[NSURL URLWithString:pictureURL] forState:UIControlStateNormal];
    [self.centerHeader.likeBtn setTitle:good_points forState:UIControlStateNormal];
    [self.centerHeader.bombBtn setTitle:bad_points forState:UIControlStateNormal];
}


-(void)setUpUI{
    
    if (!self.title) {
        self.title = @"個人資料";
    }
//    NSLog(@"didload %@",self.navigationController);
    if (self.isPresentVc) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(leftNavBarBtnDidClick:)];
    }
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:userCenterCellID bundle:nil] forCellReuseIdentifier:userCenterCellID] ;
    SWUserCenterHeaderView *header = [SWUserCenterHeaderView userCenterHeaderView];
    self.centerHeader = header;
    header.delegate = self;
    self.tableView.tableHeaderView = header;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
}

-(void)mapData{
    if (self.isCurrentUser) {
        NSString *isDesigner = self.curLogInUsr.is_designer? @"創意人":@"";
        NSString *isPublisher = self.curLogInUsr.is_publisher? @"發佈人":@"";
        NSString *userPos = [NSString stringWithFormat:@"%@ %@",isDesigner,isPublisher];
        NSArray *dataArr = @[self.curLogInUsr.name,userPos,self.curLogInUsr.email,@""];
        self.dataArr = dataArr;
    }else{
        self.uiArr = @[];
        [self.tableView reloadData];
    }
    
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
    if (self.isCurrentUser) {
        if (indexPath.row ==0 || indexPath.row == 2) {//0用戶名 2電子郵件
//            SWUserEditingViewController *editVc = [[SWUserEditingViewController alloc]init];
//            editVc.text = self.dataArr[indexPath.row];
            //[self.navigationController pushViewController:editVc animated:YES];
        }
    }
    
    
}

#pragma mark - SWUserCenterHeaderViewDelegate
-(void)userCenterHeader:(SWUserCenterHeaderView *)header introcutionBtnDidClick:(UIButton *)introcutionBtn introcutionLabel:(UILabel *)introcutionLabel
{
    if (self.isCurrentUser) {
        SWUserEditingViewController *editVc = [[SWUserEditingViewController alloc]init];
        [self.navigationController pushViewController:editVc animated:YES];
        editVc.text = introcutionLabel.text;
    }
}

-(void)userCenterHeader:(SWUserCenterHeaderView *)header iconBtnDidClick:(UIButton *)iconBtn
{
    SWUserIconViewController *userIconVc = [[SWUserIconViewController alloc]init];
    userIconVc.hidesBottomBarWhenPushed = YES;
    userIconVc.image = self.centerHeader.iconBtn.imageView.image;
    [self.navigationController pushViewController:userIconVc animated:YES];
}


-(void)userCenterHeader:(SWUserCenterHeaderView *)header submitedJobsBtnDidClick:(UIButton *)btn
{
//    SWWorkManagementViewController *workManagementVc = [[SWWorkManagementViewController alloc]init];
//    
//    [self.navigationController pushViewController:workManagementVc animated:YES];
    
}

-(void)userCenterHeader:(SWUserCenterHeaderView *)header logoutBtnDidClick:(UIButton *)btn{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"登出" message:@"確定要登出？" preferredStyle:UIAlertControllerStyleAlert];
   
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
   
    UIAlertAction *exit = [UIAlertAction actionWithTitle:@"登出" style:    UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self logOutCall];
    }];

    [actionSheet addAction:cancel];
    [actionSheet addAction:exit];
    [self presentViewController:actionSheet animated:YES completion:nil];
//    [self showViewController:actionSheet sender:btn];

}


-(void)logOutCall{
    __weak __typeof(self)weakSelf = self;
    LoginUserTokenInfo *info = [LoginUserTokenInfo shareLogingUsrToken];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [[ANnetworkManage shareNetWorkManage] logOutWithAccessToken:info.access_token andTokenyType:info.token_type success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
        
        weakSelf.curLogInUsr.logined = NO;
        weakSelf.curLogInUsr = NULL;
        [SVProgressHUD showSuccessWithStatus:@"已登出"];
        [SVProgressHUD dismissWithDelay:.8f completion:^{
            
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                //post notic
                [[NSNotificationCenter defaultCenter] postNotificationName:LogOut_Success object:nil];
                
            }];
        }];

    } Error:^(NSError * _Nonnull errorBack) {
        [SVProgressHUD showErrorWithStatus:@"網絡問題，登出失敗"];

    }];
}

#pragma mark - Navigation



@end
