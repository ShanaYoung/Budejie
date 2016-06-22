//
//  PrefixHeader.h
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/13.
//  Copyright © 2016年 Shana. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

#import <Availability.h>

#import "UIView+SNExtention.h"
#import "SNConst.h"
#import "NSDate+SNExtention.h"
#import "UIBarButtonItem+SNExtension.h"
#import "UIImage+SNExtention.h"
#import "UIImageView+SNExtention.h"

#ifdef DEBUG
#define SNLog(...) NSLog(__VA_ARGS__)
#else
#define XMGLog(...)
#endif

#define SNLogFunc SNLog(@"%s",__func__)

#define SNRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define SNGlobalBg SNRGBColor(223,223,223)

#define SNScreenW [UIScreen mainScreen].bounds.size.width
#define SNScreenH [UIScreen mainScreen].bounds.size.height

#endif /* PrefixHeader_h */
