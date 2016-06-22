//
//  SNTopicCell.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/26.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNTopic;

@interface SNTopicCell : UITableViewCell

/** 帖子数据 */
@property(strong,nonatomic)SNTopic *topic;

+ (instancetype)cell;

@end
