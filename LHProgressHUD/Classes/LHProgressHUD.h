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
    LHPRogressHUDModeGif,
    
};

typedef NS_ENUM(NSInteger,LHPRogressHUDSubMode){
    LHProgressHUDSubModeAnimating,
    LHProgressHUDSubModeSuccess,
    LHProgressHUDSubModeInfo,
    LHProgressHUDSubModeFailure,
};

@interface LHProgressHUD : UIView

/**
 *  Show LHAcvitityIndicator with submode LHProgressHUDSubModeAnimating and add it as a subview of target view
 *
 *  @param view target view
 *
 */
+(instancetype)showAddedToView:(UIView *)view;

/**
 *   Show LHAcvitityIndicator with submode LHProgressHUDSubModeInfo and add it as a subview of target view
 *
 *  @param view     Target view
 *  @param animated wheather use draw animation
 *
 */
+(instancetype)showInfoAddedToView:(UIView *)view animated:(BOOL)animated;;

/**
 *   Show LHAcvitityIndicator with submode LHProgressHUDSubModeFailure and add it as a subview of target view
 *
 *  @param view     Target view
 *  @param animated wheather use draw animation
 *
 */
+(instancetype)showFailureAddedToView:(UIView *)view animated:(BOOL)animated;;

/**
 *   Show LHAcvitityIndicator with submode LHProgressHUDSubModeSuccess and add it as a subview of target view
 *
 *  @param view     Target view
 *  @param animated wheather use draw animation
 *
 */
+(instancetype)showSuccessAddedToView:(UIView *)view animated:(BOOL)animated;;

/**
 *  Reset the submode to LHProgressHUDSubModeAnimating
 *
 *  @param status Text to show
 */
-(void)resetWithStatus:(NSString *)status;

/**
 *  Set the subm mode to LHProgressHUDSubModeInfo
 *
 *  @param status   Text to sow
 *  @param animated wheather use draw animation
 */
-(void)showInfoWithStatus:(NSString *)status animated:(BOOL)animated;

/**
 *  Set the subm mode to LHProgressHUDSubModeSuccess
 *
 *  @param status   Text to sow
 *  @param animated wheather use draw animation
 */
-(void)showSuccessWithStatus:(NSString *)status animated:(BOOL)animated;

/**
 *  Set the subm mode to LHProgressHUDSubModeFailure
 *
 *  @param status   Text to sow
 *  @param animated wheather use draw animation
 */
-(void)showFailureWithStatus:(NSString *)status animated:(BOOL)animated;

/**
 *  Hide the HUD and remove it from superview
 */
-(void)hide;

/**
 *  Hide after delay
 *
 *  @param delay time duration
 */
-(void)hideAfterDelay:(CGFloat)delay;

/**
 *  Hide after delay and execute completion block
 *
 *  @param delay       delay time duration
 *  @param hiddenBlock completion block
 */
-(void)hideAfterDelay:(CGFloat)delay hiddenBlock:(void(^)(void))hiddenBlock;

/**
 *  The outside round circle color of spinner
 */
@property (strong,nonatomic)UIColor * spinnerColor;

/**
 *  The color of inside success/failure/info color
 */
@property (strong,nonatomic)UIColor * infoColor;
/**
 *  Main mode
 */
@property (assign,nonatomic)LHProgressHUDMode mode;

/**
 *  Sub mode
 */
@property (assign,nonatomic,readonly)LHPRogressHUDSubMode subMode;
/**
 *  The background view,same size as the attached view
 */
@property (strong,nonatomic)LHBackgroundView * backgroundView;
/**
 *  The center contain view
 */
@property (strong,nonatomic)LHBackgroundView * centerBackgroundView;
/**
 *  Use this to set text
 */
@property (strong,nonatomic)UILabel * textLabel;
/**
 *  Use this to set customview,this is only useful when mode is LHProgressHUDModeCustomView
 */
@property (strong,nonatomic)UIView * customView;

/**
 *  The block to execute when the hud is hiddded
 */
@property (copy,nonatomic)void(^didHiddenBlock)(void);

/**
 *  yOffset of the HUD,relative to center
 */
@property (assign,nonatomic)CGFloat yOffset;

/**
 *  xOffset of the HUD,relative to center
 */
@property (assign,nonatomic)CGFloat xOffset;

/**
 *  Use this to set Gif,this is only useful when mode is LHPRogressHUDModeGif
 */
@property (strong,nonatomic)LHGifImageView * gifImageView;

/**
 *  Wheather to be square,in some case when text is short,using square will make animation smoth
 */
@property (assign,nonatomic)BOOL square;

/**
 *  When hud is large,for example,when text is very long ,the min space between hud and the superview margin
 *  Default is 20
 */
@property (assign,nonatomic)CGFloat margin;

@end
