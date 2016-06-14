//
//  LHGifImageView.h
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/12.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHGifImageView : UIImageView

-(instancetype)initWithGifImageName:(NSString *)imageName;

-(instancetype)initWithGifImageWithFilePath:(NSString *)filePath;

-(instancetype)initWithGifImageData:(NSData *)data;

@end
