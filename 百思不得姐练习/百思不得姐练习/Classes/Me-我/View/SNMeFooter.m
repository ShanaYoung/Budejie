//
//  SNMeFooter.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/17.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNMeFooter.h"
#import <AFNetworking.h>
#import "SNSquare.h"
#import <MJExtension.h>
#import "SNSquareButton.h"
#import "SNWebViewController.h"

@implementation SNMeFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        //  参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *squares = [SNSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            //  创建方块
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
         }
    return self;
}

- (void)createSquares:(NSArray *)squares
{
    //  一行最多4列
    int maxCols = 4;
    
    //  宽度和高度
    CGFloat buttonW = SNScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i <squares.count; i++) {
        //创建按钮
        SNSquareButton *button = [SNSquareButton buttonWithType:UIButtonTypeCustom];
        
        //监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        //模型传递
        button.square = squares[i];
        [self addSubview:button];
        
        //计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row *buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    
    //  计算总行数
    //  总行数 = （总个数 + 每行最大数 - 1）/ 每行最大数
    NSUInteger rows = (squares.count + maxCols - 1) /maxCols;
    
    //计算footer的高度
    self.height = rows * buttonH;
    
    //  重绘
    [self setNeedsDisplay];
}

- (void)buttonClick:(SNSquareButton *)button
{
    if (![button.square.url hasPrefix:@"http"]) return;
    
    SNWebViewController *web = [[SNWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    //取出当前的导航控制器
    UITabBarController *tabBacC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBacC.selectedViewController;
    
    [nav pushViewController:web animated:YES];
    
}

@end
