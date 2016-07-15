//
//  LHProgressHUD.m
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/6.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "LHProgressHUD.h"
#import "LHAcvitityIndicator.h"

#define  CORNER_RADIUS 8
#define LHOnManThread() [[NSThread currentThread] isMainThread]

@interface LHProgressHUD ()

@property (strong,nonatomic)UIView * lhSpinner;

@property (strong,nonatomic)NSTimer * hideTimer;

@property (strong,nonatomic)UIView * topSpaceView;

@property (strong,nonatomic)UIView * bottomSpaceView;

@property (strong,nonatomic)UIView * leftSpaceView;

@property (strong,nonatomic)UIView * rightSpaceView;

@property (assign,nonatomic)CGFloat centerMargin;

@end

@implementation LHProgressHUD

#pragma mark - Init method
-(instancetype)initWithAttachedView:(UIView *)view mode:(LHProgressHUDMode)mode subMode:(LHPRogressHUDSubMode)subMode animated:(BOOL)animated{
    if (self = [super initWithFrame:view.bounds]) {
        _mode = mode;
        _subMode = subMode;
        _xOffset = 0.0;
        _yOffset = 0.0;
        _margin = 20.0;
        _centerMargin = 20.0;
        _square = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [view addSubview:self];
        [self commonInit];
        [self updateSpinner];
        [self setNeedsUpdateConstraints];
        if (self.lhSpinner && [self.lhSpinner isKindOfClass:LHAcvitityIndicator.class]) {
            if (_subMode == LHProgressHUDSubModeInfo) {
                [(LHAcvitityIndicator*)self.lhSpinner updateToInfo:animated];
            }else if(_subMode == LHProgressHUDSubModeSuccess){
                [(LHAcvitityIndicator*)self.lhSpinner updateToSuccess:animated];
            }else if (_subMode == LHProgressHUDSubModeFailure){
                [(LHAcvitityIndicator*)self.lhSpinner updateToFail:animated];
            }else{
                [(LHAcvitityIndicator*)self.lhSpinner startAnimating];
            }
        }
    }
    return self;
}
+(instancetype)showAddedToView:(UIView *)view{
    return [[self alloc] initWithAttachedView:view
                                         mode:LHProgressHUDModeNormal
                                      subMode:LHProgressHUDSubModeAnimating
                                     animated:YES];
}
+(instancetype)showInfoAddedToView:(UIView *)view animated:(BOOL)animated{
    return [[self alloc] initWithAttachedView:view
                                         mode:LHProgressHUDModeNormal
                                      subMode:LHProgressHUDSubModeInfo
                                     animated:animated];
}
+(instancetype)showFailureAddedToView:(UIView *)view animated:(BOOL)animated{
    return [[self alloc] initWithAttachedView:view
                                         mode:LHProgressHUDModeNormal
                                      subMode:LHProgressHUDSubModeFailure
                                     animated:animated];
}
+(instancetype)showSuccessAddedToView:(UIView *)view animated:(BOOL)animated{
    return [[self alloc] initWithAttachedView:view
                                         mode:LHProgressHUDModeNormal
                                      subMode:LHProgressHUDSubModeSuccess
                                     animated:YES];
}
#pragma mark - SubMode switch
-(void)showInfoWithStatus:(NSString *)status animated:(BOOL)animated{
    LHOnManThread();
    if ([self.lhSpinner isKindOfClass:[LHAcvitityIndicator class]]) {
        _subMode = LHProgressHUDSubModeInfo;
        _textLabel.text = status;
        [(LHAcvitityIndicator *)self.lhSpinner updateToInfo:animated];
    }
}
-(void)showSuccessWithStatus:(NSString *)status animated:(BOOL)animated{
    LHOnManThread();
    _mode = LHProgressHUDModeNormal;
    _subMode = LHProgressHUDSubModeSuccess;
    _textLabel.text = status;
    [(LHAcvitityIndicator *)self.lhSpinner updateToSuccess:animated];
}

-(void)showFailureWithStatus:(NSString *)status animated:(BOOL)animated{
    LHOnManThread();
    _mode = LHProgressHUDModeNormal;
    _subMode = LHProgressHUDSubModeFailure;
    _textLabel.text = status;
    [(LHAcvitityIndicator *)self.lhSpinner updateToFail:animated];
}

