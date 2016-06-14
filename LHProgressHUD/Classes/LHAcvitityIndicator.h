//
//  LHSpinner.h
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/5.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHAcvitityIndicator : UIView

@property (nonatomic,assign)CGFloat padding;

@property (strong,nonatomic)UIColor * spinnerColor;

@property (strong,nonatomic)UIColor * infoColor;


/**
 *  Start animating
 */
-(void)startAnimating;

/**
 *  Stop animating
 */
-(void)stopAnimate;


-(void)updateToSuccess:(BOOL)animated;

-(void)updateToFail:(BOOL)animated;

-(void)updateToInfo:(BOOL)animated;

@end
