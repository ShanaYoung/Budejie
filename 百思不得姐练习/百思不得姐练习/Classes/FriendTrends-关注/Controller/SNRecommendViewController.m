//
//  SNRecommendViewController.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/13.
//  Copyright © 2016年 Shana. All rights reserved.
//
#import "SNRecommendViewController.h"
#import "SVProgressHUD.h"
#import <AFNetworking.h>
#import "SNRecmmendCategoryCell.h"
#import <MJExtension.h>
#import "SNRecomendCategory.h"
#import "SNRecommendUser.h"
#import "SNRecommendUserCell.h"
#import <MJRefresh.h>

#define SNSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface SNRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 左边类的数据 */
@property(nonatomic,strong)NSArray *categories;

/** 左边类别的表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 请求的参数 */
@property(nonatomic,strong)NSMutableDictionary *params;

/** afn请求管理者 */
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation SNRecommendViewController

static NSString * const SNCategoryId = @"category";
static NSString * const SNUserId = @"user";

-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager=[AFHTTPSessionManager manager];
    }
    
    return _manager;
}

/** 加载左侧的数据类别 */
-(void)loadCategories
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"category";
    params[@"c"]=@"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回的json数据
        self.categories=[SNRecomendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败！"];
    }];
}

/** 添加刷新控件 */
-(void)setupRefresh
{
    //添加下拉刷新控件，下拉刷新时出现新数据
    self.userTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //添加上拉刷新控件，上拉刷新时出现更多数据
    self.userTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden=YES;
}

#pragma mark - 加载用户数据
-(void)loadNewUsers
{
    SNRecomendCategory *rc=SNSelectedCategory;
    
    //设置当前页码为1
    rc.currentPage=1;
    
    //请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"list";
    params[@"c"]=@"subscribe";
    params[@"category_id"]=@(rc.id);
    params[@"page"]=@(rc.currentPage);
    self.params=params;
    
    //发送请求给服务器
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组——>模型数组
        NSArray *users=[SNRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除所有旧数据
        [rc.users removeAllObjects];
        
        //添加到当前类别对应的数组中
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total=[responseObject[@"total"] integerValue];
        
        //不是最后一次请求
        //因为用户会乱点乱点的，有时候会造成数据在从服务器返回的过程中，用户切换了点击事件，造成
        //在返回数据的过程中，数据还没回来，用户就要看下一个界面，造成堵塞或者卡顿现象
        if (self.params!=params) {
            return ;
        }
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        //让底部控件结束刷新，自己因为该方法会多次用到，所以包装了起来
        [self chekFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params!=params) {
            return ;
        }
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}

/** 时刻检测footer的状态 */
-(void)chekFooterState
{
    SNRecomendCategory *rc=SNSelectedCategory;
    
    //每次刷新右边数据时，都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden=(rc.users.count==0);
    
    //让底部控件结束刷新
    if (rc.users.count==rc.total) {
        //全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }
    else
    {
        //还没有加载完
        [self.userTableView.mj_footer endRefreshing];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //加载左侧的类别数据
    [self loadCategories];
}

-(void)loadMoreUsers
{
    SNRecomendCategory *category = SNSelectedCategory;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [SNRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 让底部控件结束刷新
        [self chekFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.userTableView.footer endRefreshing];
    }];
}

-(void)setupTableView
{
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SNRecmmendCategoryCell class]) bundle:nil] forCellReuseIdentifier:SNCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SNRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:SNUserId];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.categoryTableView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset=self.categoryTableView.contentInset;
    self.userTableView.rowHeight=70;
    
    //设置标题
    self.title=@"推荐关注";
    self.view.backgroundColor=SNGlobalBg;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //左边的类别表格
    if (tableView==self.categoryTableView) {
        return self.categories.count;
    }
    
    //检测footer的状态
    [self chekFooterState];
    
    return [SNSelectedCategory users].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.categoryTableView) {//左侧类别表格
        SNRecmmendCategoryCell *cell=[tableView dequeueReusableCellWithIdentifier:SNCategoryId];
        cell.category=self.categories[indexPath.row];
        
        return cell;
    }
    else
    {
        SNRecommendUserCell *cell=[tableView dequeueReusableCellWithIdentifier:SNUserId];
        cell.user=[SNSelectedCategory users][indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    SNRecomendCategory *c=self.categories[indexPath.row];
    
    if (c.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    }else
    {
        //赶紧刷新表格，目的：马上显示当前category的用户数据，不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器的销毁
-(void)dealloc
{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
