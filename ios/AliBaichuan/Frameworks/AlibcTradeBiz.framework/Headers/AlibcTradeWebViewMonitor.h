//
//  AlibcTradeWebViewMonitor.h
//  AlibcTradeCommon
//
//  Created by Veight Zhou on 16/12/9.
//  Copyright © 2016年 xzj. All rights reserved.
//


//#import <AlibcTradeCommon/AlibcTradeCommon.h>
@import UIKit;
#import "AlibcWebViewEventListener.h"

@class AlibcTradeTimeMeasure;

@interface AlibcTradeWebViewMonitor : AlibcTradeMonitor <AlibcWebViewEventListener>

@property(strong, nonatomic, readonly) AlibcTradeDimension *pageTypeDimension;

/**
 URL 加载时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *loadTimeMeasure;

/**
 URL 加载时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *handleTimeMeasure;


/**
 打开页面总时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *allTimeMeasure;

@end



//@class AlibcTradePage;

/**
 UIWebView AlibcTradeWebViewMonitor Category
 */
@interface UIWebView (AlibcTradeWebViewMonitor)

- (void)alibc_setWebViewMonitor:(AlibcTradeWebViewMonitor *)monitor;

- (AlibcTradeWebViewMonitor *)alibc_webViewMonitor;

- (BOOL)alibc_needToCommitUsability;

- (void)alibc_setNeedToCommitUsability:(BOOL)need;

- (NSString *)alibc_loadedByPage;

- (void)alibc_setLoadedByPage:(NSString *)pageCode;

@end
