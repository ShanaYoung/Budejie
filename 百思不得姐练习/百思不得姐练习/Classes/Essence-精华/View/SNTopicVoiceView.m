//
//  SNTopicVoiceView.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/2.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNTopicVoiceView.h"
#import "SNTopic.h"
#import <UIImageView+WebCache.h>
#import "SNShowPictureViewController.h"

@interface SNTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *playTime;

@end

@implementation SNTopicVoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    SNShowPictureViewController *showPicture = [[SNShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(SNTopic *)topic
{
    _topic = topic;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    //播放次数
    self.playCount.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    
    //时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.playTime.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
