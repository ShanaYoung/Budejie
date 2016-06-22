//
//  SNRecommendUserCell.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNRecommendUserCell.h"
#import "SNRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface SNRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation SNRecommendUserCell

-(void)setUser:(SNRecommendUser *)user
{
    _user=user;
    self.screenNameLabel.text=user.screen_name;
    NSString *fansCount=nil;
    if (user.fans_count<10000) {
        fansCount=[NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }
    else
    {
        //大于等于10000
        fansCount=[NSString stringWithFormat:@"%.1f万人关注",user.fans_count/10000.0];
    }
    
    self.fansCountLabel.text=fansCount;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
