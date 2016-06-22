//
//  SNTopic.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/26.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNComment;

@interface SNTopic : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

/** 名称 */
@property (nonatomic, copy) NSString *name;

/** 头像的URL */
@property (nonatomic, copy) NSString *profile_image;

/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;

/** 文字内容 */
@property (nonatomic, copy) NSString *text;

/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;

/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;

/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;

/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

/** 是否为新浪加V用户 */
@property (nonatomic, assign,getter=isSina_v) BOOL sina_v;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat height;

/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;

/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;

/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;

/** 帖子的类型 */
@property (nonatomic, assign) SNTopicType type;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;

/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** 最热评论 */
@property (nonatomic,strong) SNComment *top_cmt;

//cell的高度是根据内容来计算的，而所有的内容放在model层里，所以根据model层里的内容来计算高度
//同时cell的高度是通过内部来计算可得，外部不可修改，故用readonly来修饰
/** cell的高度 */
@property(nonatomic,assign,readonly)CGFloat cellHeight;
/** 图片空间的fram */
@property (nonatomic, assign,readonly) CGRect pictureF;
/** 图片是否太大 */
@property (nonatomic, assign,getter=isBigPicture) BOOL bigPicture;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;

/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoF;
@end
