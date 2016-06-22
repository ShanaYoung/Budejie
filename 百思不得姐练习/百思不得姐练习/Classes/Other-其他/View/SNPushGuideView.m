//
//  SNPushGuideView.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/5/21.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNPushGuideView.h"

@implementation SNPushGuideView

+(void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    //获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获得沙盒中存储的版本号
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sandboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        SNPushGuideView *guideView = [SNPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        
        //让这里面立即同步更新内容，不然系统不知道会等到什么时候才会更新你存进去的版本号
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}


@end
