//
//  SWWorkDetailCollectionController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/27.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

//UI
#import "SWWorkDetailCollectionController.h"
#import "SWNowPostWorksCollectionViewCell.h"
#import "SWWorkDetailHeaderView.h"
#import "SWScreenHelper.h"
#import "SWLikeView.h"
#import "SWMissionWorkDetailCollectionViewController.h"
#import "SWUserCenterViewController.h"
#import "SWSubmitJobTableViewController.h"
#import "SWMissionWorkDetailTableViewController.h"

#import "SVProgressHUD.h"

//Network
#import "ANnetworkManage.h"
#import "SWCalculateTool.h"
#import "UIImageView+WebCache.h"
//data
#import "MissionDetailModel.h"
#import "MissionWorkModel.h"
#import "LoginUser.h"
#import "LoginUserTokenInfo.h"
#import "UserModel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SWWorkDetailCollectionController ()<UICollectionViewDelegateFlowLayout,SWNowPostWorksCollectionViewCellDelegate,SWWorkDetailHeaderViewDelegate>

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) UIButton *submitBtn;
@property (nonatomic, weak) SWWorkDetailHeaderView *headerView;
@property (nonatomic, strong) MissionDetailModel *missionJobModel;
@property (nonatomic, strong) UserModel *postUser;
@property (nonatomic, strong) NSMutableArray *workListModelArr;

@end

@implementation SWWorkDetailCollectionController

static NSString * const nowPostWorksCollectionViewCellID = @"SWNowPostWorksCollectionViewCell";

+(instancetype)workDetailColletionController
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    SWWorkDetailCollectionController *workDetailVC = [[SWWorkDetailCollectionController alloc]initWithCollectionViewLayout:flowlayout];
    workDetailVC.flowLayout = flowlayout;
    return workDetailVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self mapData];
}

-(void)setUpUI{
    self.view.backgroundColor = [UIColor whiteColor];
//    self.imageArr = [NSArray arrayWithObjects:@"test00",@"test01",@"test02",@"test03",@"test04",@"test05",@"test06",@"test07",@"test08", nil];
    self.title = @"任務詳情";
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    } else {
        // Fallback on earlier versions
    }
    self.collectionView.scrollsToTop = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:nowPostWorksCollectionViewCellID bundle:nil] forCellWithReuseIdentifier:nowPostWorksCollectionViewCellID];
    CGFloat itemWidth = (SCREEN_WIDTH -5) / 2;
    CGFloat itemHight = 250;
    //joinBtnHeight;
    CGFloat joinBtnWH = 70;
    CGFloat joinBtnFont = 15;
    if ([[SWScreenHelper iphoneScreenType] isEqualToString:IPHONE6_SIZE_SCREEN]) {
        itemHight = 200;
        joinBtnWH = 50;
        joinBtnFont = 13.f;
    }
    
    self.flowLayout.itemSize = CGSizeMake(itemWidth, itemHight);
    self.flowLayout.minimumInteritemSpacing = 5 ;
    self.flowLayout.minimumLineSpacing = 5;
    
    
    //also can use Collection Reusable View , but here user view
    SWWorkDetailHeaderView *header = [[UINib nibWithNibName:@"SWWorkDetailHeaderView" bundle:nil] instantiateWithOwner:nil options:nil][0];
    self.headerView = header;
    header.delegate = self;
    [self.collectionView addSubview:header];
    
    //Change Lable Constant label自適應height
    CGSize bgLabelSize = [header.missionBackgroundDetailLabel sizeThatFits:CGSizeMake(header.missionBackgroundDetailLabel.frame.size.width, 0)];
    CGSize requslabelSize =  [header.missionRequirementsLabel sizeThatFits:CGSizeMake(header.missionRequirementsLabel.frame.size.width, 0)];
    
    header.missionBackgroundDetailLabelConstraintHeight.constant = bgLabelSize.height;
    header.missionRequirementsLabelConstraintHeight.constant = requslabelSize.height;
   
    [header layoutIfNeeded];
