//
//  FlutterAlibcHandle.m
//  flutter_alibc
//
//  Created by 吴兴 on 2019/8/28.
//

#import "FlutterAlibcHandle.h"
#import "FlutterAlibcTools.h"
#import "FlutterAlibcConstKey.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/ALBBSDK.h>
#import "ALiTradeWebViewController.h"
#import "FlutterWxViewCtrlViewController.h"

@implementation FlutterAlibcHandle
FlutterMethodChannel *_flutterAlibcChannel = nil;


- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar methodChannel:(FlutterMethodChannel *)flutterMethodChannel {
    self = [super init];
    if (self) {
        _flutterAlibcChannel = flutterMethodChannel;
    }
    return self;
}

#pragma mark- 对flutter暴露的方法
#pragma mark -- 初始化阿里百川
- (void)initAlibc:(FlutterMethodCall *)call result:(FlutterResult)result {
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    NSString *version = call.arguments[@"version"];
    NSString *appName = call.arguments[@"appName"];
//    判断是否为空
    if(![FlutterAlibcTools isNil:version]){
        [[AlibcTradeSDK sharedInstance] setIsvVersion:version]; //设置三方App版本,可用于标识App版本
    }
    if(![FlutterAlibcTools isNil:appName]){
        [[AlibcTradeSDK sharedInstance] setIsvAppName:appName]; //设置三方App名称,可用于标识App
    }
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];//开发阶段打开日志开关，方便排查错误信息
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];//线上环境
    
    
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        //        告诉flutter，初始化完成
        result(@{FlutterAlibcConstKey_ErrorCode:@"0",FlutterAlibcConstKey_ErrorMessage:@"success"});
    } failure:^(NSError *error) {
        //        NSLog(@"Init failed: %@", error.description);
        result(@{FlutterAlibcConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", (long)error.code],FlutterAlibcConstKey_ErrorMessage:error.description});
    }];
}
#pragma mark --淘宝登录
- (void)loginTaoBao:(FlutterMethodCall *)call result:(FlutterResult)result{
    if(![[ALBBSession sharedInstance] isLogin]){
        [[ALBBSDK sharedInstance]setAuthOption: NormalAuth];
        //    根视图
        UIViewController *rootViewController =
        [UIApplication sharedApplication].delegate.window.rootViewController;
        [[ALBBSDK sharedInstance] auth:rootViewController successCallback:^(ALBBSession *session) {
            ALBBUser *userInfo = [session getUser];
            //            登录成功
            result(@{
                     FlutterAlibcConstKey_ErrorCode:@"0",
                     FlutterAlibcConstKey_ErrorMessage:@"success",
                     FlutterAlibcConstKey_Data:@{
                             //                             昵称
                             @"nick":userInfo.nick,
                             //                             头像地址
                             @"avatarUrl":userInfo.avatarUrl,
                             @"openId":userInfo.openId,
                             @"openSid":userInfo.openSid,
                             @"topAccessToken":userInfo.topAccessToken,
                             @"topAuthCode":userInfo.topAuthCode,
                             }
                     });
        } failureCallback:^(ALBBSession *session, NSError *error) {
            //            登录失败
            result(@{
                     FlutterAlibcConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", (long)error.code],
                     FlutterAlibcConstKey_ErrorMessage:error.localizedDescription,
                     FlutterAlibcConstKey_Data:@{}
                     });
        }];
    }else{
        ALBBSession *session=[ALBBSession sharedInstance];
        ALBBUser *userInfo = [session getUser];
        //            登录成功
        result(@{
                 FlutterAlibcConstKey_ErrorCode:@"0",
                 FlutterAlibcConstKey_ErrorMessage:@"success",
                 FlutterAlibcConstKey_Data:@{
                         //                             昵称
                         @"nick":userInfo.nick,
                         //                             头像地址
                         @"avatarUrl":userInfo.avatarUrl,
                         @"openId":userInfo.openId,
                         @"openSid":userInfo.openSid,
                         @"topAccessToken":userInfo.topAccessToken,
                         @"topAuthCode":userInfo.topAuthCode,
                         }
                 });
    }
}
//
//else if([@"useAlipayNative" isEqualToString:call.method]){
//    [_handler useAlipayNative:call result:result];
//}
#pragma mark --淘客登录
-(void)taoKeLogin:(FlutterMethodCall *)call result:(FlutterResult)result{
    //    需要获取的数据
    NSNumber *type1 = call.arguments[@"openType"];
    AlibcOpenType openType = [self openType:[type1 intValue]];
    BOOL isNeedCustomNativeFailMode = [call.arguments[@"isNeedCustomNativeFailMode"] boolValue];
    //    不用push了，没有nav，默认都present
    //    BOOL isNeedPush = [call.arguments[@"isNeedPush"] boolValue];
    BOOL isNeedPush = YES;
    NSNumber *failMode = call.arguments[@"nativeFailMode"];
    AlibcNativeFailMode nativeFailMode = [self NativeFailMode:[failMode intValue]];
    NSNumber *schemeType = call.arguments[@"schemeType"];
    NSString *linkKey = [self schemeType:[schemeType intValue]];
    NSString *url = call.arguments[@"url"];
    AlibcTradeTaokeParams *taokeParam = [self getTaokeParams:call];
    NSDictionary *trackParam = call.arguments[@"trackParam"];
    NSString *backUrl = [FlutterAlibcTools changeType:call.arguments[@"backUrl"]];
    //    NSString *backUrl = [FlutterAlibcTools nullToNil:call.arguments[@"backUrl"]];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = openType;
    showParam.isNeedCustomNativeFailMode = isNeedCustomNativeFailMode;
    showParam.isNeedPush=isNeedPush;
    showParam.nativeFailMode=nativeFailMode;
    showParam.linkKey=linkKey;
    showParam.backUrl= backUrl;
    
    ALiTradeWebViewController* webviewVC = [[ALiTradeWebViewController alloc] init];
    
    NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService
     openByUrl:url
     identity:@"trade"
     webView:webviewVC.webView
     parentController:rootViewController
     showParams:showParam
     taoKeParams:taokeParam
     trackParam:trackParam tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable alibcTradeResult) {
//        //            交易成功，判断是付款成功还是加入购物车
//        if(alibcTradeResult.result == AlibcTradeResultTypePaySuccess){
//            //                付款成功
//            result(@{
//                FlutterAlibcConstKey_ErrorCode:@"0",
//                FlutterAlibcConstKey_ErrorMessage:@"付款成功",
//                FlutterAlibcConstKey_Data:@{
//                        @"type":@0,
//                        @"paySuccessOrders":[alibcTradeResult payResult].paySuccessOrders,
//                        @"payFailedOrders":[alibcTradeResult payResult].payFailedOrders,
//                }
//            });
//        }else if(alibcTradeResult.result== AlibcTradeResultTypeAddCard){
//            //                加入购物车
//            result(@{
//                FlutterAlibcConstKey_ErrorCode:@"0",
//                FlutterAlibcConstKey_ErrorMessage:@"加入购物车成功",
//                FlutterAlibcConstKey_Data:@{
//                        @"type":@1,
//                }
//            });
//        }
    } tradeProcessFailedCallback:^(NSError * _Nullable error) {
//        result(@{
//            FlutterAlibcConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", (long)error.code],
//            FlutterAlibcConstKey_ErrorMessage:[error localizedDescription],
//        });
    }];
    
    if (res == 1) {
        //        新建一个view
        FlutterWxViewCtrlViewController *WxVC = [[FlutterWxViewCtrlViewController alloc] init];
        WxVC.vc = webviewVC;
        WxVC.accessBlock = ^(NSString * accessToken){
            NSLog(@"accessToken = %@",accessToken);
            if (accessToken) {
                result(@{
                    @"accessToken":accessToken
                });
            }else{
                result(@{
                    @"accessToken":@""
                });
            }
            
        };
        UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:WxVC];
        [rootViewController presentViewController:root animated:NO completion:^{
            
        }];
    }
}
#pragma mark --退出登录
- (void)loginOut{
    [[ALBBSDK sharedInstance] logout];
}
#pragma mark --通过url打开,包括h5，唤起手淘等
- (void)openByUrl:(FlutterMethodCall *)call result:(FlutterResult)result{
//    需要获取的数据
    NSNumber *type1 = call.arguments[@"openType"];
    AlibcOpenType openType = [self openType:[type1 intValue]];
    BOOL isNeedCustomNativeFailMode = [call.arguments[@"isNeedCustomNativeFailMode"] boolValue];
    //    不用push了，没有nav，默认都present
    //    BOOL isNeedPush = [call.arguments[@"isNeedPush"] boolValue];
    BOOL isNeedPush = NO;
    NSNumber *failMode = call.arguments[@"nativeFailMode"];
    AlibcNativeFailMode nativeFailMode = [self NativeFailMode:[failMode intValue]];
    NSNumber *schemeType = call.arguments[@"schemeType"];
    NSString *linkKey = [self schemeType:[schemeType intValue]];
    NSString *url = call.arguments[@"url"];
    AlibcTradeTaokeParams *taokeParam = [self getTaokeParams:call];
    NSDictionary *trackParam = call.arguments[@"trackParam"];
    NSString *backUrl = [FlutterAlibcTools changeType:call.arguments[@"backUrl"]];
//    NSString *backUrl = [FlutterAlibcTools nullToNil:call.arguments[@"backUrl"]];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = openType;
    showParam.isNeedCustomNativeFailMode = isNeedCustomNativeFailMode;
    showParam.isNeedPush=isNeedPush;
    showParam.nativeFailMode=nativeFailMode;
    showParam.linkKey=linkKey;
    showParam.backUrl= backUrl;
    [[AlibcTradeSDK sharedInstance].tradeService openByUrl:url identity:@"trade" webView:nil parentController:rootViewController showParams:showParam taoKeParams:taokeParam trackParam:trackParam tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable alibcTradeResult) {
        //            交易成功，判断是付款成功还是加入购物车
        if(alibcTradeResult.result == AlibcTradeResultTypePaySuccess){
            //                付款成功
            result(@{
                       FlutterAlibcConstKey_ErrorCode:@"0",
                       FlutterAlibcConstKey_ErrorMessage:@"付款成功",
                       FlutterAlibcConstKey_Data:@{
                               @"type":@0,
                               @"paySuccessOrders":[alibcTradeResult payResult].paySuccessOrders,
                               @"payFailedOrders":[alibcTradeResult payResult].payFailedOrders,
                               }
                       });
        }else if(alibcTradeResult.result== AlibcTradeResultTypeAddCard){
            //                加入购物车
            result(@{
                       FlutterAlibcConstKey_ErrorCode:@"0",
                       FlutterAlibcConstKey_ErrorMessage:@"加入购物车成功",
                       FlutterAlibcConstKey_Data:@{
                               @"type":@1,
                               }
                       });
        }
    } tradeProcessFailedCallback:^(NSError * _Nullable error) {
        result(@{
                   FlutterAlibcConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", (long)error.code],
                   FlutterAlibcConstKey_ErrorMessage:[error localizedDescription],
//                   android没有，直接去掉
//                   FlutterAlibcConstKey_Data:@{
//                           @"orderIdList":[[error userInfo] objectForKey:@"orderIdList"],
//                           }
                   });
    }];
}
#pragma mark --打开商品详情
- (void)openItemDetail:(FlutterMethodCall *)call result:(FlutterResult)result{
    NSString *itemID = call.arguments[@"itemID"];
    id<AlibcTradePage> page = [AlibcTradePageFactory itemDetailPage:itemID];
    [self OpenPageByNewWay:page BizCode:@"detail" Call:call callback:result];
}
#pragma mark --打开店铺
- (void)openShop:(FlutterMethodCall *)call result:(FlutterResult)result{
    NSString *shopId = call.arguments[@"shopId"];
    id<AlibcTradePage> page = [AlibcTradePageFactory shopPage:shopId];
    [self OpenPageByNewWay:page BizCode:@"shop" Call:call callback:result];
}
#pragma mark --打开我的购物车
- (void)openCart:(FlutterMethodCall *)call result:(FlutterResult)result{
    id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
    [self OpenPageByNewWay:page BizCode:@"cart" Call:call callback:result];
}

