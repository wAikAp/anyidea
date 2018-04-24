//
//  SWWorkDetailCollectionController.h
//  Anyidea
//
//  Created by shingwai chan on 2018/1/27.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWWorkDetailCollectionController : UICollectionViewController

+(instancetype)workDetailColletionController;

@property (nonatomic, strong) NSString *testBackGroundInfo;
@property (nonatomic, strong) NSString *testMissionRequs;

@property (nonatomic, strong) NSArray *imageArr;


@end
