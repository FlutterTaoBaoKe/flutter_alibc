//
//  AlibcTradeShowH5Monitor.h
//  AlibcTradeSDK
//
//  Created by Veight Zhou on 16/12/12.
//  Copyright © 2016年 com.alibaba. All rights reserved.
//

#import "AlibcTradeWebViewMonitor.h"

typedef NSString *AlibcTradeShowH5TaokeTypeMeasure;

FOUNDATION_EXPORT AlibcTradeShowH5TaokeTypeMeasure AlibcTradeShowH5TaokeTypeMeasureNoTrace; // Default value
FOUNDATION_EXPORT AlibcTradeShowH5TaokeTypeMeasure AlibcTradeShowH5TaokeTypeMeasureSyncTrace;
FOUNDATION_EXPORT AlibcTradeShowH5TaokeTypeMeasure AlibcTradeShowH5TaokeTypeMeasureAsyncTrace;

@interface AlibcTradeShowH5Monitor : AlibcTradeWebViewMonitor


@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *taokeTimeMeasure;

@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *analysisTimeMeasure;

@property(strong, nonatomic, readonly) AlibcTradeDimension *taokeTypeDimension;

@end

/**
 UIWebView AlibcTradeShowH5Monitor Category
 */
@interface UIWebView (AlibcTradeShowH5Monitor)

- (void)alibc_setShowH5Monitor:(AlibcTradeShowH5Monitor *)monitor;

- (AlibcTradeShowH5Monitor *)alibc_showH5Monitor;

@end
