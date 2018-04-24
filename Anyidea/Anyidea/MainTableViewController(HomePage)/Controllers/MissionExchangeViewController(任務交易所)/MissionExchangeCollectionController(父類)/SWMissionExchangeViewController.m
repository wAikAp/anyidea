//
//  SWMissionExchangeViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2017/12/18.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//


#define WINDOW_WIDTH [UIScreen mainScreen].bounds.size.width
#define WINDOW_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "SWMissionExchangeViewController.h"
#import "UIViewController+MMDrawerController.h"

#import "SWMissionCollectionViewCell.h"
#import "SWNewMissionTableViewController.h"
#import "SWHotMissionTableViewController.h"
#import "SWVotingMissionTableViewController.h"


@interface SWMissionExchangeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,SWNewMissionTableViewControllerDelegate,SWHotMissionTableViewControllerDelegate,SWVotingMissionTableViewControllerDelegate>
//top MenuView 頭部選擇菜單
@property (weak, nonatomic) IBOutlet UIView *topMenuView;
@property (weak, nonatomic) IBOutlet UIView *topMenuBottomView;
@property (weak, nonatomic) IBOutlet UIButton *NewMissionBtn;
@property (weak, nonatomic) IBOutlet UIButton *hotMissionBtn;
@property (weak, nonatomic) IBOutlet UIButton *votingMissionBtn;
//top MenuView 頭部選擇菜單

//CollectionView
@property (nonatomic ,weak)UICollectionView *childCollectionView;
@property (nonatomic ,weak)UICollectionViewFlowLayout *flowLayout;


@property (nonatomic,assign)CGFloat stautsBarHeight;
@property (nonatomic ,assign)CGFloat oldOffSetY;

//current ViewController Index
@property (nonatomic, assign) NSInteger currentIndex;

@end


@implementation SWMissionExchangeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUi];
    [self toolBarBtnDidClick:self.NewMissionBtn];
}

//Set Up UI
-(void)setUpUi{
    
    self.view.backgroundColor =[UIColor colorWithRed:(65)/255.0 green:(65)/255.0 blue:(65)/255.0 alpha:1.0];
    self.topMenuView.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(15)/255.0 blue:(24)/255.0 alpha:1.0];
    [self setUpStatusBar];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    } else {
        // Fallback on earlier versions
    }
    [self setUpChildsCollectionView];
}

//statusBar
- (void)setUpStatusBar {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    self.stautsBarHeight = statusBar.frame.size.height;
    //tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(statusBarDidTap)];
    [statusBar addGestureRecognizer:tap];
}
//tap function scroll to top
-(void)statusBarDidTap
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
    SWMissionCollectionViewCell *cell = (SWMissionCollectionViewCell *)[self.childCollectionView cellForItemAtIndexPath:indexPath];
    SWNewMissionTableViewController *NewMissionVc;
    SWHotMissionTableViewController *hotMissionVc;
    SWVotingMissionTableViewController *votingVc;
    NSIndexPath *tableIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    switch (self.currentIndex) {
        case 0:
            NewMissionVc = cell.NewMissionVc ;
            [NewMissionVc selectCellWithIndexPath:tableIndexPath];
            break;
        case 1:
            hotMissionVc = cell.HotMissionVc;
            [hotMissionVc selectCellWithIndexPath:tableIndexPath];
            break;
        case 2:
            votingVc = cell.VotingMissionVc;
            [votingVc selectCellWithIndexPath:tableIndexPath];
            break;
            
        default:
            break;
    }
   
}
- (IBAction)navBtnClick:(UIBarButtonItem *)sender {
    if (sender.tag == 0) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:true completion:^(BOOL finished) {
        }];
    }else
    {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:true completion:^(BOOL finished) {
        }];
    }
}

