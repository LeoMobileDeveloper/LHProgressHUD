//
//  DemoTableViewController.m
//  LHProgressHUD
//
//  Created by huangwenchen on 16/6/14.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "DemoTableViewController.h"
#import "LHProgressHUD.h"
#import "LHGifImageView.h"
#import "LHProgressHUDCustomView.h"

@interface DemoTableViewController ()

@property (weak,nonatomic)LHProgressHUD * hud;

@property (strong,nonatomic)NSTimer * progressTimer;

@property (assign,nonatomic)CGFloat progress;

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    self.tableView.backgroundView = bg;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray * titles = @[@"Normal",@"Progress",@"Text",@"Gif",@"Other"];
    return titles[section];
}
-(NSArray *)rowTitles{
    return @[
             @[@"normal",@"success",@"fail",@"info",@"Normal state with text",@"Normal then success",@"Full Screen Blur"],
             @[@"UIActivityIndicator",@"UIActivityIndicator with text"],
             @[@"Pure Text",@"Very long text"],
             @[@"Show gif"],
             @[@"CustomView",@"Progress",],
             ];
}
-(NSArray *)selectors{
    return @[
             @[@"showNormal",@"showSuccess",@"showFail",@"showInfo",@"showNormalWithText",@"NormalThenSuccess",@"fullBlur"],
             @[@"activityIndicator",@"activityIndicatorWithText"],
             @[@"prueText",@"longText"],
             @[@"showGif"],
             @[@"customView",@"progressView",],
             ];
}
-(void)showNormal{
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:self.view];
    [hud hideAfterDelay:2.0];
}
-(void)showSuccess{
    LHProgressHUD * hud = [LHProgressHUD showSuccessAddedToView:self.view animated:YES];
    hud.spinnerColor = [UIColor whiteColor];
    hud.infoColor = [UIColor orangeColor];
    [hud hideAfterDelay:1.0];
}
-(void)showFail{
    LHProgressHUD * hud = [LHProgressHUD showFailureAddedToView:self.view animated:YES];
    hud.textLabel.text = @"Some error";
    [hud hideAfterDelay:1.0];
}
-(void)showInfo{
    LHProgressHUD * hud = [LHProgressHUD showInfoAddedToView:self.view animated:NO];
    hud.textLabel.text = @"Disable draw animation";
    [hud hideAfterDelay:1.0];
}
-(void)showNormalWithText{
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:self.view];
    hud.textLabel.text = @"Loading...";
    [hud hideAfterDelay:1.0];
}
-(void)NormalThenSuccess{
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:self.view];
    hud.square = YES;
    hud.textLabel.text = @"Loading...";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud showSuccessWithStatus:@"Success" animated:YES];
        [hud hideAfterDelay:1.0 hiddenBlock:^{
            NSLog(@"HUD is hidden");
        }];
    });
}
-(void)fullBlur{
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:[UIApplication sharedApplication].keyWindow];
    hud.textLabel.text = @"Loading...";
    hud.spinnerColor = [UIColor whiteColor];
    hud.infoColor = [UIColor orangeColor];
    hud.backgroundView.blurStyle = LHBlurEffectStyleDark;
    hud.centerBackgroundView.blurStyle = LHBlurEffectStyleNone;
    hud.centerBackgroundView.backgroundColor = [UIColor clearColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud showSuccessWithStatus:@"Success" animated:YES];
        [hud hideAfterDelay:1.0 hiddenBlock:^{
            NSLog(@"HUD is hidden");
        }];
    });
}
-(void)activityIndicator{
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:self.view];
    hud.mode = LHProgressHUDModeActivityIdenticator;
    [hud hideAfterDelay:1.0];
}
-(void)activityIndicatorWithText{
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:self.view];
    hud.mode = LHProgressHUDModeActivityIdenticator;
    hud.textLabel.text = @"Loading...";
    [hud hideAfterDelay:1.0];
}
-(void)prueText{
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:self.view];
    hud.mode = LHProgressHUDModeTextOnly;
    hud.textLabel.text = @"Loading...";
    [hud hideAfterDelay:1.0];
}
-(void)longText{
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:self.navigationController.view];
    hud.mode = LHProgressHUDModeTextOnly;
    hud.textLabel.text = @"Balabala,BalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabala,BalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabala,BalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabalaBalabala";
    [hud hideAfterDelay:1.0];
}
-(void)showGif{
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:self.view];
    hud.mode = LHPRogressHUDModeGif;
    hud.centerBackgroundView.blurStyle = LHBlurEffectStyleNone;
    hud.centerBackgroundView.backgroundColor = [UIColor clearColor];
    hud.gifImageView = [[LHGifImageView alloc] initWithGifImageName:@"gif"];
    [hud hideAfterDelay:3.0];
}
-(void)customView{
    LHProgressHUDCustomView * customView = [[LHProgressHUDCustomView alloc] init];
    customView.backgroundColor = [UIColor redColor];
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:self.view];
    hud.mode = LHProgressHUDModeCustomView;
    hud.customView = customView;
    [hud hideAfterDelay:1.0];
}
-(void)progressView{
    self.progress = 0.00;
    LHProgressHUD * hud = [LHProgressHUD showAddedToView:self.view];
    hud.mode = LHProgressHUDModeProgress;
    hud.textLabel.text = @"Downloading...";
    self.hud = hud;
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                          target:self
                                                        selector:@selector(updateProgress)
                                                        userInfo:nil
                                                         repeats:YES];
}
-(void)updateProgress{
    self.progress += 0.01;
    self.hud.progress = self.progress;
    if (self.progress >= 1.00) {
        [self.progressTimer invalidate];
        self.progressTimer = nil;
        [self.hud showSuccessWithStatus:@"Success" animated:YES];
        [self.hud hideAfterDelay:1.0];
    }
}
#pragma mark - Tableview delegate and datasource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self rowTitles][section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString * title  = [[[self rowTitles] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * selector = [[[self selectors] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [self performSelectorOnMainThread:NSSelectorFromString(selector) withObject:nil waitUntilDone:NO];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
