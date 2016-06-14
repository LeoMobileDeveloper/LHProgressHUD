//
//  LHBackgroundView.m
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/7.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "LHBackgroundView.h"
@interface LHBackgroundView ()

@property (strong,nonatomic)UIVisualEffectView * effectView;

@end

@implementation LHBackgroundView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _blurStyle = LHBlurEffectStyleNone;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.80];
        [self updateViews];
    }
    return self;
}

-(void)setBlurStyle:(LHBlurEffectStyle)blurStyle{
    if (_blurStyle != blurStyle) {
        _blurStyle = blurStyle;
        [self updateViews];
    }
}
-(void)updateViews{
    if (self.effectView.superview != nil) {
        [self.effectView removeFromSuperview];
        self.effectView = nil;
    }
    UIBlurEffect * effect;
    self.backgroundColor = [UIColor clearColor];
    if (_blurStyle == LHBlurEffectStyleExtraLight) {
        effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    }else if(_blurStyle == LHBlurEffectStyleLight){
        effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }else if(_blurStyle == LHBlurEffectStyleDark){
        effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }else{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.80];
        return;
    }
    self.layer.allowsGroupOpacity = NO;
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    self.effectView.frame = self.bounds;
    self.effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.effectView];
}

- (CGSize)intrinsicContentSize {
    return CGSizeZero;
}

@end
