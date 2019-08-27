//
//  SearchViewController.m
//  Anyidea
//
//  Created by shingwai chan on 26/4/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "SearchViewController.h"
#import "UIView+Extension.h"
#import "UIImage+Color.h"
#import "SWHotMissionViewCell.h"
#import "ANnetworkManage.h"
#import "MissionModel.h"
#import "SWScreenHelper.h"
#import "SVProgressHUD.h"
#import "SearchFooterView.h"
#import "SWWorkDetailCollectionController.h"

@interface SearchViewController ()<UISearchControllerDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>
@property (weak, nonatomic) UIActivityIndicatorView *activeView;
@property (nonatomic, weak)IBOutlet UILabel *currentPageLabel;
@property (strong, nonatomic) UISearchController *searchController;
//all jobs tableview
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic)IBOutlet  UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
//Search result tableview
@property (weak, nonatomic)  UITableView *resultTableView;
@property (nonatomic, weak) UIView *resultTableViewBackGround;
@property (nonatomic, strong) NSMutableArray *resultArr;

@property (nonatomic, weak) SearchFooterView *footerView;

@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSString *per_page;
@property (nonatomic, strong) NSString *last_page;
@property (nonatomic, strong) NSString *current_page;
@property (nonatomic, copy) NSString *postedPage;


@end

@implementation SearchViewController
static NSString * const newMissionsTableViewCellID = @"SWHotMissionViewCell";


-(void)setUpSearchController{
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    self.searchController.searchBar.placeholder = @"Search jobs";
    self.searchController.searchBar.translucent = NO;
   
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    //    self.searchController.searchBar.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(15)/255.0 blue:(24)/255.0 alpha:1.0];
    //cover
    //    self.searchController.dimsBackgroundDuringPresentation = NO;
    //    UITextField *searchField = [self.searchController.searchBar valueForKey:@"_searchField"];
    //    [searchField setBackgroundColor:[UIColor grayColor]];
    //    UILabel*lab = [searchField valueForKey:@"_placeholderLabel"];
    //    [lab setTextColor:[UIColor blackColor]];
    //
    //    for(UIView *view in [[[_searchController.searchBar subviews] objectAtIndex:0] subviews]){
    //        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
    //            view.alpha = 0.0f;
    //        }else if([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")] ){
    //            view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //        }
    //    }


    [self.searchController.searchBar sizeToFit];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    
}

-(void)setUpAlljobsTableView{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [SWScreenHelper screenWidth] ,[SWScreenHelper screenHeight])];
    self.tableView = tableview;
    self.tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    SearchFooterView *footerView = [SearchFooterView searchFooterView];
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
    [self.tableView registerNib:[UINib nibWithNibName:newMissionsTableViewCellID bundle:nil] forCellReuseIdentifier:newMissionsTableViewCellID];
}

-(void)setUpResultTableView{
    UITableView *resultTableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [SWScreenHelper screenWidth] ,[SWScreenHelper screenHeight])style:UITableViewStyleGrouped ];
    self.resultTableView = resultTableview;
    self.resultTableView.delegate = self;
    self.resultTableView.dataSource = self;
    
    UIActivityIndicatorView *activeView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(([SWScreenHelper screenWidth]/2)-20, 140, 20, 20)];
    [activeView startAnimating];
    activeView.color = [UIColor blackColor];
    self.activeView = activeView;
    
    UIView *resultTableViewBackGround = [[UIView alloc]initWithFrame:self.resultTableView.frame];
    resultTableViewBackGround.y = 44;
    resultTableViewBackGround.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    self.resultTableViewBackGround = resultTableViewBackGround;
    [resultTableViewBackGround addSubview:activeView];
    [resultTableViewBackGround addSubview:self.resultTableView];
    [self.searchController.view addSubview:resultTableViewBackGround];
    [self.resultTableView registerNib:[UINib nibWithNibName:newMissionsTableViewCellID bundle:nil] forCellReuseIdentifier:newMissionsTableViewCellID];
    self.resultTableView.estimatedRowHeight = self.tableView.estimatedRowHeight = 150;
}

