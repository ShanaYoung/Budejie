//
//  SNCommentHeader.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/6.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNCommentHeader.h"

@interface SNCommentHeader ()
/** 文字标签 */
@property (nonatomic,weak) UILabel *label;
@end

@implementation SNCommentHeader

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    SNCommentHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[SNCommentHeader alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = SNGlobalBg;
        
        //创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = SNRGBColor(67, 67, 67);
        label.width = 200;
        label.x = SNTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}

@end
