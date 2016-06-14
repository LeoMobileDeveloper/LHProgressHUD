//
//  LHGifImageView.m
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/12.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "LHGifImageView.h"
#import "UIImage+LHProgressHUD.h"

@implementation LHGifImageView

-(instancetype)initWithGifImageData:(NSData *)data{
    if (self = [super init]) {
        UIImage * image = [UIImage lh_gifWithData:data];
        self.image = image;
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
-(instancetype)initWithGifImageWithFilePath:(NSString *)filePath{
    if (self = [super init]) {
        NSData * data = [NSData dataWithContentsOfFile:filePath];
        self.image = [UIImage lh_gifWithData:data];
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
-(instancetype)initWithGifImageName:(NSString *)imageName{
    if (self = [super init]) {
        self.image = [UIImage lh_gifImageNamed:imageName];
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
@end