#pragma mark View did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    self.resultArr = [NSMutableArray array];
    self.postedPage = @"0";
    self.current_page = @"1";
    self.last_page = @"⏳";
    self.title = @"All Jobs";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSearchController];
    [self setUpAlljobsTableView];
    [self setUpResultTableView];
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchController;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
//        [self.searchController.searchBar.heightAnchor constraintLessThanOrEqualToConstant: 44].active = YES;
         [self.searchController.searchBar setBackgroundImage:[UIImage new]];
    } else {
        self.searchController.searchBar.frame = CGRectMake(0, 0, Screen_Width, 44);
        UIView *v = [[UIView alloc] initWithFrame:self.searchController.searchBar.bounds];
        v.frame = CGRectMake(v.x, 0, v.width, v.height);
        [v addSubview:self.searchController.searchBar];
        self.searchController.searchBar.searchBarStyle = UISearchBarStyleDefault;
        [self.view addSubview:v];
        self.tableView.y += v.height;
        
        
    }
    self.resultTableView.hidden =YES;
    self.definesPresentationContext=YES;
//    self.searchController.hidesNavigationBarDuringPresentation = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view bringSubviewToFront:self.currentPageLabel];
    [SWScreenHelper viewToCircleView:self.currentPageLabel cornerRadius:10.f];
    [self updatePageLabelWithCurrent:self.current_page last:self.last_page];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self searchByKeyWords:@"" status:@"" page:self.current_page isSlipTable:YES];
}



