//
//  SNVerticalButton.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/20.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNVerticalButton.h"

@implementation SNVerticalButton

-(void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
