//
//  SNCommentCell.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/6.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNComment;

@interface SNCommentCell : UITableViewCell

/** 评论模型 */
@property(strong,nonatomic)SNComment *comment;

@end
