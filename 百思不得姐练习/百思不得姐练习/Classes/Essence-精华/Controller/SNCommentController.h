//
//  SNCommentController.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/6.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNTopic;

@interface SNCommentController : UIViewController

/** 帖子模型 */
@property(strong,nonatomic)SNTopic *topic;

@end