-(void)searchByKeyWords:(NSString *)keywords status:(NSString *)status page:(NSString *)page isSlipTable:(BOOL)isSlip{

    
    if ([self.postedPage isEqualToString: page] ) {
        NSLog(@"Post same page return！");
        return;
    }else if(isSlip){
        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"Loading Page: %@",page]];
        
        self.postedPage = page;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[ANnetworkManage shareNetWorkManage] getNewMissionsWithSearch:keywords status:status page:page success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
                //        NSLog(@"posting");
                if (errorMsg != nil) {
                    NSLog(@"SWTableViewVc獲取token錯誤 - %@",errorMsg);
                    [SVProgressHUD showErrorWithStatus:@"獲取任務失敗，請稍後重試"];
                    [SVProgressHUD dismissWithDelay:2.f];
                }else  if(errorMsg == nil && responseObject != nil){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.last_page = responseObject[@"last_page"];
                        self.per_page = responseObject[@"per_page"];
                        
                        //success get the missions
                        NSArray *reObjArr = responseObject[@"items"];
                        NSMutableArray *missionModelArr = [NSMutableArray array];
                        for (int i = 0; i < reObjArr.count; ++i) {
                            MissionModel *model = [[MissionModel alloc]initWithJsonToModel:reObjArr[i]];
                            [missionModelArr addObject:model];
                        }
                        if (self.searchController.active) {
                            //                NSLog(@"active");
                            self.resultArr = missionModelArr;
                            self.resultTableView.hidden = NO;
                            [self.resultTableView reloadData];
                            
                        }else{
                            
                            [self.dataArr addObjectsFromArray: missionModelArr];
                            [self.tableView reloadData];
                            self.resultTableView.hidden =YES;
                            
                            NSInteger curr = self.current_page.integerValue;
                            curr++;
                            self.current_page = [NSString stringWithFormat:@"%ld",curr];
//                            NSLog(@"cur = %@",self.current_page);
                            
                            [SVProgressHUD dismissWithDelay:0.5f];
                        }
                        NSLog(@"Search successful");
                    });
                }
                
            } Error:^(NSError * _Nonnull errorBack) {
                
                NSLog(@"SWTableViewVc服務器error = %@",errorBack);
                [SVProgressHUD showErrorWithStatus:@"網絡錯誤，請稍後重試"];
                [SVProgressHUD dismissWithDelay:2.f];
            }];
        });
    }else if(self.searchController.active){
        //is search by keyword
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[ANnetworkManage shareNetWorkManage] getNewMissionsWithSearch:keywords status:status page:page success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
                //        NSLog(@"posting");
                if (errorMsg != nil) {
                    NSLog(@"SWTableViewVc獲取token錯誤 - %@",errorMsg);
                    [SVProgressHUD showErrorWithStatus:@"獲取任務失敗，請稍後重試"];
                    [SVProgressHUD dismissWithDelay:2.f];
                }else  if(errorMsg == nil && responseObject != nil){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //success get the missions
                        NSArray *reObjArr = responseObject[@"items"];
                        NSMutableArray *missionModelArr = [NSMutableArray array];
                        for (int i = 0; i < reObjArr.count; ++i) {
                            MissionModel *model = [[MissionModel alloc]initWithJsonToModel:reObjArr[i]];
                            [missionModelArr addObject:model];
                        }
                        self.resultArr = missionModelArr;
                        self.resultTableView.hidden = NO;
                        [self.resultTableView reloadData];
         
                        [SVProgressHUD dismissWithDelay:0.5f];
                        NSLog(@"Search successful");
                    });
                }
                
            } Error:^(NSError * _Nonnull errorBack) {
                
                NSLog(@"SWTableViewVc服務器error = %@",errorBack);
                [SVProgressHUD showErrorWithStatus:@"網絡錯誤，請稍後重試"];
                [SVProgressHUD dismissWithDelay:2.f];
            }];
        });
    }
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
//    [self.resultArr removeAllObjects];
//    [self.resultTableView reloadData];
    
    if ([searchController.searchBar.text isEqualToString:@""]) {
        if (@available(iOS 11.0, *)) {
            self.view.y = 0;//fix 當searchbar 用largeTitle時 view自動向下移問題
        }
        self.resultTableViewBackGround.hidden = YES;
        
    }else{
        if (@available(iOS 11.0, *)) {
            self.searchController.view.y = 9;//fix 當searchbar 用largeTitle時 view自動向下移問題
        }
        self.resultTableViewBackGround.hidden = NO;
        self.resultTableView.hidden = YES;
        [self searchByKeyWords:searchController.searchBar.text status:@"" page:@"" isSlipTable:NO];
    }

}
-(void)willDismissSearchController:(UISearchController *)searchController{
//    self.activeView.hidden = YES;
//    self.resultTableView.hidden = YES;
}
-(void)didDismissSearchController:(UISearchController *)searchController{
//    NSLog(@" dis y = %lf",self.view.y);
}
-(void)updatePageLabelWithCurrent:(NSString *)current last:(NSString *)last{
    
    self.currentPageLabel.text = [NSString stringWithFormat:@"page: %@ / %@",current,last];
//    [self.currentPageLabel sizeToFit];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.resultTableView) {
        return self.resultArr.count;
        
    }else{
        
        return self.dataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SWHotMissionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newMissionsTableViewCellID];
    MissionModel *msModel;
    
    if (tableView==self.resultTableView) {
        msModel = self.resultArr[indexPath.row];
    }else{
        msModel = self.dataArr[indexPath.row];
        
    }
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row+1,msModel.job_title];
    cell.missionStatus = msModel.status;
    cell.peopleLabel.text = [NSString stringWithFormat:@"%@人參與", msModel.works_count];
    cell.viewsLabel.text = [NSString stringWithFormat:@"%@ views",msModel.views];
    cell.PriceLabel.text = [NSString stringWithFormat:@"%@", msModel.reward_amount_display];
    cell.submitEndDate = msModel.submitEndDate;
    cell.missionType = msModel.job_type_display;
    cell.bodyLabel.text = [NSString stringWithFormat:@"#%@",msModel.missionId];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SWWorkDetailCollectionController *workDetailVC = [SWWorkDetailCollectionController workDetailColletionController];
    if (self.dataArr.count && tableView == self.tableView) {
        MissionModel *model = self.dataArr[indexPath.row];
        workDetailVC.missionID = model.missionId;
    }else if(self.resultArr.count && tableView == self.resultTableView){
        MissionModel *model = self.resultArr[indexPath.row];
        workDetailVC.missionID = model.missionId;
    }
    [self.navigationController pushViewController:workDetailVC animated:YES];
}

#pragma mark next page
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row >= self.dataArr.count * 0.9 && tableView == self.tableView) {
        NSInteger currentPage =  self.current_page.integerValue;
        NSInteger lastPage = self.last_page.integerValue;
        
        if (currentPage>lastPage) {
            currentPage = lastPage;
            self.footerView.showLabel.hidden = NO;
            self.footerView.activtyView.hidden = YES;
            
        }else{
            self.footerView.showLabel.hidden = YES;
            self.footerView.activtyView.hidden = NO;
            self.current_page = [NSString stringWithFormat:@"%ld",currentPage];
//            [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"Loading Page: %ld",currentPage]];
            [self searchByKeyWords:@"" status:@"" page:[NSString stringWithFormat:@"%ld",currentPage] isSlipTable:YES];
        }
    }

    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *indxArr = self.tableView.indexPathsForVisibleRows;
    if (!indxArr.count) {
        return;
    }
    
    NSInteger per  = self.per_page.integerValue;

    NSIndexPath *indexPath = indxArr[0];
    NSInteger pageNum = ((indexPath.row) / per)+1; // (0/15) +1 = 1;
    
    [self updatePageLabelWithCurrent:[NSString stringWithFormat:@"%ld",pageNum] last:self.last_page];
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