//    header.workCountLabel.text = [NSString stringWithFormat:@" - %ld",self.imageArr.count];
    CGFloat headerHeight = CGRectGetMaxY(header.bottomLabel.frame);
    header.frame = CGRectMake(0,0, self.view.frame.size.width,headerHeight);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(header.frame.size.height + 10, 0, 0, 0 );
    
    
    
    //join btn
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - joinBtnWH - 20 , 40, joinBtnWH, joinBtnWH)];
    [submitBtn setTitle:@" 投稿\n🙋🏻‍♂️🙋🏻" forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    submitBtn.titleLabel.numberOfLines = 0;
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:joinBtnFont];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(15)/255.0 blue:(24)/255.0 alpha:1.0];
    submitBtn.layer.cornerRadius = joinBtnWH/2;
    [submitBtn.layer masksToBounds];
    submitBtn.hidden = YES;
    submitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    submitBtn.layer.borderWidth = 2.0f;
    [submitBtn addTarget:self action:@selector(submitBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.submitBtn = submitBtn;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.submitBtn];
    
    UIImageView *background =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SigninBackGround"]];
    background.frame = self.view.frame;
    self.collectionView.backgroundView = background;
}

-(void)mapData{
    [SVProgressHUD showWithStatus:@"Job Detail Loading..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //mission detail
    [[ANnetworkManage shareNetWorkManage]getMissionDetailWithMissionID:self.missionID success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
        /*
        if (!errorMsg && responseObject != nil) {
            
            MissionDetailModel *model = [[MissionDetailModel alloc]initWithJsonToModel:responseObject];
            self.missionJobModel = model;
            //update UI
            [self updateUIWithModel:model];
        }else{
            
            NSLog(@"SWWorkDetailVc request error 獲取任務詳情失敗 error = %@",errorMsg);
        }
        */
        MissionDetailModel *jobModel = [[MissionDetailModel alloc]initWithJsonToModel:responseObject];
        self.missionJobModel = jobModel;
        
        //update UI
        [self updateUIWithMissionModel:jobModel];
        [SVProgressHUD dismissWithDelay:1.2f];
    } Error:^(NSError * _Nonnull errorBack) {
        NSLog(@"SWWorkDetailVc 獲取任務詳情服務器或字段error %@",errorBack);
        [SVProgressHUD showErrorWithStatus:@"Network error，請稍後重試"];
        [SVProgressHUD dismissWithDelay:1.f];
    }];
    
    //mission works
    [[ANnetworkManage shareNetWorkManage] getMissionWorkListWithMissionID:self.missionID  andPage:@"" success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
        /*if (responseObject != nil && !errorMsg ) {
            NSArray *responseArr =responseObject;
            NSMutableArray *workListArr = [NSMutableArray array];
            for (int i = 0; i < responseArr.count; ++i) {
                MissionWorkModel *model = [[MissionWorkModel alloc]initWithJsonToModel:responseArr[i]];
                [workListArr addObject:model];
            }
            self.workListModelArr = workListArr;
            [self.collectionView reloadData];
        }else{
            NSLog(@"SWWorkDetailVc requset 獲取任務作品list error %@",errorMsg);
        }*/
        NSArray *responseArr =responseObject;
        NSMutableArray *workListArr = [NSMutableArray array];
        for (int i = 0; i < responseArr.count; ++i) {
            MissionWorkModel *model = [[MissionWorkModel alloc]initWithJsonToModel:responseArr[i]];
            [workListArr addObject:model];
        }
        self.workListModelArr = workListArr;
        [self.collectionView reloadData];
        
    } Error:^(NSError * _Nonnull errorBack) {
        NSLog(@"SWWorkDetailVc 獲取任務作品list服務器或字段error %@",errorBack);
    }];
    
}

