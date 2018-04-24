//
//  SWScreenHelper.h
//  Anyidea
//
//  Created by shingwai chan on 2018/2/3.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IPHONESE_SIZE_SCREEN @"IPHONESE_SIZE_SCREEN"
#define IPHONE6_SIZE_SCREEN @"IPHONE6_SIZE_SCREEN"
#define IPHONEPLUSE_SIZE_SCREEN @"IPHONEPLUSE_SIZE_SCREEN"

@interface SWScreenHelper : NSObject
+(CGFloat)screenWidth;
+(CGFloat)screenHeight;
+(CGSize)fixCollectionItemSize;
+(CGFloat)fixTableViewHeight;
+(CGFloat)collectionViewItemHeight;
+(NSString *)iphoneScreenType;
@end
