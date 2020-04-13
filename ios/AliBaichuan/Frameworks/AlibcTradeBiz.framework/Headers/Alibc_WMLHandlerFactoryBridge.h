/*
 * Alibc_WMLHandlerFactoryBridge.h 
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

#ifndef Alibc_WMLHandlerFactoryBridge_h
#define Alibc_WMLHandlerFactoryBridge_h

@interface Alibc_WMLHandlerFactoryBridge : NSObject

/**
 判断该类是否可用
 */
+ (BOOL)isAvaiable;

/**
 注册指定的 Handler。
 */
+ (void)registerHandler:(id _Nonnull)handler withProtocol:(Protocol * _Nonnull)protocol;

/**
 移除指定 Protocol 的 Handler。
 */
+ (void)unregisterHandlerWithProtocol:(Protocol * _Nonnull)protocol;

@end

#endif