static NSString * const missionCellID= @"SWMissionCollectionViewCell";
#pragma mark - collectionView
-(void)setUpChildsCollectionView
{
 
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat tablBarHeight = self.tabBarController.tabBar.frame.size.height;
    //statusBar + navbar + toolbar + tabbar
    CGFloat collectionViewHeight = self.view.bounds.size.height - self.stautsBarHeight - navBarHeight;
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout = flowLayout;
    
    CGFloat topMenuViewY = CGRectGetMaxY(self.topMenuView.frame);
    UICollectionView *childCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topMenuViewY, self.view.bounds.size.width, collectionViewHeight - self.tabBarController.tabBar.frame.size.height + 10) collectionViewLayout:flowLayout];
    
    self.childCollectionView = childCollectionView;
    self.childCollectionView.scrollsToTop = NO;
    //delegate , datasource
    childCollectionView.delegate = self;
    childCollectionView.dataSource = self;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = childCollectionView.bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    childCollectionView.backgroundColor = [UIColor whiteColor];
    childCollectionView.bounces = NO;
    childCollectionView.pagingEnabled =YES;
    childCollectionView.showsVerticalScrollIndicator = NO;
    childCollectionView.showsHorizontalScrollIndicator = NO;
    [childCollectionView registerClass:[SWMissionCollectionViewCell class] forCellWithReuseIdentifier:missionCellID];
    [self.view addSubview:childCollectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

/*
 * This foution is set up the Childs TableViewController
 * 0 = New missions TableViewController
 * 1 = Hot mission TableViewController
 * 2 = Voting Mission TableViewController
 * 這裡是利用CollectionView cell 加載tableviewControlle的View
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWMissionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:missionCellID forIndexPath:indexPath];
    
    //New missions Table
    if (indexPath.row == 0) {
        
        SWNewMissionTableViewController *newMissionVC = [storyBoard instantiateViewControllerWithIdentifier:@"SWNewMissionTableViewController"];
        newMissionVC.delegate = self;
        newMissionVC.mainNavVc = self.navigationController;
        
        if (cell.NewMissionVc == nil) {//cell重用問題，當cell已經有子view的時候就不再重新加載。
            
            cell.NewMissionVc = newMissionVC;
        }
        
    }
    
    //hot mission table
    if (indexPath.row == 1) {
        SWHotMissionTableViewController *hotMissionVC = [storyBoard instantiateViewControllerWithIdentifier:@"SWHotMissionTableViewController"];
        hotMissionVC.delegate = self;
        hotMissionVC.mainNavVc = self.navigationController;
        if (cell.HotMissionVc == nil) {
            cell.HotMissionVc = hotMissionVC;
        }
    }
    //VotingMissionViewController
    if (indexPath.row == 2) {
        SWVotingMissionTableViewController *votingMissionVc = [storyBoard instantiateViewControllerWithIdentifier:@"SWVotingMissionTableViewController"];
        votingMissionVc.delegate = self;
        votingMissionVc.mainNavVc = self.navigationController;
        if (cell.VotingMissionVc == nil) {//
            cell.VotingMissionVc = votingMissionVc;
        }
    }
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f];
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    NSInteger row = 0 ;
    NSIndexPath *indexPath1;
    for (NSIndexPath *indexPath in self.childCollectionView.indexPathsForVisibleItems) {
        row = indexPath.row;
        indexPath1 = indexPath;
    }
    NSInteger multiple = 100;
    NSInteger pageCount = 3;
    NSInteger pageNumber = scrollView.contentOffset.x / pageCount /multiple;
//    NSLog(@"oldx = %f ,newx = %ld",scrollView.contentOffset.x,pageNumber);
    
    switch (pageNumber) {
        case 0:
            
            [self topMenuBottomLineFrameChangeToBtn:self.NewMissionBtn];
            break;
        case 1:

            [self topMenuBottomLineFrameChangeToBtn:self.hotMissionBtn];
            break;
        case 2:

            [self topMenuBottomLineFrameChangeToBtn:self.votingMissionBtn];
            break;
        default:
            break;
    }
}


///topMenuView btn did click
- (IBAction)toolBarBtnDidClick:(UIButton *)sender {

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    self.currentIndex = sender.tag;
    self.navigationItem.title = sender.titleLabel.text;
    [self.childCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
    [self topMenuBottomLineFrameChangeToBtn:sender];
}


-(void)topMenuBottomLineFrameChangeToBtn:(UIButton *)btn {
    static CGFloat topMenuBottomViewHeight = 5;
    [UIView animateWithDuration:0.2 animations:^{
        self.topMenuBottomView.frame = CGRectMake(btn.frame.origin.x, 0, btn.frame.size.width, topMenuBottomViewHeight);
    }];
    self.navigationItem.title = btn.titleLabel.text;
}


#pragma mark - SWNewMissionTableViewControllerDelegate
-(void)missionTableViewControllerDidScroll:(SWNewMissionTableViewController *)newMissionVC andScrollView:(UIScrollView *)scrollView
{
//    [self hiddenToolBarAndChangeNavBar:scrollView];
}
#pragma mark - SWHotMissionTableViewControllerDelegate
-(void)hotMissionTableViewControllerDidScore:(SWHotMissionTableViewController *)hotMissionVc andScrollView:(UIScrollView *)scrollView
{
//    [self hiddenToolBarAndChangeNavBar:scrollView];
}
#pragma mark - SWVotingMissionTableViewControllerDelegate
-(void)votingMissionTableViewVcDidScroll:(SWVotingMissionTableViewController *)votingVc andScrollView:(UIScrollView *)scrollView{
//    [self hiddenToolBarAndChangeNavBar:scrollView];
}

//-(void)hiddenToolBarAndChangeNavBar:(UIScrollView *)scrollView {
//    BOOL isHidden;
//    if (scrollView.contentOffset.y > self.oldOffSetY) {
//        //向下拉
//        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
//        isHidden = YES;
//    }else
//    {
//        //向上拉
//        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
//        isHidden = NO;
//    }
//
////    self.tabBarController.tabBar.hidden = isHidden;
//}

@end
