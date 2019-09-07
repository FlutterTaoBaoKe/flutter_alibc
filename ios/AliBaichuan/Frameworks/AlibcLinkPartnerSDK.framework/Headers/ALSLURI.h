//
//  ALSLURI.h
//  AlibcLinkPartnerSDK
//
//  Created by 诺夏 on 2019/3/11.
//  Copyright © 2019 czp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ALSLDegradeType) {
    ALSLDegradeTypeNone = 0,   // 不做降级处理
    ALSLDegradeTypeH5,         // 降级到H5页面
    ALSLDegradeTypeDownload,   // 降级到下载页
};

NS_ASSUME_NONNULL_BEGIN

@interface ALSLURI : NSObject <NSCopying>

/**
 *  指定在目标APP内打开的落地页链接
 */
@property (nonatomic, copy) NSString * url;

/*
 *  目标App(必选)。当前已支持唤起App可参考文档说明。需要将目标App的scheme在info.plist中配置才能成功唤起。
 *  TODO: 附文档地址
 */
@property (nonatomic, copy) NSString * target;

/**
 *  降级策略，支持H5,下载页两种降级方式。默认H5
 */
@property (nonatomic, assign) ALSLDegradeType degradeType;

/**
 *  降级H5页面地址（可选）。未唤起目标App时，可指定H5降级页面（仅type = ALSLDegradeTypeH5时支持）。
 *  若未指定，传入链接作为降级页面地址返回
 */
@property (nonatomic, copy) NSString * degradeH5Url;

/**
 *  返回URL(可选,建议填充，可能有意想不到的好处)。跳转到目标App后，可以通过backUrl返回当前App
 */
@property (nonatomic, copy) NSString * backUrl;

/**
 *  模块，h5，detail，shop，auth。
 */
@property (nonatomic, copy) NSString * module;

/**
 *  额外透传参数(可选)。SDK不会做处理，会在唤端时直接透传到目标App
 */
@property (nonatomic, copy) NSDictionary * extraParam;

@end

NS_ASSUME_NONNULL_END
