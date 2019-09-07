//
//  AlibcTradeShowNativeMonitor.h
//  AlibcTradeSDK
//
//  Created by Veight Zhou on 16/12/12.
//  Copyright © 2016年 com.alibaba. All rights reserved.
//


//#import <AlibcTradeCommon/AlibcTradeCommon.h>

@interface AlibcTradeShowNativeMonitor : AlibcTradeMonitor

/**
 URL 加载时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeDimension *pageTypeDimension;

/**
 URL 加载时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *analysisMeasure;


/**
 打开页面总时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *goTaobaoMeasure;

/**
 打开页面总时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *allTimeMeasure;

@end
