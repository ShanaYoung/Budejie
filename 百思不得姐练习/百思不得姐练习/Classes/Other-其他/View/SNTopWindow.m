//
//  SNTopWindow.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/11.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNTopWindow.h"

@implementation SNTopWindow

//  为保该窗口不死
static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, SNScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show
{
    window_.hidden = NO;
}

/** 监听窗口点击 */
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superView
{
    for (UIScrollView *subview in superView.subviews) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        //继续查找子控件
        [self searchScrollViewInView:subview];
    }
}


@end
