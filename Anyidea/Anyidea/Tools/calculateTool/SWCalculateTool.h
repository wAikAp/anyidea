//
//  SWCalculateTool.h
//  Anyidea
//
//  Created by shingwai chan on 17/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWCalculateTool : NSObject

/*計算時間差
 *
 *返回NSDateComponents
 */
+ (NSDateComponents *)calculatTimeDiffFromCurrentToEndTime:(NSString *)time2;
/*
 *  計算過去和現在的時間差
 *  返回string 1日 or 1分鐘 etc
 *  eg 5日前
 */
+ (NSString *)calculatTimeDiffFromCurrentToEndTimeReturnTime:(NSString *)time;

/*
 *  計算現在和某個時間的時間差
 *  return int 負數代表過去式
 */
+ (NSInteger)calculatCurrentTimeAndEndTime:(NSString *)time;

+(NSString *)formatDateTo_yyyy_MM_dd_HH_mm_ss:(NSString *)date;



+(NSString *)stringFilterHTMLTag:(NSString *)htmStr;
@end

NS_ASSUME_NONNULL_END
