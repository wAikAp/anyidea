//
//  SWScreenHelper.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/3.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWScreenHelper.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation SWScreenHelper

+(CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}
+(CGFloat)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

+(CGSize)fixCollectionItemSize
{
    return CGSizeMake(180, 240);
}
+(CGFloat)fixTableViewHeight
{
    if ([[SWScreenHelper iphoneScreenType] isEqualToString:IPHONESE_SIZE_SCREEN]) {
        return 195;
    }
    return 220;
}

/* 根據屏幕高度/2 或者3 的不固定高度
 * CollectionView one Item Height
 */
+(CGFloat)collectionViewItemHeight
{
    CGFloat itemHeight;
    CGFloat navHeight = 44;//navbar height
    //if iphone se height 568
    if (SCREEN_HEIGHT < 667) {// iphone se
        itemHeight = SCREEN_HEIGHT * 1/2 - navHeight;
    }else if (SCREEN_HEIGHT == 667){//iphone 6 height = 667
        itemHeight = SCREEN_HEIGHT/3 + 15;
    }else{//iphone 6plus 667+
        itemHeight = SCREEN_HEIGHT/3;
    }
    return itemHeight;
}

+(NSString *)iphoneScreenType{
    if (SCREEN_HEIGHT < 667) {// iphone se
        return IPHONESE_SIZE_SCREEN;
    }else if (SCREEN_HEIGHT == 667){//iphone 6 height = 667
        return IPHONE6_SIZE_SCREEN;
    }else{//iphone 6plus over 667+ eg:iphoneX
        return IPHONEPLUSE_SIZE_SCREEN;
    }
}

@end
