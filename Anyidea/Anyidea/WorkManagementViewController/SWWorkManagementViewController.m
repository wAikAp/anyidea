//
//  SWWorkManagementViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/22.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWWorkManagementViewController.h"
#import "SWWorkManagementCollectionViewCell.h"
#import "SWWorkManagementHeaderCollectionReusableView.h"
#import "SWScreenHelper.h"
#import "SWMissionWorkDetailCollectionViewController.h"
#import "SWWorkManagementViewHeader.h"

@interface SWWorkManagementViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *imageArr;

@end

@implementation SWWorkManagementViewController

static NSString *const workManagementCollectionViewCellID = @"SWWorkManagementCollectionViewCell";

static NSString *const headerID = @"SWWorkManagementHeaderCollectionReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"過往作品";
    self.imageArr = @[@"covermockup-1",@"kaicheukyin_portfolio_2017-04-01-1",@"kaicheukyin_portfolio_2017-04-2",@"kaicheukyin_portfolio_2017-04-3",@"page1-2-1",@"upload21",@"upload21",@"upload21",@"upload21"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftItemBtnDidClick:)];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:workManagementCollectionViewCellID bundle:nil] forCellWithReuseIdentifier:workManagementCollectionViewCellID];
    
    
    CGFloat itemWidth = [SWScreenHelper screenWidth] /2 ;
    CGFloat spacing = 0;
    self.flowLayout.itemSize = CGSizeMake(itemWidth,itemWidth);
    self.flowLayout.minimumLineSpacing = spacing;
    self.flowLayout.minimumInteritemSpacing =0;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    //header
    [self.collectionView registerNib:[UINib nibWithNibName:headerID bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    self.flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 44);
    self.flowLayout.sectionHeadersPinToVisibleBounds = YES;
    
    SWWorkManagementViewHeader *header = [SWWorkManagementViewHeader workManagementViewHeader];
    CGFloat headerHeight = 90.f;
    header.frame = CGRectMake(0, 0, self.view.frame.size.width, headerHeight);
    [self.view addSubview:header];
    self.collectionView.contentInset = UIEdgeInsetsMake(header.frame.size.height, 0, 0, 0);
}

-(void)navLeftItemBtnDidClick:(UIBarButtonItem *)barBtn{
    UIViewController *fromViewController =  [self.navigationController popViewControllerAnimated:YES];
    if (fromViewController == nil) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    SWWorkManagementCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:workManagementCollectionViewCellID forIndexPath:indexPath];
    cell.workImageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    cell.moreBtn.hidden = YES;
    if (indexPath.row == 5) {
        cell.moreBtn.hidden = NO;
    }
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionHeader) {
        SWWorkManagementHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            header.title.text = [NSString stringWithFormat:@"已上傳作品⏰ - %ld",self.imageArr.count];
            header.effectView.backgroundColor = [UIColor blueColor];
        }else if (indexPath.section == 1){
            header.title.text = [NSString stringWithFormat:@"中標作品💰 - %ld",self.imageArr.count];
        }
        
        
        return header;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWMissionWorkDetailCollectionViewController *workDetailVc  = [SWMissionWorkDetailCollectionViewController missionWorkDrtailCollectionViewController];
    [self.navigationController pushViewController:workDetailVc animated:YES];
}



@end
