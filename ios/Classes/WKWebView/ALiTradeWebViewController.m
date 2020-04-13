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
//        _webView.navigationDelegate = self;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
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
-(void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void*)context{
    
    NSLog(@"url == %@",_webView.URL.absoluteString);
    NSString *urlStr = _webView.URL.absoluteString;
    NSRange range;
    range = [urlStr rangeOfString:@"access_token"];
    if (range.location != NSNotFound) {
        NSString *accessString = [urlStr substringFromIndex:range.location];
        //        截止到&
        NSRange range2 = [accessString rangeOfString: @"&"];
        
        NSString *access_token_string = [accessString substringWithRange:NSMakeRange(0,range2.location)];
        NSArray *array = [access_token_string componentsSeparatedByString:@"="];
        NSString *access_token = array[1];
        NSLog(@"%@",access_token);
        //        跳转回去
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getAccessToken" object:access_token];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"Not Found");
    }
}

-(void)dealloc
{
    NSLog(@"dealloc  view");
    [_webView removeObserver:self forKeyPath:@"URL"];
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
//    重定向
    decisionHandler(WKNavigationActionPolicyAllow);
}
@end
