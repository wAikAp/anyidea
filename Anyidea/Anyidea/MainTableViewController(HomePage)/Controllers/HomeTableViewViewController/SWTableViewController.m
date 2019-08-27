//
//  SWTableViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2017/11/8.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#define WINDOW_WIDTH [UIScreen mainScreen].bounds.size.width
#define WINDOW_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HEADHEIGHT [UIScreen mainScreen].bounds.size.height / 3 //headViewHeight


#import "SWTableViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MainTableViewCell.h"
#import "MainTableViewPortfolioCell.h"
#import "MainTableViewHeader.h"
#import "WorkDetailedViewController.h"
#import "MainTableViewHeaderMissions.h"
#import "SWWorkDetailedTableViewController.h"
#import "SWWorkDetailCollectionController.h"
#import "SWScreenHelper.h"
#import "SWNewsTableViewCell.h"
#import "SWNewMissionsTableViewCell.h"
#import "SWBannerModel.h"
#import "SWHotMissionViewCell.h"
#import "ANnetworkManage.h"
#import "MissionModel.h"
#import "MissionWorkModel.h"
#import "SWMissionWorkDetailTableViewController.h"
#import "SearchViewController.h"
#import "WEBViewController.h"

#import "SDCycleScrollView.h"
#import "Masonry.h"
#import "SVProgressHUD.h"


@interface SWTableViewController () <SDCycleScrollViewDelegate,WorkDetailedViewControllerDelegate>

@property(nonatomic,strong) SDCycleScrollView *bannerView;

@property (nonatomic , strong )NSArray *imageStrArr;
@property (nonatomic,assign)NSInteger openNum;
@property (nonatomic, strong) NSMutableArray *missionModelArr;
@property (nonatomic, strong) NSArray *loadingModelArr;
@end

static NSString * const mianTableViewCellID = @"MainTableViewCell";
static NSString * const newsTableViewCellID = @"SWNewsTableViewCell";
//static NSString * const newMissionsTableViewCellID = @"SWNewMissionsTableViewCell";
static NSString * const newMissionsTableViewCellID = @"SWHotMissionViewCell";
static NSString * const mainTableViewPortfolioCellID = @"MainTableViewPortfolioCell";

@implementation SWTableViewController

-(NSArray *)loadingModelArr{
    if (!_loadingModelArr) {
        MissionModel *msModel = [[MissionModel alloc]init];
        _loadingModelArr = @[msModel,msModel,msModel];
    }
    return _loadingModelArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"iOS %@",[[UIDevice currentDevice] systemVersion]);
    if (@available(iOS 11.0, *)) {//later or equal than iOS 11.0
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
        
        
    } else {
        // Fallback on earlier versions
        NSLog(@"Less than iOS 11.0");
    }
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self setUpBannerView];
    [self setUpTableViewCell];
    [self mapData];


    self.navigationItem.title = @"anyidea";
    self.imageStrArr = @[@"anyidea_banner_20180502",@"anyidea_ebanner_banner_20181204"];
    self.tableView.scrollsToTop = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(porftolioCellCallBack:) name:@"porftolioCellCallBack" object:nil];
}

-(void)mapData{
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[ANnetworkManage shareNetWorkManage] getNewMissionsWithSearch:@"" status:@"" page:@"" success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
            
            if (errorMsg != nil) {
                NSLog(@"SWTableViewVc獲取token錯誤 - %@",errorMsg);
                [SVProgressHUD showErrorWithStatus:@"獲取任務失敗，請稍後重試"];
                [SVProgressHUD dismissWithDelay:1.2f];
            }else  if(errorMsg == nil && responseObject != nil){
                //success get the missions
                NSArray *reObjArr =responseObject[@"items"];
                NSMutableArray *missionModelArr = [NSMutableArray array];
                for (int i = 0; i < reObjArr.count; ++i) {
                    MissionModel *model = [[MissionModel alloc]initWithJsonToModel:reObjArr[i]];
                    [missionModelArr addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.missionModelArr = missionModelArr;
                    [self.tableView reloadData];
                    [SVProgressHUD dismissWithDelay:0.25f];
                });
            }
            
        } Error:^(NSError * _Nonnull errorBack) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD showErrorWithStatus:@"網絡錯誤，請稍後重試"];
                [SVProgressHUD dismissWithDelay:2.f];
            });
            NSLog(@"SWTableViewVc服務器error = %@",errorBack);
        }];
        
    });
  
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

}

- (IBAction)leftItemClick:(UIBarButtonItem *)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:true completion:^(BOOL finished) {
    }];
}

- (IBAction)rightItemClick:(UIBarButtonItem *)sender {
    [self mapData];
//    NSMakeRange(0, 2);
    
    [self.tableView reloadSections: [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] withRowAnimation:UITableViewRowAnimationFade];
}
- (IBAction)searchItemDidClick:(UIBarButtonItem *)sender {
    
    SearchViewController *searchVc = [[SearchViewController alloc]init];
    [self.navigationController
     pushViewController:searchVc animated:YES];
    
}



