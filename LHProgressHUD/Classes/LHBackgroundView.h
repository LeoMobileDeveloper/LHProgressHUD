//
//  LHBackgroundView.h
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/7.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
 typedef NS_ENUM(NSInteger,LHBlurEffectStyle){
     /**
      *  No blur
      */
     LHBlurEffectStyleNone,
     /**
      *  Same as UIEffectStyleExtraLight
      */
     LHBlurEffectStyleExtraLight,
     /**
      *  Same as UIEffectStyleLight
      */
    LHBlurEffectStyleLight,
     /**
      *  Same as UIEffectStyleDark
      */
    LHBlurEffectStyleDark
};
@interface LHBackgroundView : UIView

/**
 *  The blur style
 */
@property (assign,nonatomic)LHBlurEffectStyle  blurStyle;

@end
