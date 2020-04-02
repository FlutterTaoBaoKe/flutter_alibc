//
//  ALiTradeWantViewController.m
//  ALiSDKAPIDemo
//
//  Created by com.alibaba on 16/6/1.
//  Copyright © 2016年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALiTradeWebViewController.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>

//#import "ALiCartService.h"

@interface ALiTradeWebViewController()

@end

@implementation ALiTradeWebViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.scrollView.scrollEnabled = YES;
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"淘你喜欢";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}
-(void)dealloc
{
    NSLog(@"dealloc  view");
    _webView =  nil;
}

-(void)setOpenUrl:(NSString *)openUrl {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:openUrl]]];
}

-(WKWebView *)getWebView{
    return  _webView;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}


@end
