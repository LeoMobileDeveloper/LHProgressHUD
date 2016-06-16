//
//  LHSpinner.h
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/5.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHAcvitityIndicator : UIView

/**
 *  Padding between circle and edges
 */
@property (nonatomic,assign)CGFloat padding;

/**
 *  Color of "circle"
 */
@property (strong,nonatomic)UIColor * spinnerColor;

/**
 *  Color if center success/fail/info
 */
@property (strong,nonatomic)UIColor * infoColor;

/**
 *  Start animating
 */
-(void)startAnimating;

/**
 *  Stop animating
 */
-(void)stopAnimate;

/**
 *  Update to success state
 *
 *  @param animated animate or not
 */
-(void)updateToSuccess:(BOOL)animated;

/**
 *  Update to fail state
 *
 *  @param animated animate or not
 */
-(void)updateToFail:(BOOL)animated;

/**
 *  Update to info state
 *
 *  @param animated animate or not
 */
-(void)updateToInfo:(BOOL)animated;

@end