#pragma mark --淘客打点
- (void)syncForTaoke:(FlutterMethodCall *)call result:(FlutterResult)result{
    BOOL isSync = [call.arguments[@"isSync"] boolValue];
    [[AlibcTradeSDK sharedInstance] setIsSyncForTaoke:isSync];
}
#pragma mark --设置是否需要 Native AliPay 接口
- (void)useAlipayNative:(FlutterMethodCall *)call result:(FlutterResult)result{
    BOOL isNeed = [call.arguments[@"isNeed"] boolValue];
    [[AlibcTradeSDK sharedInstance] setShouldUseAlizfNative:isNeed];
}
#pragma mark - 不对flutter暴露
#pragma mark --打开page
- (void)OpenPageByNewWay:(id<AlibcTradePage>)page BizCode:(NSString *)bizCode Call:(FlutterMethodCall *)call callback:(FlutterResult)callback{
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    NSNumber *type1 = call.arguments[@"openType"];
    AlibcOpenType openType = [self openType:[type1 intValue]];
    BOOL isNeedCustomNativeFailMode = [call.arguments[@"isNeedCustomNativeFailMode"] boolValue];
//    不用push了，没有nav，默认都present
//    BOOL isNeedPush = [call.arguments[@"isNeedPush"] boolValue];
    BOOL isNeedPush = NO;
//    不用绑定了，默认为没有，有的话flutter太难搞了
//    BOOL isBindWebview = [call.arguments[@"isBindWebview"] boolValue];
    NSNumber *failMode = call.arguments[@"nativeFailMode"];
    AlibcNativeFailMode nativeFailMode = [self NativeFailMode:[failMode intValue]];
    NSNumber *schemeType = call.arguments[@"schemeType"];
    NSString *linkKey = [self schemeType:[schemeType intValue]];
    AlibcTradeTaokeParams *taokeParam = [self getTaokeParams:call];
    NSDictionary *trackParam = [FlutterAlibcTools nullToNil:call.arguments[@"trackParam"]];
    
    NSString *backUrl = [FlutterAlibcTools changeType:call.arguments[@"backUrl"]];
//    判断
    
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    showParam.openType = openType;
    showParam.isNeedPush = isNeedPush;
    showParam.nativeFailMode = nativeFailMode;
    showParam.isNeedCustomNativeFailMode = isNeedCustomNativeFailMode;
    showParam.linkKey = linkKey;
    showParam.backUrl = backUrl;
    
    
//    if (isBindWebview) {
//        ALiTradeWebViewController *viewCtrl = [[ALiTradeWebViewController alloc]init];
//         NSInteger res  =  [[AlibcTradeSDK sharedInstance].tradeService openByBizCode:bizCode page:page webView:view.webView parentController:view showParams:showParam taoKeParams:[self taokeParam] trackParam:[self customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFaelseiledCallback:self.onTradeFailure];
    //    }else{
//    if (isNeedPush) {
//        [[AlibcTradeSDK sharedInstance].tradeService openByBizCode:bizCode page:page webView:nil parentController:rootViewController showParams:showParam taoKeParams:taokeParam trackParam:trackParam tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
////            交易成功，判断是付款成功还是加入购物车
//            if(result.result == AlibcTradeResultTypePaySuccess){
////                付款成功
//                callback(@{
//                           FlutterAlibcConstKey_ErrorCode:@"0",
//                           FlutterAlibcConstKey_ErrorMessage:@"付款成功",
//                           FlutterAlibcConstKey_Data:@{
//                                   @"type":@0,
//                                   @"paySuccessOrders":[result payResult].paySuccessOrders,
//                                   @"payFailedOrders":[result payResult].payFailedOrders,
//                                   }
//                           });
//            }else if(result.result== AlibcTradeResultTypeAddCard){
////                加入购物车
//                callback(@{
//                           FlutterAlibcConstKey_ErrorCode:@"0",
//                           FlutterAlibcConstKey_ErrorMessage:@"付款成功",
//                           FlutterAlibcConstKey_Data:@{
//                                   @"type":@1,
//                                   }
//                           });
//            }
//        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
////            退出交易流程
//            callback(@{
//                       FlutterAlibcConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", (long)error.code],
//                       FlutterAlibcConstKey_ErrorMessage:[error localizedDescription],
//                       FlutterAlibcConstKey_Data:@{
//                               @"orderIdList":[[error userInfo] objectForKey:@"orderIdList"],
//                               }
//                       });
//        }];
//    }else{
        [[AlibcTradeSDK sharedInstance].tradeService openByBizCode:bizCode page:page webView:nil parentController:rootViewController showParams:showParam taoKeParams:taokeParam trackParam:trackParam tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
            //            交易成功，判断是付款成功还是加入购物车
            if(result.result == AlibcTradeResultTypePaySuccess){
                //                付款成功
                callback(@{
                           FlutterAlibcConstKey_ErrorCode:@"0",
                           FlutterAlibcConstKey_ErrorMessage:@"付款成功",
                           FlutterAlibcConstKey_Data:@{
                                   @"type":@0,
                                   @"paySuccessOrders":[result payResult].paySuccessOrders,
                                   @"payFailedOrders":[result payResult].payFailedOrders,
                                   }
                           });
            }else if(result.result== AlibcTradeResultTypeAddCard){
                //                加入购物车
                callback(@{
                           FlutterAlibcConstKey_ErrorCode:@"0",
                           FlutterAlibcConstKey_ErrorMessage:@"加入购物车成功",
                           FlutterAlibcConstKey_Data:@{
                                   @"type":@1,
                                   }
                           });
            }
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
            //            退出交易流程
            callback(@{
                       FlutterAlibcConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", (long)error.code],
                       FlutterAlibcConstKey_ErrorMessage:[error localizedDescription],
//                       Android没有，所以去掉
//                       FlutterAlibcConstKey_Data:@{
//                               @"orderIdList":[[error userInfo] objectForKey:@"orderIdList"],
//                               }
                       });
        }];
