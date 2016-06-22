//
//  SNRecomendCategory.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNRecomendCategory : NSObject

/** id */
@property(nonatomic,assign)NSInteger id;
/** 总数 */
@property(nonatomic,assign)NSInteger count;
/** 名字 */
@property(nonatomic,copy)NSString *name;

/** 这个类别对应的用书数据 */
@property(strong,nonatomic)NSMutableArray *users;
/** 总数 */
@property(nonatomic,assign)NSInteger total;
/** 当前页码 */
@property(nonatomic,assign)NSInteger currentPage;

@end