-(void)updateUIWithMissionModel:(MissionDetailModel *)jobModel{
    
    NSString *beforeReleTime = [SWCalculateTool calculatTimeDiffFromCurrentToEndTimeReturnTime:jobModel.release_date];
    NSString *submitEndDate = [SWCalculateTool formatDateTo_yyyy_MM_dd_HH_mm_ss:jobModel.submit_date];
    NSString *releseDate = [SWCalculateTool formatDateTo_yyyy_MM_dd_HH_mm_ss:jobModel.release_date];
    
    NSInteger subEndTime = [SWCalculateTool calculatCurrentTimeAndEndTime:submitEndDate];
    //2018-08-27 23:59:59.000000
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *subEnd = [formatter dateFromString:submitEndDate];
    NSTimeInterval  oneDay = 24*60*60*1;
    NSDate *endVoteDate = [[NSDate alloc] initWithTimeInterval:oneDay * 7 sinceDate:subEnd];
    NSString *endVoteDateStr = [formatter stringFromDate:endVoteDate];
    
    self.headerView.missionTpyeLabel.text = jobModel.job_type_display;
    self.headerView.amountLabel.text = jobModel.reward_amount_display;
    self.headerView.winAmountLabel.text = jobModel.winner_amount_display;
    self.headerView.missionTitle.text = jobModel.job_title;
    self.headerView.finalCountLabel.text =  jobModel.number_of_finalists;
    self.headerView.final_inAmountLabel.text = jobModel.finalist_amount_display;
    self.headerView.releaseDate.text = releseDate;
    self.headerView.submitDate.text = submitEndDate;
    self.headerView.votingDate.text = endVoteDateStr;
    self.headerView.jobIDLabel.text = [NSString stringWithFormat:@"#%@",jobModel.job_id];
    [self.headerView.iconImageView sd_setImageWithURL:[NSURL URLWithString:jobModel.postsJobUser.profile_picture]];
    //need filter html
    self.headerView.missionBackgroundDetailLabel.text = [SWCalculateTool stringFilterHTMLTag:jobModel.job_description];
    self.headerView.missionRequirementsLabel.text = [SWCalculateTool stringFilterHTMLTag:jobModel.works_requirements];
    self.headerView.workCountLabel.text = jobModel.works_count;
    self.headerView.workCountLabel1.text = [NSString stringWithFormat:@"%@人參與",jobModel.works_count];
    self.headerView.viewsLabel.text = [NSString stringWithFormat:@"%@views",jobModel.views];
    self.headerView.releaseDateLabel1.text = [NSString stringWithFormat:@"%@前發佈",beforeReleTime];
    self.headerView.postsJobtUserNmaeLabel.text = jobModel.postsJobUser.username;
    self.headerView.postsJobUidLabel.text = [NSString stringWithFormat:@"#%@",jobModel.postsJobUser.user_id];
    //Change Lable Constant label自適應height
    CGSize bgLabelSize = [self.headerView.missionBackgroundDetailLabel sizeThatFits:CGSizeMake(self.headerView.missionBackgroundDetailLabel.frame.size.width, 0)];
    CGSize requslabelSize =  [self.headerView.missionRequirementsLabel sizeThatFits:CGSizeMake(self.headerView.missionRequirementsLabel.frame.size.width, 0)];

    self.headerView.missionBackgroundDetailLabelConstraintHeight.constant = bgLabelSize.height;
    self.headerView.missionRequirementsLabelConstraintHeight.constant = requslabelSize.height;

    [self.headerView layoutIfNeeded];
    //    header.workCountLabel.text = [NSString stringWithFormat:@" - %ld",self.imageArr.count];
    CGFloat headerHeight = CGRectGetMaxY(self.headerView.bottomLabel.frame);
    self.headerView.frame = CGRectMake(0,0, self.view.frame.size.width,headerHeight);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(self.headerView.frame.size.height + 10, 0, 0, 0 );
    
    //subBtn
//    NSLog(@"time %ld",subEndTime);
    if (!(subEndTime < 0)) {
        self.submitBtn.hidden = NO;
    }
}



-(void)submitBtnDidClick:(UIButton *)submitBtn{
    
    if (![LoginUser shareLogingUser].email) {// un login
        [self showInfoWithStatusBySVP:@"登入候才能投稿！！"];
    }else if(![LoginUser shareLogingUser].is_designer){
        [self showInfoWithStatusBySVP:@"注意，您的帳號尚未完成創意人認證。完成認證便可投稿。"];

    }else{
    
        SWSubmitJobTableViewController *submitJobVc = [[SWSubmitJobTableViewController alloc]init];
        submitJobVc.missionModel = self.missionJobModel;
        [self.navigationController  pushViewController:submitJobVc animated:YES];
    }
}