-(void)resetWithStatus:(NSString *)status{
    LHOnManThread();
    _subMode = LHProgressHUDSubModeAnimating;
    _textLabel.text = status;
    [(LHAcvitityIndicator *)self.lhSpinner stopAnimate];
    [(LHAcvitityIndicator *)self.lhSpinner startAnimating];
}

#pragma mark - Set function of property
-(void)setMode:(LHProgressHUDMode)mode{
    if (_mode != mode) {
        _mode = mode;
        [self updateSpinner];
        [self setNeedsUpdateConstraints];
    }
}
-(void)setSquare:(BOOL)square{
    if (_square != square) {
        _square = square;
        [self setNeedsUpdateConstraints];
    }
}
-(void)setCustomView:(UIView *)customView{
    if (_customView != customView) {
        _customView = customView;
        [self updateSpinner];
        [self setNeedsUpdateConstraints];
    }
}
-(void)setGifImageView:(LHGifImageView *)gifImageView{
    _gifImageView = gifImageView;
    [self updateSpinner];
    [self setNeedsUpdateConstraints];
}
-(void)setXOffset:(CGFloat)xOffset{
    _xOffset = xOffset;
    [self updateSpinner];
    [self setNeedsUpdateConstraints];
}
-(void)setYOffset:(CGFloat)yOffset{
    _yOffset = yOffset;
    [self updateSpinner];
    [self setNeedsUpdateConstraints];
}
-(void)setInfoColor:(UIColor *)infoColor{
    _infoColor = infoColor;
    if ([self.lhSpinner isKindOfClass:[LHAcvitityIndicator class]]) {
        [(LHAcvitityIndicator *)self.lhSpinner setInfoColor:infoColor];
    }
}
-(void)setSpinnerColor:(UIColor *)spinnerColor{
    _spinnerColor = spinnerColor;
    if ([self.lhSpinner isKindOfClass:[LHAcvitityIndicator class]]) {
        [(LHAcvitityIndicator *)self.lhSpinner setSpinnerColor:spinnerColor];
    }
}
-(void)setMargin:(CGFloat)margin{
    if (_margin != margin) {
        _margin = MAX(margin, 0.0);
        [self setNeedsUpdateConstraints];
    }
}
-(void)setCenterMargin:(CGFloat)centerMargin{
    if (_centerMargin != centerMargin) {
        _margin = MAX(_centerMargin, 0.0);
        [self setNeedsUpdateConstraints];
    }
}
#pragma mark - APIS
-(void)hide{
    [UIView transitionWithView:self.superview
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.hidden = YES;
                    }
                    completion:^(BOOL finished) {
                        [self removeFromSuperview];
                        if (_didHiddenBlock) {
                            _didHiddenBlock();
                        }
                    }];
}

-(void)hideAfterDelay:(CGFloat)delay{
    _hideTimer = [NSTimer timerWithTimeInterval:delay
                                         target:self
                                       selector:@selector(hide)
                                       userInfo:nil
                                        repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_hideTimer forMode:NSRunLoopCommonModes];
}

-(void)hideAfterDelay:(CGFloat)delay hiddenBlock:(void (^)(void))hiddenBlock{
    _didHiddenBlock = hiddenBlock;
    [self hideAfterDelay:delay];
}
#pragma mark - Views and constraints
-(void)updateSpinner{
    if (self.mode == LHProgressHUDModeNormal) {
        if ([self.lhSpinner isKindOfClass:[LHAcvitityIndicator class]]) {
            return;
        }
        [self.lhSpinner removeFromSuperview];
        LHAcvitityIndicator * lhSpinner = [[LHAcvitityIndicator alloc] init];
        lhSpinner.translatesAutoresizingMaskIntoConstraints = NO;
        self.lhSpinner = lhSpinner;
        [_centerBackgroundView addSubview:self.lhSpinner];
    }else if(self.mode == LHProgressHUDModeTextOnly){
        if (self.lhSpinner) {
            [self.lhSpinner removeFromSuperview];
            self.lhSpinner = nil;
        }
    }else if(self.mode == LHProgressHUDModeActivityIdenticator){
        if ([self.lhSpinner isKindOfClass:[UIActivityIndicatorView class]]) {
            return;
        }
        [self.lhSpinner removeFromSuperview];
        UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [spinner startAnimating];
        self.lhSpinner = spinner;
        spinner.translatesAutoresizingMaskIntoConstraints = NO;
        [_centerBackgroundView addSubview:self.lhSpinner];
    }else if(self.mode == LHProgressHUDModeCustomView){
        [self.lhSpinner removeFromSuperview];
        if (self.customView == nil) {
            return;
        }
        self.lhSpinner = self.customView;
        self.lhSpinner.translatesAutoresizingMaskIntoConstraints = NO;
        [_centerBackgroundView addSubview:self.customView];
    }else if(self.mode == LHPRogressHUDModeGif){
        if ([self.lhSpinner isKindOfClass:[LHGifImageView class]]) {
            return;
        }
        [self.lhSpinner removeFromSuperview];
        self.lhSpinner = self.gifImageView;
        self.lhSpinner.translatesAutoresizingMaskIntoConstraints = NO;
        [_centerBackgroundView addSubview:self.gifImageView];
    }
}

