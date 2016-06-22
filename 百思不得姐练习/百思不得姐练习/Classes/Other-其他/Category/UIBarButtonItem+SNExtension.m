//
//  UIBarButtonItem+SNExtension.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/13.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "UIBarButtonItem+SNExtension.h"

@implementation UIBarButtonItem (SNExtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size=button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
