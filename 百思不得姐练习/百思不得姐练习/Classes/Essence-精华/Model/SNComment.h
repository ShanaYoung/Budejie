//
//  SNComment.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/6.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNUser;

@interface SNComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频评论的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户模型 */
@property(strong,nonatomic)SNUser *user;


@end
