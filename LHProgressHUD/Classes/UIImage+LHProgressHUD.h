//
//  UIImageView+LHProgressHUD.h
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/13.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface UIImage (LHProgressHUD)

+ (UIImage *)lh_gifImageNamed:(NSString *)name;

+ (UIImage *)lh_gifWithData:(NSData *)data;

@end
