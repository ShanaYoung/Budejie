//
//  SNTabBar.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/13.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNTabBar.h"
#import "SNPublishViewController.h"

@interface SNTabBar ()
/** 发布按钮 */
@property(nonatomic,weak)UIButton *publishButton;
@end

@implementation SNTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        //设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //添加发布按钮
        UIButton *publishButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size=publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton=publishButton;
    }
    
    return self;
}

- (void)publishClick
{
    SNPublishViewController *publish = [[SNPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:YES completion:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width=self.width;
    CGFloat height=self.height;
    
    //设置发布按钮的frame
    self.publishButton.center=CGPointMake(width*0.5, height*0.5);
    
    //设置其他UITabBarButton的frame
    CGFloat buttonY=0;
    CGFloat buttonW=width/5;
    CGFloat buttonH=height;
    CGFloat index=0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]]||button==self.publishButton) {
            continue;
        }
        
        //计算按钮的x值
        CGFloat buttonX=buttonW*((index>1)?(index+1):index);
        button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //增加索引
        index++;
    }
}

@end
