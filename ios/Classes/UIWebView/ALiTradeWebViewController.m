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
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.scrollView.scrollEnabled = YES;
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return self;
}


#pragma mark -- 类单例
//+ (id)allocWithZone:(NSZone *)zone {
//  static ALiTradeWebViewController *sharedInstance = nil;
//  static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [super allocWithZone:zone];
//        sharedInstance.webView = [[UIWebView alloc]initWithFrame:sharedInstance.view.bounds];
//        sharedInstance.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        sharedInstance.webView.scrollView.scrollEnabled = YES;
//        sharedInstance.webView.delegate = sharedInstance;
//        [sharedInstance.view addSubview:sharedInstance.webView];
//    });
//  return sharedInstance;
//}

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

-(UIWebView *)getWebView{
    return  _webView;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlStr = request.URL.absoluteString;
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
    return YES;
}


@end
