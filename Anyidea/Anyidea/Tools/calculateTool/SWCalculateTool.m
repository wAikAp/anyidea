//
//  SWCalculateTool.m
//  Anyidea
//
//  Created by shingwai chan on 17/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "SWCalculateTool.h"

@implementation SWCalculateTool

+ (NSDateComponents *)calculatTimeDiffFromCurrentToEndTime:(NSString *)time2{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.000000";
    //    NSDate *date1 = [formatter :time1];
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [formatter dateFromString:time2];
 
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    
    //    NSLog(@"相差%ld年%ld月%ld日%ld小時%ld分%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    return cmps;
}
+ (NSString *)calculatTimeDiffFromCurrentToEndTimeReturnTime:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.000000";
    
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [formatter dateFromString:time];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    
    NSString *timeStr;
//    NSString *time;
    if (cmps.year!=0) {
        timeStr = @"年";
        time =[NSString stringWithFormat:@"%ld",cmps.year];
    }else if (cmps.month != 0){
        timeStr = @"月";
        time =[NSString stringWithFormat:@"%ld",cmps.month];
    }else if (cmps.day != 0){
        timeStr = @"日";
        time =[NSString stringWithFormat:@"%ld",cmps.day];
    }else if (cmps.hour != 0){
        timeStr = @"小時";
        time =[NSString stringWithFormat:@"%ld",cmps.hour];
    }else if (cmps.minute != 0){
        timeStr = @"分鐘";
        time =[NSString stringWithFormat:@"%ld",cmps.minute];
    }else if (cmps.second != 0){
        timeStr = @"秒";
        time =[NSString stringWithFormat:@"%ld",cmps.second];
    }
    //將-2日轉成2日
    NSInteger timeABS = time.integerValue;
    if (timeABS < 0) {
        timeABS *= -1;
    }
    return [NSString stringWithFormat:@"%ld%@",timeABS,timeStr];
}

+ (NSInteger)calculatCurrentTimeAndEndTime:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.000000";
    
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [formatter dateFromString:time];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    
    if (cmps.year!=0) {
        return cmps.year;

    }else if (cmps.day != 0){
        return cmps.day;
    }else if (cmps.hour != 0){
        return cmps.hour;
    }else if (cmps.minute != 0){
        return cmps.minute;
    }else if (cmps.second != 0){
        return cmps.second;
    }

    return 0;
}

+(NSString *)formatDateTo_yyyy_MM_dd_HH_mm_ss:(NSString *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.000000";
    NSDate *newFormDate = [formatter dateFromString:date];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [formatter stringFromDate:newFormDate];
    return dateStr;
    
}

+ (NSTimeInterval)calculatTimeDiff2:(NSString *)starTime andInsertEndTime:(NSString *)endTime{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss.000000"];
    NSDate* startDate = [formater dateFromString:starTime];
    NSDate* endDate = [formater dateFromString:endTime];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    NSLog(@"time = %f",time);
    return time;
}



+ (NSString *)stringFilterHTMLTag:(NSString *)htmlStr{
    NSString *normalStr = htmlStr.copy;
    
    if (!normalStr || normalStr.length == 0 || [normalStr isEqual:[NSNull null]]) return nil;
    
    //filter tag
    NSRegularExpression *regularExpression=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>" options:NSRegularExpressionCaseInsensitive error:nil];
    normalStr = [regularExpression stringByReplacingMatchesInString:normalStr options:NSMatchingReportProgress range:NSMakeRange(0, normalStr.length) withTemplate:@""];
    
    //filter placeholder
    NSRegularExpression *plExpression=[NSRegularExpression regularExpressionWithPattern:@"&[^;]+;" options:NSRegularExpressionCaseInsensitive error:nil];
    normalStr = [plExpression stringByReplacingMatchesInString:normalStr options:NSMatchingReportProgress range:NSMakeRange(0, normalStr.length) withTemplate:@""];
    
    //filter speac
    NSRegularExpression *spaceExpression=[NSRegularExpression regularExpressionWithPattern:@"^\\s*|\\s*$" options:NSRegularExpressionCaseInsensitive error:nil];
    normalStr = [spaceExpression stringByReplacingMatchesInString:normalStr options:NSMatchingReportProgress range:NSMakeRange(0, normalStr.length) withTemplate:@""];
    
    return normalStr;
}

//only filter tag <>
+(NSString *)stringFilterHTMLTag2:(NSString *)htmStr{
    
    NSArray *components = [htmStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    
    for (int i = 0; i < [components count]; i = i + 2) {
        
        [componentsToKeep addObject:[components objectAtIndex:i]];
        
    }
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    
    return plainText;
}

@end
