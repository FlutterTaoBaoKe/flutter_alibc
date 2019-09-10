import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alibc/albc_tools.dart';
import 'package:flutter_alibc/alibc_const_key.dart';
import 'package:flutter_alibc/alibc_model.dart';

class FlutterAlibc {
  // 通信的桥接类
  static final MethodChannel _channel = const MethodChannel("flutter_alibc");

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///初始化
  ///version:当前app版本
  ///appName:当前app名称
  ///result:{
  ///   errorCode,     //0为初始化成功，其他为失败
  ///   errorMessage,  //message 
  ///}
  static Future<InitModel> initAlibc({String version, String appName}) async {
    Map result = await _channel
        .invokeMethod("initAlibc", {"version": version, "appName": appName});
    return InitModel(
        result[AlibcConstKey.errorCode], result[AlibcConstKey.errorMessage]);
  }

  ///
   /// @description: 登录淘宝
   /// 
   /// @return: 成功则返回的data为用户信息，失败则没有data
   ///
  static Future<LoginModel> loginTaoBao() async {
    Map result = await _channel.invokeMethod("loginTaoBao");
    // 判断成功还是失败
    if (result[AlibcConstKey.errorCode] != "0") {
      return LoginModel(
        result[AlibcConstKey.errorCode],
        result[AlibcConstKey.errorMessage],
      );
    }
    return LoginModel(
        result[AlibcConstKey.errorCode], result[AlibcConstKey.errorMessage],
        data: UserModel(
            result[AlibcConstKey.data]["nick"],
            result[AlibcConstKey.data]["avatarUrl"],
            result[AlibcConstKey.data]["openId"],
            result[AlibcConstKey.data]["openSid"],
            result[AlibcConstKey.data]["topAccessToken"],
            result[AlibcConstKey.data]["topAuthCode"]));
  }

  ///
   /// @description: 退出淘宝登录
   /// @param {type} 
   /// @return: 
   ///
  static loginOut() {
    _channel.invokeMethod("loginOut");
  }

  ///
   /// @description: 通过url打开,包括h5，唤起手淘等
   /// @param 
   /// url:目标url
   /// openType:打开类型
   /// isNeedCustomNativeFailMode:是否需要设置唤端失败策略
   /// nativeFailMode:唤端失败策略
   /// schemeType:唤起哪个端
   /// taokeParams:淘客数据
   /// backUrl: 跳转回来的url
   /// @return: 
   ///
  static Future<TradeResult> openByUrl({
    @required String url,
    AlibcOpenType openType = AlibcOpenType.AlibcOpenTypeAuto,
    bool isNeedCustomNativeFailMode = false,
    AlibcNativeFailMode nativeFailMode =
        AlibcNativeFailMode.AlibcNativeFailModeNone,
    AlibcSchemeType schemeType = AlibcSchemeType.AlibcSchemeTmall,
    TaokeParams taokeParams,
    String backUrl,
  }) async {
    Map taoKe = AlibcTools.getTaokeMap(taokeParams);
    Map result = await _channel.invokeMethod("openByUrl", {
      "url": url,
      "openType": openType.index,
      "isNeedCustomNativeFailMode": isNeedCustomNativeFailMode,
      "nativeFailMode": nativeFailMode.index,
      "schemeType": schemeType.index,
      "taokeParams": taoKe,
      "backUrl": backUrl
    });

    TradeResult tradeResult = AlibcTools.getTradeResult(result);
    return tradeResult;
  }

