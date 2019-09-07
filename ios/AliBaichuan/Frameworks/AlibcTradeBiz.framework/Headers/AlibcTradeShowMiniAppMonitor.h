//
//  AlibcTradeShowMiniAppMonitor.h
//  AlibcTradeSDK
//
//  Created by shan yi on 2019/7/8.
//  Copyright © 2019 com.alibaba. All rights reserved.
//


@interface AlibcTradeShowMiniAppMonitor : AlibcTradeMonitor

/**
 时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeDimension *pageTypeDimension;

/**
 参数入参解析时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *analysisMeasure;


/**
 调用小程序容器API打开页面时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *openMiniAppMeasure;

/**
 打开小程序页面总时间的维度
 */
@property(strong, nonatomic, readonly) AlibcTradeTimeMeasure *allTimeMeasure;

@end