-(void)commonInit{
    _backgroundView = [[LHBackgroundView alloc] initWithFrame:self.bounds];
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _backgroundView.backgroundColor = [UIColor clearColor];
    _backgroundView.blurStyle = LHBlurEffectStyleNone;
    [self addSubview:_backgroundView];

    _centerBackgroundView = [[LHBackgroundView alloc] initWithFrame:CGRectZero];
    _centerBackgroundView.blurStyle = LHBlurEffectStyleDark;
    _centerBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    _centerBackgroundView.layer.cornerRadius = CORNER_RADIUS;
    _centerBackgroundView.layer.masksToBounds = YES;
    [_centerBackgroundView setContentCompressionResistancePriority:998.0 forAxis:UILayoutConstraintAxisVertical];
    [_centerBackgroundView setContentCompressionResistancePriority:998.0 forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:_centerBackgroundView];
    
    LHAcvitityIndicator * lhSpinner = [[LHAcvitityIndicator alloc] init];
    lhSpinner.translatesAutoresizingMaskIntoConstraints = NO;
    [_centerBackgroundView addSubview:lhSpinner];
    self.lhSpinner = lhSpinner;
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.font = [UIFont boldSystemFontOfSize:14];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.numberOfLines = 0;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_centerBackgroundView addSubview:_textLabel];
    
    _topSpaceView = [[UIView alloc] init];
    _topSpaceView.backgroundColor = [UIColor clearColor];
    _topSpaceView.translatesAutoresizingMaskIntoConstraints = NO;
    [_centerBackgroundView addSubview:_topSpaceView];
    
    _bottomSpaceView = [[UIView alloc] init];
    _bottomSpaceView.backgroundColor = [UIColor clearColor];
    _bottomSpaceView.translatesAutoresizingMaskIntoConstraints = NO;
    [_centerBackgroundView addSubview:_bottomSpaceView];
}
-(void)updateConstraints{
    [self removeConstraints:self.constraints];
    [self.centerBackgroundView removeConstraints:self.centerBackgroundView.constraints];
    
    //Center contain View
    CGFloat paddingX = self.xOffset;
    CGFloat paddingY = self.yOffset;
    
    NSMutableArray * centerConstraints = [NSMutableArray new];
    [centerConstraints addObject:[NSLayoutConstraint constraintWithItem:_centerBackgroundView
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_backgroundView
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.0
                                                               constant:paddingX]];
    
    [centerConstraints addObject:[NSLayoutConstraint constraintWithItem:_centerBackgroundView
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_backgroundView
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1.0
                                                               constant:paddingY]];

    [self applyPriority:998.0 toConstraints:centerConstraints];
    [self addConstraints:centerConstraints];
    
    NSMutableArray *sideConstraints = [NSMutableArray array];
    [sideConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=margin)-[_centerBackgroundView]-(>=margin)-|"
                                                                                 options:0
                                                                                 metrics:@{@"margin":@(_margin)}
                                                                                   views:NSDictionaryOfVariableBindings(_centerBackgroundView)]];
    
    [sideConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=margin)-[_centerBackgroundView]-(>=margin)-|"
                                                                                 options:0
                                                                                 metrics:@{@"margin": @(_margin)}
                                                                                   views:NSDictionaryOfVariableBindings(_centerBackgroundView)]];
    [self applyPriority:999.0 toConstraints:sideConstraints];
    if (_square) {
        [_centerBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:_centerBackgroundView
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:_centerBackgroundView
                                                                          attribute:NSLayoutAttributeHeight
                                                                         multiplier:1.0
                                                                           constant:0.0]];
    }
    [self addConstraints:sideConstraints];
    if (self.lhSpinner) {
        [self setUpConstraintsWithSpinner];
    }else{
        [self setupConstraintsWithoutSpinner];
    }
    [self setUpConstraintsForSpacer];
    [super updateConstraints];

}
-(void)setUpConstraintsForSpacer{
    NSMutableArray * spacerConstraints = [NSMutableArray new];
    NSDictionary * matricsDic = @{@"margin":@(_centerMargin)};
    [spacerConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_topSpaceView]-0-|"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:NSDictionaryOfVariableBindings(_topSpaceView)]];
    [spacerConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bottomSpaceView]-0-|"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:NSDictionaryOfVariableBindings(_bottomSpaceView)]];
    [spacerConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_topSpaceView(==margin)]"
                                                                                   options:0
                                                                                   metrics:matricsDic
                                                                                     views:NSDictionaryOfVariableBindings(_topSpaceView)]];
    [spacerConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomSpaceView(==margin)]-0-|"
                                                                                   options:0
                                                                                   metrics:matricsDic
                                                                                     views:NSDictionaryOfVariableBindings(_bottomSpaceView)]];
    [spacerConstraints addObject:[NSLayoutConstraint constraintWithItem:_topSpaceView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_bottomSpaceView
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1.0
                                                               constant:0.0]];
    [_centerBackgroundView addConstraints:spacerConstraints];
}
-(void)setUpConstraintsWithSpinner{
    if (_lhSpinner == nil) {
        return;
    }
    NSDictionary * matricsDic = @{@"margin":@(_centerMargin)};
    NSMutableArray * centerInsideConstraints = [NSMutableArray new];
    [centerInsideConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=margin)-[_lhSpinner]-(>=margin)-|"
                                                                                    options:0
                                                                                    metrics:matricsDic
                                                                                      views:NSDictionaryOfVariableBindings(_lhSpinner)]];
    
    [centerInsideConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==margin)-[_textLabel]-(==margin)-|"
                                                                                         options:0
                                                                                         metrics:matricsDic
                                                                                           views:NSDictionaryOfVariableBindings(_textLabel)]];
    
    [centerInsideConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topSpaceView]-0-[_lhSpinner]-0-[_textLabel]-0-[_bottomSpaceView]"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:NSDictionaryOfVariableBindings(_topSpaceView,_lhSpinner,_textLabel,_bottomSpaceView)]];
    
    [centerInsideConstraints addObject:[NSLayoutConstraint constraintWithItem:_textLabel
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_centerBackgroundView
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0.0]];
    [centerInsideConstraints addObject:[NSLayoutConstraint constraintWithItem:_lhSpinner
                                                                    attribute:NSLayoutAttributeCenterX
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:_centerBackgroundView
                                                                    attribute:NSLayoutAttributeCenterX
                                                                   multiplier:1.0
                                                                     constant:0.0]];

    
    [_centerBackgroundView addConstraints:centerInsideConstraints];
}

-(void)setupConstraintsWithoutSpinner{
    NSDictionary * matricsDic = @{@"margin":@(_centerMargin)};
    NSMutableArray * labelConstraints = [NSMutableArray new];
    [labelConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==margin)-[_textLabel]-(==margin)-|"
                                                                                  options:0
                                                                                  metrics:matricsDic
                                                                                    views:NSDictionaryOfVariableBindings(_textLabel)]];
    [labelConstraints addObject:[NSLayoutConstraint constraintWithItem:_textLabel
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_centerBackgroundView
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0.0]];
    [labelConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topSpaceView]-0-[_textLabel]-0-[_bottomSpaceView]"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_topSpaceView,_textLabel,_bottomSpaceView)]];
    [_centerBackgroundView addConstraints:labelConstraints];
}
-(void)applyPriority:(UILayoutPriority)priority toConstraints:(NSArray *)constraints {
    for (NSLayoutConstraint *constraint in constraints) {
        constraint.priority = priority;
    }
}
@end