//    }
    //}
}
#pragma mark --设置淘客参数
- (AlibcTradeTaokeParams *)getTaokeParams:(FlutterMethodCall *)call{
    AlibcTradeTaokeParams *taoke = [[AlibcTradeTaokeParams alloc] init];
    if (call.arguments[@"taoKeParams"] == nil || [call.arguments[@"taoKeParams"] isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSDictionary *taoKeParams = call.arguments[@"taoKeParams"];
    taoke.adzoneId = (taoKeParams[@"adzoneId"] == (id) [NSNull null]) ? nil : taoKeParams[@"adzoneId"];
    taoke.pid = (taoKeParams[@"pid"] == (id) [NSNull null]) ? nil : taoKeParams[@"pid"];
    //有adzoneId则pid失效
    taoke.unionId = (taoKeParams[@"unionId"] == (id) [NSNull null]) ? nil : taoKeParams[@"unionId"];
    taoke.subPid = (taoKeParams[@"subPid"] == (id) [NSNull null]) ? nil : taoKeParams[@"subPid"];
//    必须是dic
    taoke.extParams = (taoKeParams[@"extParams"] == (id) [NSNull null]) ? nil : taoKeParams[@"extParams"];

//    判断这玩意是什么格式，dic就直接赋值，jsoÏn需要转dic
//    if ([extParams isKindOfClass:[NSDictionary class]]) {
//        taoke.extParams = extParams;
//    }else{
//        解析字符串
//        taoke.extParams = [FlutterAlibcTools dictionaryWithJsonString:extParams];
//    }

    return taoke;
}
#pragma mark - 转换
#pragma mark --唤起端失败的策略转换
-(AlibcNativeFailMode )NativeFailMode:(int)mode{
    AlibcNativeFailMode openType=AlibcNativeFailModeJumpH5;
    switch (mode) {
        case 0:
            openType=AlibcNativeFailModeJumpH5;
            break;
        case 1:
            openType=AlibcNativeFailModeJumpDownloadPage;
            break;
        case 2:
            openType=AlibcNativeFailModeNone;
            break;
        default:
            break;
    }
    return openType;
    
}
//唤起类型
- (AlibcOpenType)openType:(int)mode{
    
    AlibcOpenType openType=AlibcOpenTypeAuto;
    switch (mode) {
        case 0:
            openType=AlibcOpenTypeAuto;
            break;
        case 1:
            openType=AlibcOpenTypeNative;
            break;
        default:
            break;
    }
    return openType;
}

//打开类型
-(NSString*)schemeType:(int)mode{
    NSString *linkKey=@"tmall";
    switch (mode) {
        case 0:
            linkKey=@"tmall";
            break;
        case 1:
            linkKey=@"taobao";
            break;
        default:
            break;
    }
    return linkKey;
}












/**
 可设置的参数
 1.是否同步淘客打点
 2.是否使用Native支付宝
 3.是否使用淘客参数（是，需要设置如下参数）
     adzoneId
     pid
     //有adzoneId则pid失效
     unionId
     subPid
     extParams{
         sellerId
         taokeAppkey
     }
 4.页面打开方式
     是否唤端 Auto/Native
     唤起目标应用 淘宝/天猫
     是否以push的方式打开页面
     是否绑定webview
     是否自定义唤端失败策略（若是：H5，DownLoad，None）
 5.跟踪参数 customParams自定义
 */
@end
