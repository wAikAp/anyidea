//
//  MainTableViewPortfolioCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/12.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "MainTableViewPortfolioCell.h"
#import "SWPortfolioCollectionViewCell.h"
#import "SWScreenHelper.h"
#import "SVProgressHUD.h"

#import "ANnetworkManage.h"
#import "MissionWorkModel.h"
#import "UIImageView+WebCache.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MainTableViewPortfolioCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *workListModelArr;
@property (nonatomic, strong) NSArray *loadingArr;
@end


@implementation MainTableViewPortfolioCell


//collecionView Cell ID  = SWPortfolioCollectionViewCell
static NSString * const collectionCellID = @"SWPortfolioCollectionViewCell";
static CGFloat const itemSpacing = 0.25f;
-(NSArray *)loadingArr{
    if (!_loadingArr) {
        _loadingArr = @[@"1",@"2",@"3"];
    }
    return _loadingArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:collectionCellID bundle:nil] forCellWithReuseIdentifier:collectionCellID];
    self.collectionView.scrollsToTop = NO;

//    CGFloat collectionCellItemHeight = [SWScreenHelper collectionViewItemHeight];
//    self.flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 2 - itemSpacing*2, collectionCellItemHeight);
    CGSize itemSize = [SWScreenHelper fixCollectionItemSize];
    self.flowLayout.itemSize = itemSize; //CGSizeMake(180,240);
//    self.flowLayout.minimumLineSpacing = itemSpacing * 2;
//    self.flowLayout.minimumInteritemSpacing = itemSpacing;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;

    self.collectionView.pagingEnabled = NO;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0 );
    [self mapdata];
    
}

-(void)mapdata{
    
    [[ANnetworkManage shareNetWorkManage] getMissionWorkListWithMissionID:@"" andPage:@"" success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {

        NSArray *responseArr =responseObject;
        NSMutableArray *workListArr = [NSMutableArray array];
        for (int i = 0; i < responseArr.count; ++i) {
            MissionWorkModel *model = [[MissionWorkModel alloc]initWithJsonToModel:responseArr[i]];
            [workListArr addObject:model];
        }
        self.workListModelArr = workListArr;
        
            
        [self.collectionView reloadData];
    } Error:^(NSError * _Nonnull errorBack) {
        NSLog(@"MainTableViewPortfolioCell 獲取任務詳情服務器或字段error %@",errorBack);
        [SVProgressHUD showErrorWithStatus:@"Network error，請稍後重試"];
        [SVProgressHUD dismissWithDelay:2.f];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.workListModelArr.count) {
        return self.loadingArr.count;
    }else{
        return self.workListModelArr.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.workListModelArr.count>0) {
        
        SWPortfolioCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
        MissionWorkModel *workModel =self.workListModelArr[indexPath.row];
        [cell.jobImageView sd_setImageWithURL:[NSURL URLWithString:workModel.thumbnail] placeholderImage: [UIImage imageNamed:@"placeholder"]];
        cell.jobTitle.text = workModel.work_title;
        cell.is_protected = workModel.is_protected;
        cell.idLabel.text = workModel.work_id;
        return cell;
    }else{
         SWPortfolioCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.workListModelArr.count) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"porftolioCellCallBack" object:self.workListModelArr[indexPath.row]];
    }
}

#pragma mark - UIScrollViewDelegate


//
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];

    targetContentOffset->x = targetOffset.x - 15;
    targetContentOffset->y = targetOffset.y;


}
//
- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset
{
    CGFloat itemWidth = [SWScreenHelper fixCollectionItemSize].width;
    CGFloat pageSize = itemSpacing + itemWidth;
    //四舍五入
    NSInteger page = roundf(offset.x / pageSize);
    CGFloat targetX = pageSize * page;
    return CGPointMake(targetX, offset.y);
}


@end
