/*
 * AlibcContextData.h 
 *
 * 阿里百川电商
 * 项目名称：阿里巴巴电商 AlibcTradeBiz 
 * 版本号：4.0.0.8
 * 发布时间：2019-11-11
 * 开发团队：阿里巴巴百川团队
 * 阿里巴巴电商SDK答疑群号：1488705339  2071154343(阿里旺旺)
 * Copyright (c) 2016-2020 阿里巴巴-淘宝-百川. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "AlibcTradeShowParams.h"
#import "AlibcTradeResult.h"
//#import <AlibcTradeBiz/AlibcTradeTaokeParams.h>
#import "AlibcTradeSDKDefines.h"

@interface AlibcContextData : NSObject
//show接口的上下文参数
@property(strong, nonatomic, nullable) AlibcTradeShowParams *showParams;
@property(strong, nonatomic, nullable) NSDictionary *param;  //解析后page中的param,不是原始trackParam
@property(strong, nonatomic, nullable) AlibcTradeTaokeParams *taokeParam;  //淘客信息


#pragma mark trade
@property(nonatomic, strong, nullable) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property(nonatomic, copy, nullable) AlibcTradeProcessFailedCallback onTradeFailure;


//辅助函数
- (BOOL)isForceH5; //是否整个链路强制用h5打开

@end
