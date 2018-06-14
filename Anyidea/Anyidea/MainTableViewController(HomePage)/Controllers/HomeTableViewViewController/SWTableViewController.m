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

#import "SDCycleScrollView.h"
#import "Masonry.h"


@interface SWTableViewController () <SDCycleScrollViewDelegate,WorkDetailedViewControllerDelegate>

@property(nonatomic,strong) SDCycleScrollView *bannerView;

@property (nonatomic , strong )NSArray *imageStrArr;
@property (nonatomic,assign)NSInteger openNum;
@end

static NSString * const mianTableViewCellID = @"MainTableViewCell";
static NSString * const newsTableViewCellID = @"SWNewsTableViewCell";
static NSString * const newMissionsTableViewCellID = @"SWNewMissionsTableViewCell";
static NSString * const mainTableViewPortfolioCellID = @"MainTableViewPortfolioCell";

@implementation SWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    } else {
        // Fallback on earlier versions
    }
    [self setUpBannerView];
    [self setUpTableViewCell];

    
    
    
    self.navigationItem.title = @"anyidea";
    self.imageStrArr = @[@"onlinestore-banner_v1-1",@"attachmentiphone",@"BillionsAndBillions",@"Cantina"];
    self.tableView.scrollsToTop = YES;

    [self testJson];
    
}


-(void)testJson{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"homeTestJson" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"dic - %@",  result);
    NSArray *bannerData = [result valueForKey:@"banner"];
//    NSLog(@"banner = %@",bannerData);
     for (NSDictionary *dic in bannerData) {
//        NSLog(@"%@",dic);
        //字典轉模型
        SWBannerModel *bannerModel  = [SWBannerModel bannerModelWithDic:dic];
        NSLog(@"banner = %@",bannerModel.url);
    }
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
- (IBAction)RightItemClick:(UIBarButtonItem *)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:true completion:^(BOOL finished) {
    }];
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
    NSArray * imageArr = [NSArray arrayWithObjects:@"onlinestore-banner_v1-1",@"BillionsAndBillions",@"Cantina",@"thumb_5f3",nil];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 5;
    }else if (section == 3){
        return 1;
    }
    return self.imageStrArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0){//最新任務列表
        
        SWNewMissionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newMissionsTableViewCellID];
        cell.numberTitle.text = [NSString stringWithFormat:@"%ld.",indexPath.row + 1];
//        cell.missionTitle.text = @"$100 公司logo創作";
        cell.statusImageView.image = [UIImage imageNamed:@"greenPoint"];
        return cell;
    }
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
}

#pragma mark - SDCycleScrollView Delegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"click:%ld",index);
}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"height = %f",[super tableView:tableView heightForRowAtIndexPath:indexPath]);
    if (indexPath.section == 3){//PortfolioCell(作品集)
        return [SWScreenHelper fixCollectionItemSize].height+2;
    }
//    else if (indexPath.section == 0){
//        return 50.f;
//    }
    return  [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [MainTableViewHeaderMissions mainTableViewHeaderMissions];
    }
    if (section == 1) {//最新行業情報
      MainTableViewHeader *header1 =  [MainTableViewHeader mainTableViewHeader];
        header1.TitleLabel.text  = @"最新行業情報";
        header1.BodyLable.text  =@"最新最hit系曬度！";
        return header1;
    }
    
    if (section == 3) {//中標作品集
        MainTableViewHeader *header1 =  [MainTableViewHeader mainTableViewHeader];
        header1.TitleLabel.text  = @"中標作品集";
        header1.BodyLable.text  =@"在每份完成的任務中，我們收集了值得與你共賞的作品。";
        return header1;
    }
    
    return [MainTableViewHeader mainTableViewHeader];
}

static CGFloat const headerHeight = 50.f;
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
    //Test
    if (indexPath.row==0) {
        workDetailVC.testBackGroundInfo = @"第一個item for test label 這個是背景資料";
        workDetailVC.testMissionRequs = @"第一個item的任務需求";
    }
    
    [self.navigationController pushViewController:workDetailVC animated:YES];
    
}
-(void)workVC:(WorkDetailedViewController *)workVC autoNum:(NSInteger)autoNum
{
    NSLog(@"tableview拿到了AutoNum = %ld",autoNum);
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
