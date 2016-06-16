//
//  LHProgressHUD.h
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/6.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHBackgroundView.h"
#import "LHGifImageView.h"

typedef NS_ENUM(NSInteger,LHProgressHUDMode){
    LHProgressHUDModeNormal,
    LHProgressHUDModeActivityIdenticator,
    LHProgressHUDModeCustomView,
    LHProgressHUDModeTextOnly,
    LHProgressHUDModeProgress,
    LHPRogressHUDModeGif,
    
};

typedef NS_ENUM(NSInteger,LHPRogressHUDSubMode){
    LHProgressHUDSubModeAnimating,
    LHProgressHUDSubModeSuccess,
    LHProgressHUDSubModeInfo,
    LHProgressHUDSubModeFailure,
};

@interface LHProgressHUD : UIView

//Normal state
+(instancetype)showAddedToView:(UIView *)view;

+(instancetype)showInfoAddedToView:(UIView *)view;

+(instancetype)showFailureAddedToView:(UIView *)view;

+(instancetype)showSuccessAddedToView:(UIView *)view;

-(void)resetWithStatus:(NSString *)status;

-(void)showInfoWithStatus:(NSString *)status animated:(BOOL)animated;

-(void)showSuccessWithStatus:(NSString *)status animated:(BOOL)animated;

-(void)showFailureWithStatus:(NSString *)status animated:(BOOL)animated;

-(void)hide;

-(void)hideAfterDelay:(CGFloat)delay;

-(void)hideAfterDelay:(CGFloat)delay hiddenBlock:(void(^)(void))hiddenBlock;

/**
 *  The outside round circle color of spinner
 */
@property (strong,nonatomic)UIColor * spinnerColor;

/**
 *  The color of inside success/failure/info color
 */
@property (strong,nonatomic)UIColor * infoColor;

@property (assign,nonatomic)LHProgressHUDMode mode;

@property (assign,nonatomic)LHPRogressHUDSubMode subMode;

@property (strong,nonatomic)LHBackgroundView * backgroundView;

@property (strong,nonatomic)LHBackgroundView * centerBackgroundView;

@property (strong,nonatomic)UILabel * textLabel;

@property (strong,nonatomic)UIView * customView;

@property (assign,nonatomic)CGFloat progress;

@property (assign,nonatomic)BOOL animateWhenSubModeChange;

@property (copy,nonatomic)void(^didHiddenBlock)(void);

@property (assign,nonatomic)CGFloat yOffset;

@property (assign,nonatomic)CGFloat xOffset;

@property (assign,nonatomic)BOOL persistSizeWhenSubModeChange;

//Gif related
@property (strong,nonatomic)LHGifImageView * gifImageView;


@end
