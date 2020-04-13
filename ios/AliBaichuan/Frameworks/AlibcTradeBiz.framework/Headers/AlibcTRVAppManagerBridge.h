/*
 * AlibcTRVAppManagerBridge.h 
 *
 * 阿里百川电商
 * 项目名称：阿里巴巴电商 AlibcTradeBiz 
 * 版本号：4.0.0.9
 * 发布时间：2019-10-31
 * 开发团队：阿里巴巴商家服务引擎团队
 * 阿里巴巴电商SDK答疑群号：1488705339  2071154343(阿里旺旺)
 * Copyright (c) 2016-2020 阿里巴巴-淘宝-百川. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef AlibcMiniAppBridge_h
#define AlibcMiniAppBridge_h

@interface AlibcTRVAppManagerBridge : NSObject

+ (nonnull instancetype)sharedInstance;

/**
 *
 * 百川小程序- TRVAppManager - 是否可用
 *
 */
+ (BOOL)isTRVAppManagerAvaleable;

/**
 打开小程序
 
 @param urlStr  小程序URL
 @param error   创建根ViewController发生的Error，Code码参考 “打开小程序ErrorCode”
 @param extraParams 打开附加传参
 @return        小程序根ViewController
 */
- (nullable UIViewController *)openAppWithUrl:(nullable NSString *)urlStr extraParams:(nullable NSDictionary *)extraParams error:( NSError * _Nullable *_Nullable)error;

@end
#endif //AlibcMiniAppBridge_h