-(void)showInfoWithStatusBySVP:(NSString *)status{
    [SVProgressHUD showInfoWithStatus:status];
    [SVProgressHUD dismissWithDelay:2.0f];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self.submitBtn removeFromSuperview];
    [UIView animateWithDuration:0.25f animations:^{
        self.submitBtn.alpha = 0;
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar addSubview:self.submitBtn];
    [UIView animateWithDuration:0.25f animations:^{
        self.submitBtn.alpha = 1;
    }];

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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.workListModelArr.count) {
        return self.workListModelArr.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SWNowPostWorksCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:nowPostWorksCollectionViewCellID forIndexPath:indexPath];
    cell.delegate = self;
    MissionWorkModel *workModel =self.workListModelArr[indexPath.row];
    if (workModel.is_winner) {
        cell.winner_or_finalList = @"winner";
    }else if (workModel.is_finalist){
        cell.winner_or_finalList = @"final_list";
    }else{
        cell.winner_or_finalList = @"";
    }
    cell.workTitle.text = workModel.work_title;
    [cell.workImageView sd_setImageWithURL:[NSURL URLWithString:workModel.thumbnail] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.viewsLabel.text = workModel.views;
    cell.voteLabel.text = workModel.votes;
    cell.voteBtn.enabled = workModel.can_vote? YES:NO;
    cell.is_protected =workModel.is_protected;
    cell.workid = workModel.work_id;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWMissionWorkDetailTableViewController *workDetailVc = [[SWMissionWorkDetailTableViewController alloc]init];
    MissionWorkModel *wkModel = self.workListModelArr[indexPath.row];
    workDetailVc.workID = wkModel.work_id;
    [self.navigationController pushViewController:workDetailVc animated:YES];
//    [self.navigationController pushViewController: [SWMissionWorkDetailCollectionViewController missionWorkDrtailCollectionViewController] animated:YES];
}

#pragma mark - SWNowPostWorksCollectionViewCellDelegate
-(void)nowPostWorksLikeBtnDidClick:(SWNowPostWorksCollectionViewCell *)cell btn:(UIButton *)btn{
    CGFloat SEC = 1.5f;
    LoginUserTokenInfo *usrInfo = [LoginUserTokenInfo shareLogingUsrToken];
    if (!usrInfo.access_token) {
        [SVProgressHUD showInfoWithStatus:@"登入後才能投票"];
        [SVProgressHUD dismissWithDelay:SEC];
        return;
    }
    [SWLikeView likeViewShow];

    [[ANnetworkManage shareNetWorkManage] workVote:cell.workid andAccessTkn:usrInfo.access_token tknType:usrInfo.token_type success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
        NSLog(@"responseObject %@",responseObject);
        NSString *status =responseObject[@"status"];
        if (status.integerValue < 0) {
            NSString *errStr = [NSString stringWithFormat:@"%@\n%@",responseObject[@"error_code"],responseObject[@"error_message"]];
            [SVProgressHUD showInfoWithStatus:errStr];
            [SVProgressHUD dismissWithDelay:SEC];
        }
    } Error:^(NSError * _Nonnull errorBack) {
        NSLog(@"SWWorkDetailCollectionControllerWorkVote server error: %@",errorBack);
        [SVProgressHUD showErrorWithStatus:@"Server Error, 請稍後重試"];
        [SVProgressHUD dismissWithDelay:SEC];
    }];
}


#pragma mark - SWWorkDetailHeaderViewDelegate
-(void)headerViewTopViewDidClick:(UIView *)header
{
    SWUserCenterViewController *userCenterVc = [[SWUserCenterViewController alloc]init];
    userCenterVc.title = @"發佈人資料";
    userCenterVc.isCurrentUser = NO;
    userCenterVc.userModel = self.missionJobModel.postsJobUser;
//    NSLog(@"post = %@",self.postUser);
    [self.navigationController pushViewController:userCenterVc animated:YES];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