-(void)setUpTableViewCell
{
    [self.tableView registerNib:[UINib nibWithNibName:mianTableViewCellID bundle:nil] forCellReuseIdentifier:mianTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:newsTableViewCellID bundle:nil] forCellReuseIdentifier:newsTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:mainTableViewPortfolioCellID bundle:nil] forCellReuseIdentifier:mainTableViewPortfolioCellID];
    [self.tableView registerNib:[UINib nibWithNibName:newMissionsTableViewCellID bundle:nil] forCellReuseIdentifier:newMissionsTableViewCellID];
    
    self.tableView.estimatedRowHeight = 150;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
}
- (void)setUpBannerView
{
    NSArray * imageArr = @[@"anyidea_banner_20180502",@"anyidea_ebanner_banner_20181204"];
    
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WINDOW_WIDTH,HEADHEIGHT) imageNamesGroup:imageArr];
    
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _bannerView.pageControlDotSize = CGSizeMake(10 , 10);
    _bannerView.autoScrollTimeInterval = 5;
    _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _bannerView.backgroundColor = [UIColor blackColor];
    _bannerView.delegate = self;
    _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    self.tableView.tableHeaderView = _bannerView;
}

//作品集 collection view cell did click call back func
-(void)porftolioCellCallBack:(NSNotification *)notif{
    SWMissionWorkDetailTableViewController *workDetailVc = [[SWMissionWorkDetailTableViewController alloc]init];
    MissionWorkModel *wkModel = notif.object;
    workDetailVc.workID = wkModel.work_id;
    [self.navigationController pushViewController:workDetailVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if(section == 0){;
        if (!self.missionModelArr.count) {
            return self.loadingModelArr.count;
        }
        return self.missionModelArr.count;
    }else{//作品集
        return 1;
    }
    
//    if (section == 1) {
//        return 5;
//    }else if (section == 3){
//        return 1;
//    }else if(section == 0){;
//        return self.missionModelArr.count;
//    }
//    return self.imageStrArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0){//最新任務列表
        NSArray *dataArr;
        if (!self.missionModelArr.count) {
            dataArr = self.loadingModelArr;
            SWHotMissionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newMissionsTableViewCellID];
            return cell;
        }else{
            dataArr = self.missionModelArr;
        }
        SWHotMissionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newMissionsTableViewCellID];
        MissionModel *msModel = dataArr[indexPath.row];
        
        cell.titleLabel.text = msModel.job_title;
        cell.missionStatus = msModel.status;
        cell.peopleLabel.text = [NSString stringWithFormat:@"%@人參與", msModel.works_count];
        cell.viewsLabel.text = [NSString stringWithFormat:@"%@ views",msModel.views];
        cell.PriceLabel.text = [NSString stringWithFormat:@"%@", msModel.reward_amount_display];
        cell.submitEndDate = msModel.submitEndDate;
        cell.missionType = msModel.job_type_display;
        cell.bodyLabel.text = [NSString stringWithFormat:@"#%@",msModel.missionId];
        return cell;
    }else{
        //中標作品集
        MainTableViewPortfolioCell *cell = [tableView dequeueReusableCellWithIdentifier:mainTableViewPortfolioCellID];
        return cell;
        
    }
        
     /*
    if (indexPath.section == 1) {//行業情報
        SWNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsTableViewCellID];
        cell.newsTitle.text = @"「最新行情」這是最新消息哦-護衛隊憑藉為奇偶大屏手機數據線覺得我脾氣哦就是當年";
        return cell;
    }
    
    if (indexPath.section == 3) {//中標作品集
        MainTableViewPortfolioCell *cell = [tableView dequeueReusableCellWithIdentifier:mainTableViewPortfolioCellID];
        return cell;
    }
    
    //原創作品
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mianTableViewCellID];
    NSString *name = self.imageStrArr[indexPath.row];
    cell.photoImage = [UIImage imageNamed:name];
    return cell;
      */
}

#pragma mark - SDCycleScrollView Delegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    NSLog(@"click:%ld",index);
//    https://www.anyidea.hk/zh/job/create/can-print
//    WEBViewController *webVc = [WEBViewController new];
//    webVc.webURL = @"https://www.anyidea.hk/zh/job/create/can-print";
//    [self.navigationController pushViewController:webVc animated:YES];
    self.tabBarController.selectedIndex = 1;
}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSLog(@"height = %f, section = %ld",[super tableView:tableView heightForRowAtIndexPath:indexPath],indexPath.section);
    
    if (indexPath.section == 1){//PortfolioCell(作品集)
        return [SWScreenHelper fixCollectionItemSize].height+2;
    }

    return  [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [MainTableViewHeaderMissions mainTableViewHeaderMissions];
    }
//    if (section == 1) {//最新行業情報
//      MainTableViewHeader *header1 =  [MainTableViewHeader mainTableViewHeader];
//        header1.TitleLabel.text  = @"最新行業情報";
//        header1.BodyLable.text  =@"最新最hit系曬度！";
//        return header1;
//    }
    
    else {//中標作品集
        MainTableViewHeader *header1 =  [MainTableViewHeader mainTableViewHeader];
        header1.TitleLabel.text  = @"最新投稿作品";
        header1.BodyLable.text  =@"在每份完成的任務中，我們收集了值得與你共賞的作品。";
        return header1;
    }
    
}

static CGFloat const headerHeight = 58.f;
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if ([[SWScreenHelper iphoneScreenType] isEqualToString:IPHONESE_SIZE_SCREEN]) {
//        return 40;
//    }
    return headerHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWWorkDetailCollectionController *workDetailVC = [SWWorkDetailCollectionController workDetailColletionController];
    if (self.missionModelArr.count && indexPath.section == 0) {
        MissionModel *model = self.missionModelArr[indexPath.row];
        workDetailVC.missionID = model.missionId;
        [self.navigationController pushViewController:workDetailVC animated:YES];
    }
}


-(void)workVC:(WorkDetailedViewController *)workVC autoNum:(NSInteger)autoNum
{
    //NSLog(@"tableview AutoNum = %ld",autoNum);
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
