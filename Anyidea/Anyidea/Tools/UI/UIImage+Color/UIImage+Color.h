//
//  UIImage+color.h
//  nightChat
//
//  Created by 王俨 on 15/9/5.
//  Copyright (c) 2015年 nightGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
//create a image  use color
+ (UIImage *)imageWithColor:(UIColor *)color;
/// Return a stretchy image
+ (instancetype)resizeImageNamed:(NSString *)name;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size isRound:(BOOL)isRound;

@end
