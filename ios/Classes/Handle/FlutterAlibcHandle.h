/*
 * @Description: 
 * @Author: wuxing
 * @Date: 2019-09-02 21:26:27
 * @LastEditors: wuxing
 * @LastEditTime: 2019-09-02 22:12:43
 */
//
//  FlutterAlibcHandle.h
//  flutter_alibc
//
//  Created by 吴兴 on 2019/8/28.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
NS_ASSUME_NONNULL_BEGIN

@interface FlutterAlibcHandle : NSObject
// 初始化

/**
 初始化

 @param call {"version","appName"}
 @param result {@"errorCode":"0",@"errorMessage":"success"}
 */
- (void)initAlibc:(FlutterMethodCall *)call result:(FlutterResult)result;

/**
 登录淘宝

 @param call <#call description#>
 @param result <#result description#>
 */
- (void)loginTaoBao:(FlutterMethodCall *)call result:(FlutterResult)result;


/**
 退出淘宝登录
 */
- (void)loginOut;


/// 淘客登录，二次授权
/// @param call <#call description#>
/// @param result <#result description#>
- (void)taoKeLogin:(FlutterMethodCall *)call result:(FlutterResult)result;
/**
 通过url打开,包括h5，唤起手淘等

 @param call <#call description#>
 @param result <#result description#>
 */
- (void)openByUrl:(FlutterMethodCall *)call result:(FlutterResult)result;


/**
 打开商品详情

 @param call <#call description#>
 @param result <#result description#>
 */
- (void)openItemDetail:(FlutterMethodCall *)call result:(FlutterResult)result;

/**
 打开店铺

 @param call <#call description#>
 @param result <#result description#>
 */
- (void)openShop:(FlutterMethodCall *)call result:(FlutterResult)result;

/**
 打开购物车

 @param call <#call description#>
 @param result <#result description#>
 */
- (void)openCart:(FlutterMethodCall *)call result:(FlutterResult)result;

/**
 是否淘宝打点

 @param call <#call description#>
 @param result <#result description#>
 */
- (void)syncForTaoke:(FlutterMethodCall *)call result:(FlutterResult)result;

/**
 是否使用Native AliPay

 @param call <#call description#>
 @param result <#result description#>
 */
- (void)useAlipayNative:(FlutterMethodCall *)call result:(FlutterResult)result;
/**
 关闭当前的webview
 */
- (void)closeWebView;
@end

NS_ASSUME_NONNULL_END
