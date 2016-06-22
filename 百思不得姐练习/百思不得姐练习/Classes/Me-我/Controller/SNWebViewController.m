//
//  SNWebViewController.m
//  百思不得姐练习
//
//  Created by qianfeng on 16/6/17.
//  Copyright © 2016年 Shana. All rights reserved.
//

#import "SNWebViewController.h"
#import <NJKWebViewProgress.h>

@interface SNWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property(nonatomic,strong) NJKWebViewProgress *progress;

@end

@implementation SNWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self;
    
    //  创建block匿名函数之前一般需要对self进行weak化，否则造成循环引用无法释放controller
    __weak typeof(self) weakSelf = self;
    
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
