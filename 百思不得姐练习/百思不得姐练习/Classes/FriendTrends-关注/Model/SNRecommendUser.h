//
//  SNRecommendUser.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNRecommendUser : NSObject

/** 头像 */
@property(nonatomic,copy)NSString *header;
/** 粉丝数（有多少人关注这个用户） */
@property(nonatomic,assign)NSInteger fans_count;
/** 昵称 */
@property(nonatomic,copy)NSString *screen_name;
@end
