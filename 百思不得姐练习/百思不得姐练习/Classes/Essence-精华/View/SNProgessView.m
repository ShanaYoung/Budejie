//
//  SNProgessView.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/1.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNProgessView.h"

@implementation SNProgessView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    
    //不替代负号会有一堆负数显示在下载进程中
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
