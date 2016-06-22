//
//  SNRecomendCategory.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNRecomendCategory.h"

@implementation SNRecomendCategory

-(NSMutableArray *)users
{
    if (!_users) {
        _users=[NSMutableArray array];
    }
    
    return _users;
}

@end
