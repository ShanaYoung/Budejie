//
//  UIImageView+SNExtention.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/16.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "UIImageView+SNExtention.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (SNExtention)

- (void)setHeader:(NSString *)url
{
    // 先设置好占位图片，并把占位图片设置为圆角，如果加载的图片为空，则将占位图片设置上去
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //判断图片是否为空，若为空，则将默认的占位图片设置为显示的头像
        self.image = image ? [image circleImage] : placeholder;
    }];
}

@end
