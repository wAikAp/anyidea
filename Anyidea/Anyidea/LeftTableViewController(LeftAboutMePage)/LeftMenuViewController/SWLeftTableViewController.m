//
//  SWLeftTableViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2017/11/8.
//  Copyright © 2017年 shingwai chan. All rights reserved.


#define HEADHEIGHT [UIScreen mainScreen].bounds.size.height / 3 //headViewHeight
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width


#import "SWLeftTableViewController.h"
#import "LoginViewController.h"
#import "MainNavigationController.h"
#import "SWMessageTableViewController.h"
#import "SWUserCenterViewController.h"
#import "SWWorkManagementViewController.h"
#import "SWUserModel.h"

#import "Masonry.h"
#import "UIViewController+MMDrawerController.h"

@interface SWLeftTableViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *custromHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *HeaderImageView;
@property (weak, nonatomic) IBOutlet UIButton *userNameLabel;
@property (nonatomic,strong)NSArray *tableArr;
@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (nonatomic, assign) BOOL fristLoad;
@property (nonatomic, strong) SWUserModel *userModel;
@end

@implementation SWLeftTableViewController

static NSString *const leftTabelCellID = @"LeftTabelCell";

#pragma mark - 懶加載
-(SWUserModel *)userModel
{
    if (!_userModel) {
        _userModel = [SWUserModel userModel];
    }
    return _userModel;
}

-(NSArray *)tableArr
{
    if (_tableArr == nil) {
        _tableArr = @[@"短消息",@"個人資料",@"過往作品",@"設定",@"登出"];
    }
    return _tableArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self mapData];
}

-(void)setUpUI{
    
    float headerImageViewWidth = [UIScreen mainScreen].bounds.size.width / 4;
    self.custromHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, HEADHEIGHT);
    self.navigationController.delegate = self;
   
    __weak typeof(self) weakSelf = self;
    [self.HeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.custromHeaderView);
        make.centerY.mas_equalTo(weakSelf.custromHeaderView).mas_offset(weakSelf.navigationController.navigationBar.frame.size.height);
        make.width.height.mas_equalTo(headerImageViewWidth);
    }];
    self.HeaderImageView.layer.cornerRadius = headerImageViewWidth/2;
    self.HeaderImageView.clipsToBounds = YES;
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.HeaderImageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(weakSelf.HeaderImageView);
    }];
    self.userNameLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    float logoHight = self.tableView.contentSize.height;
    self.logoView.frame = CGRectMake(0, logoHight, self.view.frame.size.width, SCREEN_HEIGHT - logoHight - 20);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftTabelCellID];
    
    UIImageView *background =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SigninBackGround"]];
    background.frame = self.view.frame;

    self.tableView.backgroundView = background;
    self.tableView.backgroundColor = [UIColor clearColor];
}

-(void)mapData{
    [self.userNameLabel setTitle:self.userModel.name forState:UIControlStateNormal] ;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftTabelCellID forIndexPath:indexPath];

    cell.textLabel.text = self.tableArr[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (IBAction)iconAndUserNameDidClick:(UIButton *)sender {
 //
    UINavigationController *logInView = [[MainNavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
    [self showViewController:logInView sender:self];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0 ) {
        SWMessageTableViewController *messageVC = [[SWMessageTableViewController alloc]init];
        MainNavigationController *navVc = [[MainNavigationController alloc]initWithRootViewController:messageVC];
        [self showViewController:navVc sender:self];
        
    }else if (indexPath.row == 1  ){
        SWUserCenterViewController *userCenterVc = [[SWUserCenterViewController alloc]init];
        MainNavigationController *navVc = [[MainNavigationController alloc]initWithRootViewController:userCenterVc];
        [self showViewController:navVc sender:self];
        
    }else if (indexPath.row == 2){
        SWWorkManagementViewController *workManageMentVc = [[SWWorkManagementViewController alloc]init];
        MainNavigationController *navVc = [[MainNavigationController alloc]initWithRootViewController:workManageMentVc];
        [self showViewController:navVc sender:self];
    }else if (indexPath.row == 4){
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"登出" message:@"確定要登出？" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        UIAlertAction *exit = [UIAlertAction actionWithTitle:@"登出" style:    UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [actionSheet addAction:cancel];
        [actionSheet addAction:exit];
        [self showViewController:actionSheet sender:nil];
    }
    
}

////當跳轉時會調用
//-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
//{
//
//}

@end