  ///
   /// @description: 打开商品详情
   /// @param 
   /// 同上
   /// itemID 商品id，可以是真实的也可以是混淆的
   /// isNeedPush iOS独占
   /// @return: 
   ///
  static Future<TradeResult> openItemDetail({
    @required String itemID,
    // iOS独占
    // bool isNeedPush = false,
    AlibcOpenType openType = AlibcOpenType.AlibcOpenTypeAuto,
    bool isNeedCustomNativeFailMode = false,
    AlibcNativeFailMode nativeFailMode =
        AlibcNativeFailMode.AlibcNativeFailModeNone,
    AlibcSchemeType schemeType = AlibcSchemeType.AlibcSchemeTmall,
    TaokeParams taokeParams,
    // 额外需要追踪的业务数据
    Map trackParam,
    String backUrl,
  }) async {
    Map taoKe = AlibcTools.getTaokeMap(taokeParams);
    Map result = await _channel.invokeMethod("openItemDetail", {
      "itemID": itemID,
      // "isNeedPush": isNeedPush,
      "openType": openType.index,
      "isNeedCustomNativeFailMode": isNeedCustomNativeFailMode,
      "nativeFailMode": nativeFailMode.index,
      "schemeType": schemeType.index,
      "taokeParams": taoKe,
      "trackParam": trackParam,
      "backUrl": backUrl
    });
    TradeResult tradeResult = AlibcTools.getTradeResult(result);
    return tradeResult;
  }

  ///
   /// @description: 打开店铺
   /// @param {type} 
   /// shopId 店铺id
   /// @return: 
   ///
  static Future<TradeResult> openShop({
    @required String shopId,
    // iOS独占
    // bool isNeedPush = false,
    AlibcOpenType openType = AlibcOpenType.AlibcOpenTypeAuto,
    bool isNeedCustomNativeFailMode = false,
    AlibcNativeFailMode nativeFailMode =
        AlibcNativeFailMode.AlibcNativeFailModeNone,
    AlibcSchemeType schemeType = AlibcSchemeType.AlibcSchemeTmall,
    TaokeParams taokeParams,
    // 额外需要追踪的业务数据
    Map trackParam,
    String backUrl,
  }) async {
    Map taoKe = AlibcTools.getTaokeMap(taokeParams);

    Map result = await _channel.invokeMethod("openShop", {
      "shopId": shopId,
      // "isNeedPush": isNeedPush,
      "openType": openType.index,
      "isNeedCustomNativeFailMode": isNeedCustomNativeFailMode,
      "nativeFailMode": nativeFailMode.index,
      "schemeType": schemeType.index,
      "taokeParams": taoKe,
      "trackParam": trackParam,
      "backUrl": backUrl
    });
    TradeResult tradeResult = AlibcTools.getTradeResult(result);
    return tradeResult;
  }

  ///
   /// @description: 打开购物车
   /// @param {type} 
   /// @return: 
   ///
  static Future<TradeResult> openCart({
    // iOS独占
    // bool isNeedPush = false,
    AlibcOpenType openType = AlibcOpenType.AlibcOpenTypeAuto,
    bool isNeedCustomNativeFailMode = false,
    AlibcNativeFailMode nativeFailMode =
        AlibcNativeFailMode.AlibcNativeFailModeNone,
    AlibcSchemeType schemeType = AlibcSchemeType.AlibcSchemeTmall,
    TaokeParams taokeParams,
    // 额外需要追踪的业务数据
    Map trackParam,
    String backUrl,
  }) async {
    Map taoKe = AlibcTools.getTaokeMap(taokeParams);

    Map result = await _channel.invokeMethod("openCart", {
      // "isNeedPush": isNeedPush,
      "openType": openType.index,
      "isNeedCustomNativeFailMode": isNeedCustomNativeFailMode,
      "nativeFailMode": nativeFailMode.index,
      "schemeType": schemeType.index,
      "taokeParams": taoKe,
      "trackParam": trackParam,
      "backUrl": backUrl
    });
    TradeResult tradeResult = AlibcTools.getTradeResult(result);
    return tradeResult;
  }

  // 是否需要设置打点
  static syncForTaoke(bool isSync) {
    _channel.invokeMethod("syncForTaoke", {"isSync": isSync});
  }

  // 是否需要 Native AliPay 接口
  static useAlipayNative(bool isNeed) {
    _channel.invokeMethod("useAlipayNative", {"isNeed": isNeed});
  }
}
