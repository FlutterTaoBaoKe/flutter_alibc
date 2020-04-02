//
//  ALiTradeWantViewController.h
//  ALiSDKAPIDemo
//
//  Created by com.alibaba on 16/6/1.
//  Copyright © 2016年 alibaba. All rights reserved.
//

#ifndef ALiTradeWantViewController_h
#define ALiTradeWantViewController_h

#import <UIKit/UIKit.h>
@interface ALiTradeWebViewController : UIViewController<WKNavigationDelegate>
@property (nonatomic, copy) NSString *openUrl;
@property (strong, nonatomic) WKWebView *webView;

-(WKWebView *)getWebView;

@end

#endif /* ALiTradeWantViewController_h */
