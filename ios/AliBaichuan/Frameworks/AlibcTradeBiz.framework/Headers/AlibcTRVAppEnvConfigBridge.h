/*
 * AlibcTRVAppEnvConfigBridge.h 
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
#import <UIKit/UIKit.h>

#ifndef AlibcTRVAppEnvConfigBridge_h
#define AlibcTRVAppEnvConfigBridge_h

@interface AlibcTRVAppEnvConfigBridge : NSObject

/**
 *
 * 三方appName appVersion
 *
 */
@property(nonatomic,copy)NSString * _Nonnull appName;
@property(nonatomic,copy)NSString * _Nonnull appVersion;
@property(nonatomic,copy)NSString * _Nonnull hostEnv;

/**
 是否开启小程序调试模式
 */
@property(nonatomic,assign)BOOL isAppDebugMode;


+ (nonnull instancetype)sharedInstance;

/**
 trvAppEnvConfig是否可用
 */
+(BOOL)isAppEnvConfigAvaleable;


@end
#endif
