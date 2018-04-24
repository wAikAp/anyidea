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


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MainTableViewPortfolioCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;


@end


@implementation MainTableViewPortfolioCell


//collecionView Cell ID  = SWPortfolioCollectionViewCell
static NSString * const collectionCellID = @"SWPortfolioCollectionViewCell";
static CGFloat const itemSpacing = 0.25f;

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
    self.flowLayout.minimumLineSpacing = itemSpacing * 2;
    self.flowLayout.minimumInteritemSpacing = itemSpacing;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0 );
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWPortfolioCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    return cell;
}


@end
