//
//  SNFriendTrendsViewController.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/13.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNFriendTrendsViewController.h"
#import "SNRecommendViewController.h"
#import "SNLoginRegisterViewController.h"

@interface SNFriendTrendsViewController ()

@end

@implementation SNFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"我的关注";
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    //背景颜色
    self.view.backgroundColor=SNGlobalBg;
}

- (IBAction)loginRegister:(id)sender {
    
    SNLoginRegisterViewController *rvc=[[SNLoginRegisterViewController alloc] init];
    [self presentViewController:rvc animated:YES completion:nil];
    
}


-(void)friendsClick
{
    SNRecommendViewController *vc=[[SNRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
