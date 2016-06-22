//
//  SNCommentHeader.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/6.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNCommentHeader : UITableViewHeaderFooterView

/** 文字数据 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
