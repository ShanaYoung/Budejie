//
//  SNMeViewController.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/13.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNMeViewController.h"
#import "SNMeCell.h"
#import "SNMeFooter.h"

@interface SNMeViewController ()

@end

@implementation SNMeViewController

static NSString *SNMeID = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableDetails];
    
}

- (void)setupNav
{
    self.navigationItem.title=@"我的";
    
    //设置导航栏右边的按钮
    UIBarButtonItem *settingItem=[UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem=[UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems=@[settingItem,moonItem];
    
}

- (void)setupTableDetails
{
//    //背景颜色
//    self.view.backgroundColor=SNGlobalBg;
//    
////    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//    [self.tableView registerClass:[SNMeCell class] forCellReuseIdentifier:SNMeID];
    
//    //调整header和footer
//    self.tableView.sectionHeaderHeight = 0;
//    self.tableView.sectionFooterHeight = SNTopicCellMargin;
//    
//    //调整Inset
//    self.tableView.contentInset = UIEdgeInsetsMake(SNTopicCellMargin - 35, 0, 0, 0);
//    
//    //设置footer
//    self.tableView.tableFooterView = [[SNMeFooter alloc] init];
    // 调整header和footer
    
    self.tableView.autoresizingMask = NO;
    // 设置背景色
    self.tableView.backgroundColor = SNGlobalBg;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SNMeCell class] forCellReuseIdentifier:SNMeID];
    
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = SNTopicCellMargin;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(SNTopicCellMargin - 35, 0, 0, 0);
    
    // 设置footerView
    self.tableView.tableFooterView = [[SNMeFooter alloc] init];
}

-(void)settingClick
{
    SNLogFunc;
}

-(void)moonClick
{
    SNLogFunc;
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNMeCell *cell = [tableView dequeueReusableCellWithIdentifier:SNMeID];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    }
    else if (indexPath.section == 1)
    {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
