//
//  SNLoginRegisterViewController.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/20.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNLoginRegisterViewController.h"

@interface SNLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation SNLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showLoginOrRegister:(UIButton *)sender {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        //显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        sender.selected=YES;
    }
    else
    {
        //显示登陆界面
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 让控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
