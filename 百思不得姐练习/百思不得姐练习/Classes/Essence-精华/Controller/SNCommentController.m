//
//  SNCommentController.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/6.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNCommentController.h"
#import "SNTopicCell.h"
#import "SNTopic.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "SNComment.h"
#import <MJExtension.h>
#import "SNCommentHeader.h"
#import "SNCommentCell.h"
static NSString * const SNCommentID = @"comment";

@interface SNCommentController ()<UITableViewDelegate, UITableViewDataSource>
/** 工具条底部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic,strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic,strong) NSMutableArray *latestComments;

/** 保存帖子的top_cmt */
@property (nonatomic,strong) SNComment *saved_top_cmt;

/** 管理者 */
@property (nonatomic,strong) AFHTTPSessionManager *manager;

/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation SNCommentController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    


//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
  self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
//    self.tableView.mj_footer.hidden = YES;
//    self.tableView.hidden = YES;
}

- (void)loadMoreComments
{
    //  结束之前所有的网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //页码
    NSInteger page = self.page + 1;
    
    //  参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    SNComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *newComments = [SNComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        
        //页码
        self.page = page;
        
        //刷新数据
        [self.tableView reloadData];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {  //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }else
        {
            //结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadNewComments
{
    // 结束之前所有的网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 最热评论
        self.hotComments = [SNComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.latestComments = [SNComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 页码
        self.page = 1;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)tvReload
{
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)setupHeader
{
    //  床架header
    UIView *header = [[UIView alloc] init];
    
    // 清空top_cmt
    //  这里用的cell是以前的cell要重新计算cell的高度
    //  重新计算的cell高度不包含热门评论的高度，如果用到的cell里有热门评论，就要把热门评论清除，重新计算高度
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    //  添加cell
    SNTopicCell *cell = [SNTopicCell cell];
    cell.topic = self.topic;
    //  重新计算cell的高度
    cell.size = CGSizeMake(SNScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    //  header的高度
    header.height = self.topic.cellHeight + SNTopicCellMargin;
    
    self.tableView.tableHeaderView = header;
}

- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //cell的高度
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 背景色
    self.tableView.backgroundColor = SNGlobalBg;
    
    //  注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SNCommentCell class]) bundle:nil] forCellReuseIdentifier:SNCommentID];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SNTopicCellMargin, 0);
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //  修改底部约束
    self.bottomSpace.constant = SNScreenH - frame.origin.y;
    //  动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //  动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 在控制器消失之前调用,需要移除观察者，不然它会一直活着造成内存溢出
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //  需要重新计算一遍高度，所以要将之前存下来的帖子附回去
    //恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    //  取消所有的网络请求任务  以免用户结束操作依旧有网络请求发回访问空地址
    [self.manager invalidateSessionCancelingTasks:YES];
}

/** 返回第section组的所有评论数组 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (SNComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    //  非第0组
    return latestCount;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.hotComments.count ? 2 : 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 先从缓存池中找header
    SNCommentHeader *header = [SNCommentHeader headerViewWithTableView:tableView];
    
    // 设置label的数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:SNCommentID];
    
    cell.comment = [self commentInIndexPath:indexPath];
    
    return cell;
}

@end
