//
//  SWMissionWorkDetailCollectionViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/5.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWMissionWorkDetailCollectionViewController.h"
#import "SWMissionWorkDetailCollectionCell.h"
#import "SWMissionWorkDetailCollectionReusableHeaderView.h"
#import "SWScreenHelper.h"
#import "SWUserCenterViewController.h"

@interface SWMissionWorkDetailCollectionViewController ()<SWMissionWorkDetailCollectionReusableHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) SWMissionWorkDetailCollectionReusableHeaderView *headerView;
@end

@implementation SWMissionWorkDetailCollectionViewController

static NSString * const reuseIdentifier = @"SWMissionWorkDetailCollectionCell";
static NSString * const headerID = @"SWMissionWorkDetailCollectionReusableHeaderView";


-(NSArray *)imageArr
{
    if (_imageArr==nil) {
        _imageArr = [NSArray arrayWithObjects:@"test00",@"test01",@"test02",@"test03",@"test04", nil];
    }
    return _imageArr;
}

+(instancetype)missionWorkDrtailCollectionViewController
{
    SWMissionWorkDetailCollectionViewController *missionWorkVc = [[SWMissionWorkDetailCollectionViewController alloc]initWithNibName:NSStringFromClass(self.class) bundle:nil];
    return missionWorkVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"作品詳情";
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:headerID bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    //這句價值等同于sb裡面設置Accessories
    self.flowLayout.headerReferenceSize = CGSizeMake([SWScreenHelper screenWidth], [SWScreenHelper screenHeight]/3);

    CGFloat itemWidth =(self.view.frame.size.width -5)/2;
    self.flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.minimumInteritemSpacing = 5;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.collectionView reloadData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
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
    
    SWMissionWorkDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if (kind == UICollectionElementKindSectionHeader) {
        SWMissionWorkDetailCollectionReusableHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        header.textContentLabel.text = @"aself.flowLayout.headerReferenceSize = CGSizeMake([SWScreenHelper screenWidth], [SWScreenHelper screenHeight]/3)self.flowLayout.headerReferenceSize = CGSizeMake([SWScreenHelper screenWidth], [SWScreenHelper screenHeight]/3)";
        header.delegate = self;
        
        self.flowLayout.headerReferenceSize = CGSizeMake([SWScreenHelper screenWidth], header.bottomLineView.frame.origin.y +10);
        
        return header;
    }
    return nil;
}

#pragma mark - SWMissionWorkDetailCollectionReusableHeaderViewDelegate

-(void)headerIconDidClick:(SWMissionWorkDetailCollectionReusableHeaderView *)header
{
    SWUserCenterViewController *userCenterVc = [[SWUserCenterViewController alloc]init];
    [self.navigationController pushViewController:userCenterVc animated:YES];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//    return CGSizeMake([SWScreenHelper screenWidth], [SWScreenHelper screenHeight]/2);
//}

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
