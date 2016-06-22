//
//  UIImage+SNExtention.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/16.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SNExtention)
/**
 * 获取圆形图片可以设置layer.cornerRadius,但是多次设置后会造成卡顿
 * 使用绘图实现圆角可以增加快流畅度
 */

/** 圆形图片 */
- (UIImage *)circleImage;

@end
