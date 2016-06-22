//
//  SNTopicVideoView.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/4.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNTopic;

@interface SNTopicVideoView : UIView

+ (instancetype)videoView;

/** 帖子数据  */
@property(strong,nonatomic)SNTopic *topic;


@end
