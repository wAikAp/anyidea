//
//  SWLeftTableViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2017/11/8.
//  Copyright © 2017年 shingwai chan. All rights reserved.


#define HEADHEIGHT [UIScreen mainScreen].bounds.size.height / 3 //headViewHeight
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "ConfigString.h"
#import "SWLeftTableViewController.h"
#import "LoginViewController.h"
#import "MainNavigationController.h"
#import "SWMessageTableViewController.h"
#import "SWUserCenterViewController.h"
#import "SWWorkManagementViewController.h"

#import "SWUserModel.h"
#import "LoginUser.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "Masonry.h"
#import "UIViewController+MMDrawerController.h"
#import "SWScreenHelper.h"

@interface SWLeftTableViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *custromHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *HeaderImageView;
@property (weak, nonatomic) IBOutlet UIButton *userNameLabel;
@property (nonatomic,strong)NSArray *tableArr;
@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (nonatomic, assign) BOOL fristLoad;
//@property (nonatomic, strong) SWUserModel *userModel;
@property (nonatomic, weak) LoginUser *userModel;
@end

@implementation SWLeftTableViewController

static NSString *const leftTabelCellID = @"LeftTabelCell";

#pragma mark - lazy load
//-(LoginUser *)userModel
//{
//    if (!_userModel) {
//        _userModel = [LoginUser shareLogingUser];
//    }
//    return _userModel;
//}

-(NSArray *)tableArr
{
    if (_tableArr == nil) {
        _tableArr = @[/*@"短消息",*/@"個人資料"/*,@"過往作品",@"設定",@"登出"*/];
    }
    return _tableArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserDataSuccessCallBackByNotification:) name:Get_User_Data_Success object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogouted:) name:LogOut_Success object:nil];
    
    [self setUpUI];
    [self mapData];
}

-(void)userLogouted:(NSNotification *)notifi{
    self.userModel = notifi.object;
    [self mapData];
}
//login success will call the get userdata api, if success that function will active
-(void)getUserDataSuccessCallBackByNotification:(NSNotification *)notifi{

    self.userModel = notifi.object;
    [self mapData];
}
-(void)setUpUI{
    
    CGFloat headerImageViewWidth = [UIScreen mainScreen].bounds.size.width / 4;
    self.custromHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, HEADHEIGHT);
    self.navigationController.delegate = self;
   
    __weak typeof(self) weakSelf = self;
    [self.HeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.custromHeaderView);
        make.centerY.mas_equalTo(weakSelf.custromHeaderView).mas_offset(weakSelf.navigationController.navigationBar.frame.size.height);
        make.width.height.mas_equalTo(headerImageViewWidth);
    }];
    
    [SWScreenHelper viewToCircleView:self.HeaderImageView];
    
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
    NSString *name;
    if (!self.userModel) {
        name = @"登入";
        [self.HeaderImageView setImage:[UIImage imageNamed:@"defaultIcon"] forState:UIControlStateNormal];
    }else{
        name =self.userModel.name;
        [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.profile_picture_url] forState:UIControlStateNormal];
    }
    [self.userNameLabel setTitle:name forState:UIControlStateNormal] ;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

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

    [self jumpToLoginVcOrUserCenterVc];
}

-(void)jumpToLoginVcOrUserCenterVc{
    if (!self.userModel.name) {
        LoginViewController *login = [[LoginViewController alloc]init];
        UINavigationController *logInView = [[MainNavigationController alloc]initWithRootViewController:login];
//        __weak __typeof(self)weakSelf = self;
//        [login setLoginSuccessBlock:^(LoginUser *useroModel) {
//            weakSelf.userModel = useroModel;
//            [weakSelf mapData];
//        }];
        [self showViewController:logInView sender:self];
    }else{
        SWUserCenterViewController *usrCenterVc = [[SWUserCenterViewController alloc]init];
        UINavigationController *nav = [[MainNavigationController alloc]initWithRootViewController:usrCenterVc];
        usrCenterVc.curLogInUsr = self.userModel;
        usrCenterVc.isCurrentUser = YES;
        usrCenterVc.isPresentVc = YES;
        [self showDetailViewController:nav sender:self];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableArr[indexPath.row] isEqualToString:@"個人資料"]  ){
        //        SWUserCenterViewController *userCenterVc = [[SWUserCenterViewController alloc]init];
        //        MainNavigationController *navVc = [[MainNavigationController alloc]initWithRootViewController:userCenterVc];
        //        [self showViewController:navVc sender:self];
        [self jumpToLoginVcOrUserCenterVc];
    }
    /*
    if (indexPath.row == 0 ) {
        SWMessageTableViewController *messageVC = [[SWMessageTableViewController alloc]init];
        MainNavigationController *navVc = [[MainNavigationController alloc]initWithRootViewController:messageVC];
        [self showViewController:navVc sender:self];
        
    }else if ([self.tableArr[indexPath.row] isEqualToString:@"個人資料"]  ){
//        SWUserCenterViewController *userCenterVc = [[SWUserCenterViewController alloc]init];
//        MainNavigationController *navVc = [[MainNavigationController alloc]initWithRootViewController:userCenterVc];
//        [self showViewController:navVc sender:self];
        [self jumpToLoginVcOrUserCenterVc];
        
    }else if (indexPath.row == 2){
        SWWorkManagementViewController *workManageMentVc = [[SWWorkManagementViewController alloc]init];
        MainNavigationController *navVc = [[MainNavigationController alloc]initWithRootViewController:workManageMentVc];
        [self showViewController:navVc sender:self];
    }else if (indexPath.row == 4){
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"登出" message:@"確定要登出？" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        __weak __typeof(self)weakSelf = self;
        UIAlertAction *exit = [UIAlertAction actionWithTitle:@"登出" style:    UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.userModel = NULL;
            [weakSelf mapData];
        }];
        
        [actionSheet addAction:cancel];
        [actionSheet addAction:exit];
        [self showViewController:actionSheet sender:nil];
    }
    */
}

-(void)dealloc{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:Get_User_Data_Success object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"LeftVc dealloc");
}

////當跳轉時會調用
//-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
//{
//
//}

@end
