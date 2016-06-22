//
//  SNNavigationController.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/13.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNNavigationController.h"

@interface SNNavigationController ()

@end

@implementation SNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(void)initialize
{
    //当导航栏用在XMGNavigationController中，appearance设置才会生效
    
    UINavigationBar *bar=[UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count>0) {//如果push进来不是第一个控制器
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        button.size=CGSizeMake(70, 30);
        
        //让按钮内部所有内容左对齐
        button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        
        //让按钮的内容往左偏移10
        button.contentEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
        
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed=YES;

    }
    
    //这句话要放在后面，让viewcontroller可以覆盖上面设置的leftbarbutton
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}

@end
