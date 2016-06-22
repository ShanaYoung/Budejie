//
//  UIImageView+SNExtention.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/16.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SNExtention)

/**
 * 把设置头像的方法单独封装起来是因为方便后期维护修改
 * 因为项目中有多个地方需要修改头像，如果项目有变更就需要进行多次修改
 * 如果封装起来，只用修改一处，则都会改变
 */

/** 设置头像 */
- (void)setHeader:(NSString *)url;

@end
