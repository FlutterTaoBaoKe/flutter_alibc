//
//  Created by wuchen.xj on 1/28/19.
//  Copyright (c) 2019 Taobao. All rights reserved.
//


#import <Foundation/Foundation.h>


#ifdef __cplusplus
extern "C" {
#endif
    
/**
 * 日志开关函数（保持向后兼容，此函数一直保留）
 */
void openSDKSwitchLog(BOOL flag);
    
#ifdef __cplusplus
}
#endif


/**
 * MTOP日志级别
 */
typedef NS_OPTIONS(NSUInteger, TBSDKMTOPLogLevel) {
    kMTOPLogDebug       = 4,
    kMTOPLogInfo        = 3,
    kMTOPLogWarnning    = 2,
    kMTOPLogError       = 1
};


/**
 * MTOP日志打印入口
 */
@interface TBSDKLogUtil : NSObject

+ (void)log:(TBSDKMTOPLogLevel)level file:(const char *)file func:(const char *)func line:(int)line msg:(NSString *)fmt, ...;

@end

#define MTOP_LOGD(...) [TBSDKLogUtil log:kMTOPLogDebug file:__FILE__ func:__func__ line:__LINE__ msg:__VA_ARGS__];

#define MTOP_LOGI(...) [TBSDKLogUtil log:kMTOPLogInfo file:__FILE__ func:__func__ line:__LINE__ msg:__VA_ARGS__];

#define MTOP_LOGW(...) [TBSDKLogUtil log:kMTOPLogWarnning file:__FILE__ func:__func__ line:__LINE__ msg:__VA_ARGS__];

#define MTOP_LOGE(...) [TBSDKLogUtil log:kMTOPLogError file:__FILE__ func:__func__ line:__LINE__ msg:__VA_ARGS__];

