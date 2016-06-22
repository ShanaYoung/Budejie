//
//  SNTopicCell.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/26.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNTopicCell.h"
#import "SNTopic.h"
#import "SNTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "SNTopicVoiceView.h"
#import "SNTopicVideoView.h"
#import "SNComment.h"
#import "SNUser.h"

@interface SNTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *prodfileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property(nonatomic,weak) SNTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property(nonatomic,weak) SNTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property(nonatomic, weak) SNTopicVideoView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *hotContentLabel;
@property (weak, nonatomic) IBOutlet UIView *hotCommentView;

@end

@implementation SNTopicCell

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (SNTopicPictureView *)pictureView
{
    if (!_pictureView) {
        SNTopicPictureView *pictureView = [SNTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (SNTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        SNTopicVoiceView *voiceView = [SNTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (SNTopicVideoView *)videoView
{
    if (!_videoView) {
        SNTopicVideoView *videoView = [SNTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setTopic:(SNTopic *)topic
{
    _topic = topic;
    
    //新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    //设置头像
//    [self.prodfileImage sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        image = [image circleImage];
//        self.prodfileImage.image = image;
//    }];
    [self.prodfileImage setHeader:topic.profile_image];
    
    //设置名字
    self.nameLabel.text = topic.name;
    
    //设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    
    //设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeHolder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeHolder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeHolder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeHolder:@"评论"];
    
    //设置帖子的文字内容
    self.text_label.text = topic.text;
    
    //根据模型类型（帖子类型）添加对应的内容到cell的中间
    if (topic.type == SNTopicTypePicture) { //图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == SNTopicTypeVoice){  //声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    }else if (topic.type == SNTopicTypeVideo){  // 视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else
    {  // 段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    // 处理最热评论
    if (topic.top_cmt) {
        self.hotCommentView.hidden = NO;
        self.hotContentLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    }else
    {
        self.hotCommentView.hidden = YES;
    }
}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeHolder:(NSString *)placeHolder
{
    if (count > 10000) {
        placeHolder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if (count > 0)
    {
        placeHolder = [NSString stringWithFormat:@"%zd",count];
    }
    
    [button setTitle:placeHolder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height = self.topic.cellHeight - SNTopicCellMargin;
    frame.origin.y += SNTopicCellMargin;
    
    [super setFrame:frame];
}

- (IBAction)more:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self.window];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
