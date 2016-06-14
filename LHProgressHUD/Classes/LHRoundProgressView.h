//
//  LHRoundProgressView.h
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/7.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHRoundProgressView : UIView

/**
 *  Set the currrent progress. Min 0,max
 */
@property (assign,nonatomic)CGFloat progress;
/**
 *  Color of progress foreground color
 */
@property (strong,nonatomic)UIColor * progressColor;
/**
 *  Color of progress background color
 */
@property (strong,nonatomic)UIColor * progressBackgroundColor;

/**
 *  Progress label
 */
@property (strong,nonatomic,readonly)UILabel * progressLabel;

@end
