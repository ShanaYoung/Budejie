//
//  SNRecommendTagCell.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/19.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNRecommendTagCell.h"
#import "SNRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface SNRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;

@end

@implementation SNRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setRecommendTag:(SNRecommendTag *)recommendTag
{
    _recommendTag=recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text=recommendTag.theme_name;
    NSString *subNumber=nil;
    if (recommendTag.sub_number<10000) {
        subNumber=[NSString stringWithFormat:@"%zd万人订阅",recommendTag.sub_number];
    }
    else
    {
        //大于等于10000
        subNumber=[NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number/10000.0];
    }
    self.subNameLabel.text=subNumber;
}

//拦截设置frame的内部方法，重写该方法，实现cell的卡片效果功能
-(void)setFrame:(CGRect)frame
{
    frame.origin.x=5;
    frame.size.width-=2*frame.origin.x;
    frame.size.height-=1;
    
    [super setFrame:frame];
}

@end