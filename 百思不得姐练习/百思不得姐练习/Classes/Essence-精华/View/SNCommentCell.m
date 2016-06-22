//
//  SNCommentCell.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/6.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNCommentCell.h"
#import "SNComment.h"
#import <UIImageView+WebCache.h>
#import "SNUser.h"

@interface SNCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation SNCommentCell

- (void)setComment:(SNComment *)comment
{
    _comment = comment;
    
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        image = [image circleImage];
//        self.profileImageView.image = image;
//    }];
    [self.profileImageView setHeader:comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:SNUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd ''", comment.voicetime] forState:UIControlStateNormal];
    }else
    {
        self.voiceButton.hidden = YES;
    }
}

@end
