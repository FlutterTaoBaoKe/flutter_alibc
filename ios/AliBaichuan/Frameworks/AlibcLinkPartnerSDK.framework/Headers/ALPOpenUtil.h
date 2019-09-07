//
//  ALPOpenUtil.h
//  ALPLinkPartnerSDK
//
//  Created by czp on 16/9/22.
//  Copyright © 2016年 czp. All rights reserved.
//

#import "ALPJumpParam.h"
#import <UIKit/UIKit.h>

__attribute__((deprecated("ALPOpenUtil已过期, 不再使用")))

@interface ALPOpenUtil : NSObject

/**
 *  把dictionary转为json
 *
 */
+ (NSString *)pareseToJSONWithDictionary:(NSDictionary *)dictionary;


+ (NSString *)encodeALLWithURL:(NSString *)url;

/**
 *  Dictionary转query
 *
 *  @param dic 字典
 *
 *  @return query字符串
 */
+ (NSString *)queryStringFromDictionary:(NSDictionary *)dic;

/**
 *  md5加密算法,传入待加密string
 */
+ (NSString *)encodeToMD5:(NSString *)string;

/**
 * urldecode
 */
+ (NSString *)urlDecoded:(NSString *)string;

/*
 * 转换为base64字符串
 */
+ (NSString *)base64EncodedWithString:(NSString*)str;

@end
