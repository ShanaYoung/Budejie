//
//  SNTopicViewController.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/27.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "SNTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "SNTopicCell.h"
#import "SNCommentController.h"

@interface SNTopicViewController ()

/** 帖子数据 */
@property(nonatomic,strong) NSMutableArray *topics;
/** 当前页码 */
@property(nonatomic,assign) NSInteger page;
/** 当加载下一页数据时需要这个参数 */
@property(nonatomic,copy)NSString *maxtime;
/** 上一次请求的参数 */
@property(nonatomic,strong) NSDictionary *params;
@end

@implementation SNTopicViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [[NSMutableArray alloc] init];
    }
    
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
}

static NSString * const SNTopicCellId = @"topic";

- (void)setupTableView
{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = SNTitilesViewY + SNTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    //设置时滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SNTopicCell class]) bundle:nil] forCellReuseIdentifier:SNTopicCellId];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 数据处理
/** 加载新帖子数据 */
- (void)loadNewTopics
{
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.paramsForList;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典 -> 模型
        self.topics = [SNTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return ;
        }
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSString *)paramsForList
{
    return [self.parentViewController isKindOfClass:[SNTopicViewController class]] ? @"list" : @"newlist";
}

//  先下拉刷新，再上拉刷新第5页数据

//下拉刷新成功回来，只有一页数据，page == 0
//上拉刷新成功回来，最前面那页 + 第5页数据

/** 加载更多帖子的数据 */
- (void)loadMoreTopics
{
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.paramsForList;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典 -> 模型
        NSArray *newTopics = [SNTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        //刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        //设置页码
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return ;
        }
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:SNTopicCellId];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}


#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNCommentController *cc = [[SNCommentController alloc] init];
    cc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:cc animated:YES];
}

@end
