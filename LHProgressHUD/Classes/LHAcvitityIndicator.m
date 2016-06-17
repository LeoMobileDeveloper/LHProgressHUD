//
//  LHSpinner.m
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/5.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "LHAcvitityIndicator.h"
#define SPINNER_SIZE 50

@interface LHAcvitityIndicator ()

@property (nonatomic,strong)CAShapeLayer * layerFirst;

@property (nonatomic,strong)CAShapeLayer * layerSecond;

@property (nonatomic,strong)CAShapeLayer * thridLayer;

@property (assign,nonatomic)BOOL shouldStop;

@end

@implementation LHAcvitityIndicator

-(instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0,0,SPINNER_SIZE,SPINNER_SIZE)]) {
        _padding = 6.0;
        _shouldStop = NO;
        _spinnerColor = [UIColor whiteColor];
        _infoColor = [UIColor whiteColor];
        [self setUpLayers];
    }
    return self;
}
-(void)setUpLayers{
    _layerFirst = [CAShapeLayer layer];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGPoint center = CGPointMake(width/2, height/2);
    CGFloat min = MIN(width, height);
    CGFloat radius = min/2 - _padding;
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                               radius:radius
                                                           startAngle:-M_PI/2
                                                             endAngle:M_PI * 2 - M_PI/2
                                                            clockwise:YES];
    _layerFirst.path = bezierPath.CGPath;
    _layerFirst.strokeStart = 0.05;
    _layerFirst.strokeEnd = 0.05;
    _layerFirst.lineCap = kCALineCapRound;
    _layerFirst.lineWidth = 3.0;
    _layerFirst.strokeColor = _spinnerColor.CGColor;
    _layerFirst.fillColor = [UIColor clearColor].CGColor;
    _layerFirst.anchorPoint = CGPointMake(0.5, 0.5);
    _layerFirst.position = center;
    _layerFirst.bounds = self.bounds;
    [self.layer addSublayer:_layerFirst];
    
    _thridLayer = [CAShapeLayer layer];
    UIBezierPath * bz3 = [UIBezierPath bezierPathWithArcCenter:center
                                                               radius:radius
                                                           startAngle:-M_PI/2
                                                             endAngle:M_PI * 2 - M_PI/2
                                                            clockwise:YES];
    _thridLayer.path = bz3.CGPath;
    _thridLayer.strokeStart = 0.00;
    _thridLayer.strokeEnd = 0.05;
    _thridLayer.lineCap = kCALineCapRound;
    _thridLayer.lineWidth = 3.0;
    _thridLayer.strokeColor = _spinnerColor.CGColor;
    _thridLayer.fillColor = [UIColor clearColor].CGColor;
    _thridLayer.anchorPoint = CGPointMake(0.5, 0.5);
    _thridLayer.position = center;
    _thridLayer.bounds = self.bounds;
    _thridLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_thridLayer];
    
    
    _layerSecond = [CAShapeLayer layer];
    _layerSecond.path = [self successPath].CGPath;
    _layerSecond.lineCap = kCALineCapRound;
    _layerSecond.lineWidth = 3.0;
    _layerSecond.strokeEnd = 0.0;
    _layerSecond.strokeColor = _infoColor.CGColor;
    _layerSecond.fillColor = [UIColor clearColor].CGColor;
    _layerSecond.anchorPoint = CGPointMake(0.5, 0.5);
    _layerSecond.position = center;
    _layerSecond.bounds = self.bounds;
    [self.layer addSublayer:_layerSecond];
}
-(void)setSpinnerColor:(UIColor *)spinnerColor{
    _spinnerColor = spinnerColor;
    _layerFirst.strokeColor = spinnerColor.CGColor;
    _thridLayer.strokeColor = spinnerColor.CGColor;
}
-(void)setInfoColor:(UIColor *)infoColor{
    _infoColor = infoColor;
    _layerSecond.strokeColor = infoColor.CGColor;
}
-(void)transactionUpdate:(void(^)(void))block{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    block();
    [CATransaction commit];
}
-(void)animateStrokeStart{
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeStart";
    animation.fromValue = @(0.05);
    animation.toValue = @(1.00);
    animation.duration = 1.3;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layerFirst addAnimation:animation forKey:@"strokeStart"];
    [self transactionUpdate:^{
        self.layerFirst.strokeStart = 1.00;
        self.layerFirst.strokeEnd = 1.00;
    }];
}
-(void)animateStrokeEnd{
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.fromValue = @(0.05);
    animation.toValue = @(1.00);
    animation.duration = 1.3;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layerFirst addAnimation:animation forKey:@"strokeEnd"];
    [self transactionUpdate:^{
        self.layerFirst.strokeStart = 0.05;
        self.layerFirst.strokeEnd = 1.00;
    }];
}
-(void)animateRotate{
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = @(0.00);
    animation.toValue = @(M_PI * 2);
    animation.duration = 2.0;
    animation.repeatCount = NSIntegerMax;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layerFirst addAnimation:animation forKey:@"rotate"];
    [self.thridLayer addAnimation:animation forKey:@"rotate"];
}
-(void)animateSecondLayer{
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.fromValue = @(0.00);
    animation.toValue = @(1.00);
    animation.duration = 0.8;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layerSecond addAnimation:animation forKey:@"strokeEnd"];
}
-(void)updateToSuccess:(BOOL)animated{
    _shouldStop = YES;
    [self.layerFirst removeAllAnimations];
    [self.thridLayer removeAllAnimations];
    [self transactionUpdate:^{
        self.layerFirst.strokeStart = 0.05;
        self.layerFirst.strokeEnd = 1.00;
    }];
    if (animated) {
        _layerSecond.path = [self successPath].CGPath;
        self.layerSecond.hidden = NO;
        [self animateSecondLayer];
    }else{
        [self transactionUpdate:^{
            _layerSecond.path = [self successPath].CGPath;
            self.layerSecond.hidden = NO;
            self.layerSecond.strokeEnd = 1.0;
        }];
    }
}

