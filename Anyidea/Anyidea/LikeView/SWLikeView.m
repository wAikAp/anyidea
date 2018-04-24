//
//  SWLikeView.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/3.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWLikeView.h"
#import "Masonry.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation SWLikeView

+(instancetype)likeViewShow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat width = 60;
    SWLikeView *backGround = [[SWLikeView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
    backGround.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Like"]];
    [backGround addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.mas_equalTo(backGround);
    }];
    backGround.center = window.center;

    [window addSubview:backGround];
    [backGround praiseStyle1AnimateWithView:backGround];
    return backGround;
}

-(void)praiseStyle0AnimateWithView:(UIView *)view{
    CGFloat animationTime = 0.5f;
    view.alpha = 0.2;
    [UIView animateWithDuration:animationTime*3 animations:^{
        view.alpha = 1;
        //        backGround.center = window.center;
    }completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:animationTime*2 animations:^{
        //            backGround.center = CGPointMake(window.center.x, 0);
        view.alpha = 0;
    }completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

-(void)praiseStyle1AnimateWithView:(UIView *)view
{
    
    CGFloat duration = 0.25f;
    [UIView animateWithDuration:0.15 animations:^{
        view.transform = CGAffineTransformMakeScale(1.6, 1.6); //放大
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            view.transform = CGAffineTransformMakeScale(0.6, 0.6); //缩小
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration animations:^{
                view.transform = CGAffineTransformMakeScale(1.0, 1.0); //正常
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration*2 animations:^{
                    view.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    [view removeFromSuperview];
                }];
            }];
        }];
    }];
}

-(void)praiseStyle2AnimateWithView:(UIView *)view{
    
    
    /*
     
     参数1:动画持续时间
     
     参数2:多久后开始动画
     
     参数3:动画类型
     
     */
    
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
        /*
         
         参数1:关键帧开始时间
         
         参数2:关键帧占用时间比例
         
         参数3:到达该关键帧时的属性值
         
         */
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/2.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(1.6, 1.6);
            
        }];
        
        //        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations:^{
        
        //            self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        //        }];
        
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
            
            self.transform = CGAffineTransformIdentity;
            
        }];
        
    } completion:nil];
    
    
    
}



@end
