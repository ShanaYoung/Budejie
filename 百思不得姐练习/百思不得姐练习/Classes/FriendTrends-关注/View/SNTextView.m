//
//  SNTextView.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/21.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNTextView.h"

static NSString * const SNPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation SNTextView

- (void)awakeFromNib
{
    //设置光标颜色和文字颜色一致
    self.tintColor=self.textColor;
    
    //不成为第一响应者
    [self resignFirstResponder];
}

/** 当前文本框聚焦时就会调用 */
- (BOOL)becomeFirstResponder
{
    //修改占位文字颜色
    [self setValue:self.textColor forKeyPath:SNPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/** 当前文本框失去焦点时就会调用 */
- (BOOL)resignFirstResponder
{
    //修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:SNPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}

@end