-(void)updateToFail:(BOOL)animated{
    _shouldStop = YES;
    [self.thridLayer removeAllAnimations];
    [self.layerFirst removeAllAnimations];
    [self transactionUpdate:^{
        self.layerFirst.strokeStart = 0.05;
        self.layerFirst.strokeEnd = 1.00;
    }];
    if (animated) {
        self.layerSecond.hidden = NO;
        _layerSecond.path = [self failurePath].CGPath;
        [self animateSecondLayer];
    }else{
        [self transactionUpdate:^{
            self.layerSecond.hidden = NO;
            _layerSecond.path = [self failurePath].CGPath;
            self.layerSecond.strokeEnd = 1.0;

        }];
    }
}
-(void)updateToInfo:(BOOL)animated{
    _shouldStop = YES;
    [self.layerFirst removeAllAnimations];
    [self.thridLayer removeAllAnimations];
    [self transactionUpdate:^{
        self.layerFirst.strokeStart = 0.05;
        self.layerFirst.strokeEnd = 1.00;
    }];
    if (animated) {
        self.layerSecond.hidden = NO;
        _layerSecond.path = [self infoPath].CGPath;
        [self animateSecondLayer];
    }else{
        [self transactionUpdate:^{
            self.layerSecond.hidden = NO;
            _layerSecond.path = [self infoPath].CGPath;
            self.layerSecond.strokeEnd = 1.0;
            
        }];
    }
}
#pragma mark - API
-(void)startAnimating{
    _shouldStop = NO;
    self.layerSecond.hidden = YES;
    [self animateStrokeEnd];
    [self animateRotate];
}
-(void)stopAnimate{
    
}
#pragma mark - Animation
-(CGSize)intrinsicContentSize{
    return CGSizeMake(SPINNER_SIZE, SPINNER_SIZE);
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([self.layerFirst animationForKey:@"strokeEnd"] == anim) {
        if (_shouldStop) {
            return;
        }
        [self animateStrokeStart];
    }else if([self.layerFirst animationForKey:@"strokeStart"] == anim){
        [self animateStrokeEnd];
    }
}
#pragma mark - Path
-(UIBezierPath *)successPath{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGPoint center = CGPointMake(width/2, height/2);
    CGFloat min = MIN(width, height);
    CGFloat radius = min/2 - _padding;
    UIBezierPath * sbz = [UIBezierPath bezierPath];
    CGFloat startX = center.x - radius/2;
    CGFloat startY = center.y + radius/8;
    [sbz moveToPoint:CGPointMake(startX, startY)];
    CGFloat tX = center.x - radius/4;
    CGFloat tY = center.y + radius/4 + radius/8;
    [sbz addLineToPoint:CGPointMake(tX, tY)];
    CGFloat endX = center.x + radius/2;
    CGFloat endY = center.y - radius/2 + radius/8;
    [sbz addLineToPoint:CGPointMake(endX, endY)];
    return sbz;
}
-(UIBezierPath *)failurePath{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGPoint center = CGPointMake(width/2, height/2);
    CGFloat min = MIN(width, height);
    CGFloat radius = min/2 - _padding;
    UIBezierPath * sbz = [UIBezierPath bezierPath];
    CGFloat startX = center.x - radius/4;
    CGFloat startY = center.y - radius/4;
    [sbz moveToPoint:CGPointMake(startX, startY)];
    CGFloat tX = center.x + radius/4;
    CGFloat tY = center.y + radius/4;
    [sbz addLineToPoint:CGPointMake(tX, tY)];
    [sbz moveToPoint:CGPointMake(center.x - radius/4, center.y + radius/4)];
    [sbz addLineToPoint:CGPointMake(center.x + radius/4, center.y - radius/4)];
    return sbz;
}
-(UIBezierPath *)infoPath{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGPoint center = CGPointMake(width/2, height/2);
    CGFloat min = MIN(width, height);
    CGFloat radius = min/2 - _padding;
    UIBezierPath * sbz = [UIBezierPath bezierPath];
    [sbz moveToPoint:CGPointMake(center.x , center.y - radius/4 - radius / 8)];
    [sbz addLineToPoint:CGPointMake(center.x , center.y - radius/4 - radius / 10)];
    [sbz moveToPoint:CGPointMake(center.x, center.y  - radius/8)];
    [sbz addLineToPoint:CGPointMake(center.x, center.y + radius/4 + radius /8)];
    return sbz;
}
@end
