//
//  SNRecommendTagsViewController.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/19.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNRecommendTagsViewController.h"
#import "SNRecommendTag.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "SNRecommendTagCell.h"

@interface SNRecommendTagsViewController ()

/** 标签数据 */
@property(nonatomic,strong)NSArray *tags;

@end

static NSString *const SNTagsID=@"tag";

@implementation SNRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    [self loadTags];
}

-(void)loadTags
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"tag_recommend";
    params[@"action"]=@"sub";
    params[@"c"]=@"topic";
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tags=[SNRecommendTag objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"添加标签数据失败"];
    }];
}

-(void)setupTableView
{
    self.title=@"推荐标签";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SNRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:SNTagsID];
    self.tableView.rowHeight=70;
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=SNGlobalBg;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNRecommendTagCell *cell=[tableView dequeueReusableCellWithIdentifier:SNTagsID];
    
    cell.recommendTag=self.tags[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
