//
//  SNRecommendTag.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/19.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNRecommendTag : NSObject

/** 图片 */
@property(nonatomic,copy)NSString *image_list;

/** 名字 */
@property(nonatomic,copy)NSString *theme_name;

/** 订阅数 */
@property(nonatomic,assign)NSInteger sub_number;
@end
