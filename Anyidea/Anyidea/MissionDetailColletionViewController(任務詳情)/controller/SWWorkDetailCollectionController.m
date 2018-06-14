//
//  SWWorkDetailCollectionController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/27.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWWorkDetailCollectionController.h"
#import "SWNowPostWorksCollectionViewCell.h"
#import "SWWorkDetailHeaderView.h"
#import "SWScreenHelper.h"
#import "SWLikeView.h"
#import "SWMissionWorkDetailCollectionViewController.h"
#import "SWUserCenterViewController.h"



#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SWWorkDetailCollectionController ()<UICollectionViewDelegateFlowLayout,SWNowPostWorksCollectionViewCellDelegate,SWWorkDetailHeaderViewDelegate>

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIButton *joinBtn;
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
    
}

-(void)setUpUI{
    self.imageArr = [NSArray arrayWithObjects:@"test00",@"test01",@"test02",@"test03",@"test04",@"test05",@"test06",@"test07",@"test08", nil];
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
    if ([[SWScreenHelper iphoneScreenType] isEqualToString:IPHONESE_SIZE_SCREEN]) {
        itemHight = 200;
        joinBtnWH = 50;
        joinBtnFont = 12.f;
    }
    
    self.flowLayout.itemSize = CGSizeMake(itemWidth, itemHight);
    self.flowLayout.minimumInteritemSpacing = 5 ;
    self.flowLayout.minimumLineSpacing = 5;
    
    
    //also can use Collection Reusable View , but here user view
    SWWorkDetailHeaderView *header = [[UINib nibWithNibName:@"SWWorkDetailHeaderView" bundle:nil] instantiateWithOwner:nil options:nil][0];
    header.delegate = self;
    [self.collectionView addSubview:header];
    
    //Test
    if (!self.testMissionRequs && !self.testBackGroundInfo) {
        
        header.missionBackgroundDetailLabel.text =
        @"公司英文名稱: AvenuePro Real Estate\n公司業務：澳洲地產代理\n公司背景：Start-up 地產代理公司，目標是運用非傳統方法結合科技把代理人佣金降低，做到買家和賣家的利益最大化，代理人獲得更多盤源， 達到三贏。公司由一班年青的後生仔組成\n設計要求：創新，簡潔，大眾化為主\n可用text logo (“AvenuePro”/”AP”. Note: 沒有中文名稱), 創作icon logo, 或兩者混合請自由發揮";
        header.missionRequirementsLabel.text = @"1. logo 必須100%原創 （因本公司logo要作註冊之用,請不要作出侵權行為).我們會對作品進行一定程度審查\n2. 較喜歡綠色但設計師也可以隨意發揮\n3.  Logo 主要用於NAME CARD, WEBSITE, INVOICE， SIGNAGE etc\n4. 成品需提交AI, PSD及JPG檔案 和 color code (vector & source file)\n5. 成品需提交Transparent logo version, 高解像度logo, 彩色及黑白版本\n6. 請列明可否及後進行微調";
    }else{
        header.missionBackgroundDetailLabel.text = self.testBackGroundInfo;
        header.missionRequirementsLabel.text = self.testMissionRequs;
    }
    
    
    //Change Lable Constant label自適應height
    CGSize bgLabelSize = [header.missionBackgroundDetailLabel sizeThatFits:CGSizeMake(header.missionBackgroundDetailLabel.frame.size.width, 0)];
    CGSize requslabelSize =  [header.missionRequirementsLabel sizeThatFits:CGSizeMake(header.missionRequirementsLabel.frame.size.width, 0)];
    
    header.missionBackgroundDetailLabelConstraintHeight.constant = bgLabelSize.height;
    header.missionRequirementsLabelConstraintHeight.constant = requslabelSize.height;
   
    [header layoutIfNeeded];
    header.workNumberLabel.text = [NSString stringWithFormat:@" - %ld",self.imageArr.count];
    CGFloat headerHeight = CGRectGetMaxY(header.bottomLabel.frame);
    header.frame = CGRectMake(0,0, self.view.frame.size.width,headerHeight);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(header.frame.size.height + 10, 0, 0, 0 );
    
    
    
    //join btn
    UIButton *joinBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - joinBtnWH - 20 , 25, joinBtnWH, joinBtnWH)];
    [joinBtn setTitle:@" 投稿\n🙋🏻‍♂️🙋🏻" forState:UIControlStateNormal];
    joinBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    joinBtn.titleLabel.numberOfLines = 0;
    joinBtn.titleLabel.font = [UIFont boldSystemFontOfSize:joinBtnFont];
    [joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    joinBtn.backgroundColor = [UIColor colorWithRed:(237)/255.0 green:(15)/255.0 blue:(24)/255.0 alpha:1.0];
    joinBtn.layer.cornerRadius = joinBtnWH/2;
    [joinBtn.layer masksToBounds];
    
    joinBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    joinBtn.layer.borderWidth = 2.0f;
    
    self.joinBtn = joinBtn;
    [self.navigationController.navigationBar addSubview:joinBtn];
    
    
    UIImageView *background =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SigninBackGround"]];
    background.frame = self.view.frame;
    
    self.collectionView.backgroundView = background;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.joinBtn removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.joinBtn];
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

    return self.imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SWNowPostWorksCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:nowPostWorksCollectionViewCellID forIndexPath:indexPath];
    
    cell.jobImageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController: [SWMissionWorkDetailCollectionViewController missionWorkDrtailCollectionViewController] animated:YES];
}

#pragma mark - SWNowPostWorksCollectionViewCellDelegate
-(void)nowPostWorksLikeBtnDidClick:(SWNowPostWorksCollectionViewCell *)cell btn:(UIButton *)btn{
    [SWLikeView likeViewShow];
}


#pragma mark - SWWorkDetailHeaderViewDelegate
-(void)headerViewTopViewDidClick:(UIView *)header
{
    SWUserCenterViewController *userCenterVc = [[SWUserCenterViewController alloc]init];
    userCenterVc.title = @"發佈人資料";
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
