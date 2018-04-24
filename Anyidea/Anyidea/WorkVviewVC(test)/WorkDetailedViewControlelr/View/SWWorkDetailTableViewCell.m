//
//  SWWorkDetailTableViewCell.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/22.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWWorkDetailTableViewCell.h"
#import "SWNowPostWorksCollectionViewCell.h"
#import "Masonry.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SWWorkDetailTableViewCell() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UILabel *missionBackgroundDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *missionRequirementsLabel;


@end

@implementation SWWorkDetailTableViewCell


static NSString *postCollectionCellID = @"SWNowPostWorksCollectionViewCell";



- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.CollectionView.delegate = self;
    self.CollectionView.dataSource = self;
    self.flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH /2, SCREEN_HEIGHT / 3);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0 );
    
    self.missionBackgroundDetailLabel.text = @"1.xxxxxxx \n2.xxxxxxxxx \n3.xxxxxxxx \n4.xxxxxxxx \n5.xxxxxxxx \n5.xxxxxxxx \n5.xxxxxxxx \n5.xxxxxxxx \n5.xxxxxxxx";
    self.missionRequirementsLabel.text  = @"1.xxxxxxx \n2.xxxxxxxxx \n3.xxxxxxxx \n4.xxxxxxxx \n5.xxxxxxxx \n5.xxxxxxxx \n5.xxxxxxxx ";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

#pragma mark - collectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:postCollectionCellID bundle:nil] forCellWithReuseIdentifier:postCollectionCellID];
    SWNowPostWorksCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:postCollectionCellID forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"click");
}

#pragma setter
-(void)setImageArr:(NSArray *)imageArr
{
    _imageArr = imageArr;
}


@end
