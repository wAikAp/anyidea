//
//  SearchFooterView.h
//  Anyidea
//
//  Created by shingwai chan on 28/4/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchFooterView : UIView
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activtyView;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

+(instancetype)searchFooterView;

@end

NS_ASSUME_NONNULL_END
