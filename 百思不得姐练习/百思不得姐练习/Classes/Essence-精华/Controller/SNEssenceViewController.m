//
//  SNEssenceViewController.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/13.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNEssenceViewController.h"
#import "SNRecommendTagsViewController.h"
#import "SNTopicViewController.h"

@interface SNEssenceViewController ()<UIScrollViewDelegate>

/** 标签底部的红色指示器 */
@property(nonatomic,weak)UIView *indicatorView;

/** 当前选中的按钮 */
@property(nonatomic,weak)UIButton *selectedButton;

/** 顶部的所有标签 */
@property(nonatomic,weak)UIView *titlesView;

/** 底部的所有内容 */
@property(nonatomic,weak)UIScrollView *contentView;

@end

@implementation SNEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNavigationDetails];
    
    //初始化子控制器
    [self setupChildVCs];
    
    //设置顶部的标签栏
    [self setupTitlesView];
    
    //设置滚动scrollView的内容
    [self setupContentView];
}

#pragma mark - 设置滚动内容
- (void)setupContentView
{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark - 设置顶部的标签栏
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height-indicatorView.height;
    self.indicatorView = indicatorView;
    
    //内部的子标签
//    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titlesView.width/self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i*width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        if (i==0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            //让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}

-(void)titleClick:(UIButton *)button
{
    //修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark - 初始化子控制器
- (void)setupChildVCs
{
    SNTopicViewController *word = [[SNTopicViewController alloc] init];
    word.title = @"段子";
    word.type = SNTopicTypeWord;
    [self addChildViewController:word];
    
    SNTopicViewController *all = [[SNTopicViewController alloc] init];
    all.title = @"全部";
    all.type = SNTopicTypeAll;
    [self addChildViewController:all];
    
    SNTopicViewController *picture = [[SNTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type =SNTopicTypePicture;
    [self addChildViewController:picture];
    
    SNTopicViewController *video = [[SNTopicViewController alloc] init];
    video.title = @"视频";
    video.type = SNTopicTypeVideo;
    [self addChildViewController:video];
    
    SNTopicViewController *voice = [[SNTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = SNTopicTypeVoice;
    [self addChildViewController:voice];
}

#pragma mark - 设置导航栏细节
- (void)setupNavigationDetails
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor = SNGlobalBg;
}

- (void)tagClick
{
    SNRecommendTagsViewController *tvc = [[SNRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
