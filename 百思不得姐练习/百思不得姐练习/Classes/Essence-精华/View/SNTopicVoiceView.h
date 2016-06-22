//
//  SNTopicVoiceView.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/2.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNTopic;
@interface SNTopicVoiceView : UIView

+ (instancetype)voiceView;

/** 帖子数据 */
@property(strong,nonatomic)SNTopic *topic;


@end
