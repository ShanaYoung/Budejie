//
//  SNTopicViewController.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/27.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNTopicViewController : UITableViewController

/** 帖子类型（交给子类去实现） */
@property (nonatomic, assign) SNTopicType type;
@end
