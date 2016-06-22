//
//  NSDate+SNExtention.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/26.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SNExtention)

/**
 * 比较from和self的差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

/**
 * 是否为今天
 */
- (BOOL)isToday;

@end
