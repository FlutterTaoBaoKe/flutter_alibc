# flutter_alibc

Flutter版本的阿里百川
V4.0.0版本

地址：[flutter_alibc](https://pub.dev/packages/flutter_alibc)

支持Android和iOS

Android：983598009@qq.com
iOS：329106954@qq.com

## Getting Started

### 工程性配置

参考[阿里百川官网](https://baichuan.taobao.com/docs/doc.htm?spm=a3c0d.7629140.0.0.3043be48zxxuk5&treeId=129&articleId=118102&docType=1)

### 引入
[如何引入项目](https://pub.dev/packages/flutter_alibc#-installing-tab-)

### 方法说明
* 头文件引入
```
import 'package:flutter_alibc/flutter_alibc.dart';
```

* 初始化

```
 /**
   * 初始化
   * version:当前app版本
   * appName:当前app名称
   * result:{
   * errorCode,     //0为初始化成功，其他为失败
   * errorMessage,  //message
   * }
   */
var result = await FlutterAlibc.initAlibc(version:"",appName:"");
```

* 登录淘宝
```
/**
   * 登录淘宝
   * version:当前app版本
   * appName:当前app名称
   * result:{
   * errorCode,     //0为初始化成功，其他为失败
   * errorMessage,  //message
   * data:{					//登录成功的情况下返回data，为用户数据
   * 	//nick 用户昵称，avatarUrl 头像地址
	 *  nick,avatarUrl,openId,openSid,topAccessToken,topAuthCode
   * 	}
   * }
   * 备注：登录过会直接返回淘宝用户的信息，不会多次唤醒淘宝，请放心
   */
var result = await FlutterAlibc.loginTaoBao();
```

* 淘宝登出
```
FlutterAlibc.loginOut();
```

* 唤起淘宝，openByUrl方式

```
 /**
   * @description: 通过url打开,包括h5，唤起手淘等
   * @param 
   * url:目标url
   * openType:打开类型,默认auto
   * isNeedCustomNativeFailMode:是否需要设置唤端失败策略，默认false
   * nativeFailMode:唤端失败策略，默认None
   * schemeType:唤起哪个端，默认天猫
   * taokeParams:淘客数据
   * backUrl: 跳转回来的url
   * @return: {
   *		errorCode,
   *		errorMessage,
   *		type,			//0为添加购物车，1为付款成功
   *		payResult,	//type为1时返回
	 *  	tradeFailResult:{//errorCode不为0时返回
   *		 	orderIdList,			//失败的orderIdList
	 *	  },	
	 *  }
   */
 var result = await FlutterAlibc.openByUrl(
                    url:"",	//必须参数
                    openType : AlibcOpenType.AlibcOpenTypeAuto,
                    isNeedCustomNativeFailMode : false,
                    nativeFailMode :    AlibcNativeFailMode.AlibcNativeFailModeNone,
                    schemeType : AlibcSchemeType.AlibcSchemeTmall,
                    taokeParams : {},
                    backUrl:"",
                    );
```

* 唤起淘宝，openItemDetail方式
```
/**
   * @description: 打开商品详情
   * @param 
   * itemID 商品id，可以是真实的也可以是混淆的，必须参数
   * trackParam	需要额外追踪的业务数据
   * 其他同上
   * @return: 
   */
var result = await FlutterAlibc.openItemDetail(
										itemID:"",	//必须参数
                    openType : AlibcOpenType.AlibcOpenTypeAuto,
                    isNeedCustomNativeFailMode : false,
                    nativeFailMode :    AlibcNativeFailMode.AlibcNativeFailModeNone,
                    schemeType : AlibcSchemeType.AlibcSchemeTmall,
                    taokeParams : {},
                    trackParam : {}, //需要额外追踪的业务数据
                    backUrl:"",
);
```

* 打开店铺，openShop方式
```
/**
   * @description: 打开店铺
   * @param 
   * shopId 店铺id，必须参数
   * 其他同上
   * @return: 
   */
var result = await FlutterAlibc.openShop(
										shopId:"",	//必须参数
                    openType : AlibcOpenType.AlibcOpenTypeAuto,
                    isNeedCustomNativeFailMode : false,
                    nativeFailMode :    AlibcNativeFailMode.AlibcNativeFailModeNone,
                    schemeType : AlibcSchemeType.AlibcSchemeTmall,
                    taokeParams : {},
                    trackParam : {}, //需要额外追踪的业务数据
                    backUrl:"",
);
```

* 打开购物车，openCart方式
```
/**
   * @description: 打开购物车
   * @param 
   * 无必须参数
   * 其他同上
   * @return: 
   */
var result = await FlutterAlibc.openCart(
                    openType : AlibcOpenType.AlibcOpenTypeAuto,
                    isNeedCustomNativeFailMode : false,
                    nativeFailMode :    AlibcNativeFailMode.AlibcNativeFailModeNone,
                    schemeType : AlibcSchemeType.AlibcSchemeTmall,
                    taokeParams : {},
                    trackParam : {}, //需要额外追踪的业务数据
                    backUrl:"",
);
```


* 是否设置同步打点
```
FlutterAlibc.syncForTaoke(true);
````

* 是否使用Native Alipay
```
FlutterAlibc.useAlipayNative(true);
```
