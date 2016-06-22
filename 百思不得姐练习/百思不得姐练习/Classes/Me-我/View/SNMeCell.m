//
//  SNMeCell.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/16.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNMeCell.h"

@implementation SNMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //  cell右边的小箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    //  调整cell内部的imageView与label
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.imageView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + SNTopicCellMargin;
}

@end
