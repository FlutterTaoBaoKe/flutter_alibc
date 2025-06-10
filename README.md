# flutter_alibc

Flutter版本的阿里百川
android V4.0.0.8版本
ios V4.0.1.6 版本

pub地址：[flutter_alibc](https://pub.dev/packages/flutter_alibc)
github地址：[flutter_alibc](https://github.com/FlutterTaoBaoKe/flutter_alibc.git)

可以给个star🐴，混口饭吃

支持Android和iOS

邮箱：

Android：983598009@qq.com

iOS：329106954@qq.com
P.S:另有开普勒插件[flutter_kepler](https://github.com/FlutterTaoBaoKe/flutter_kepler)
## Getting Started

### 工程性配置

参考[阿里百川官网](https://baichuan.taobao.com/docs/doc.htm?spm=a3c0d.7629140.0.0.3043be48zxxuk5&treeId=129&articleId=118102&docType=1)
Android: 注意在新版本gradle编译时,会强制校验远程仓库是否存在.pom文件, 阿里百川仓库目前缺少.pom文件, 因此目前先使用较低版本gradle

### 引入
[如何引入项目](https://pub.dev/packages/flutter_alibc#-installing-tab-)
iOS请在podfile文件非注释的第一行，加入淘宝源，如果有其他源，请放在其他源下方,没有其他源只需要加这一个即可
```
source 'http://repo.baichuan-ios.taobao.com/baichuanSDK/AliBCSpecs.git'
```
看不懂这句话就看下demo中的example/ios/podfile文件第4行代码，第3行是其他源的示例可以不加

### 支持swift了
### 感谢[@a4081675](https://github.com/a4081675)同学
[issues44](https://github.com/FlutterTaoBaoKe/flutter_alibc/issues/44)
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
   * result :{
   * errorCode,     //0为初始化成功，其他为失败
   * errorMessage,  //message
   * data:{					//登录成功的情况下返回data，为用户数据
   * 	//nick 用户昵称，avatarUrl 头像地址
	 *  nick,avatarUrl,openId,openSid,topAccessToken,topAuthCode
   * 	}
   * }
   * 备注：登录过会直接返回淘宝用户的信息，不会多次唤醒淘宝，请放心
   */
    FlutterAlibc.loginTaoBao(callback:(result){
        print("登录淘宝  ${result.data.nick} ${result.data.topAccessToken}");
    });
```

* 淘宝登出
```
FlutterAlibc.loginOut();
```

* 淘客登录，二次授权获取access_token

```
 /**
   * @description: 获取access_token
   * @param 
   * url:用于授权登录的url
   * openType:打开类型,默认auto
   * isNeedCustomNativeFailMode:是否需要设置唤端失败策略，默认false
   * nativeFailMode:唤端失败策略，默认None
   * schemeType:唤起哪个端，默认天猫
   * taokeParams:淘客数据
   * backUrl: 跳转回来的url
   * result: {"data":{"accessToken":"xxx"},"errorMessage":"成功","errorCode":"0"}//获取成功为token，获取失败为空字符串
   */
    FlutterAlibc.taoKeLogin(
                    url:"",	//必须参数，用于授权登录的url
                    openType : AlibcOpenType.AlibcOpenTypeAuto,
                    isNeedCustomNativeFailMode : false,
                    nativeFailMode :    AlibcNativeFailMode.AlibcNativeFailModeNone,
                    schemeType : AlibcSchemeType.AlibcSchemeTmall,
                    taokeParams : {},
                    backUrl:"",
                    callback: (result){
                        print('淘客登录 ' + json.encode(result));
                    });
```

* 淘客登录，二次授权获取code

```
 /**
   * @description: 获取code
   * @param 
   * url:用于授权登录的url
   * openType:打开类型,默认auto
   * isNeedCustomNativeFailMode:是否需要设置唤端失败策略，默认false
   * nativeFailMode:唤端失败策略，默认None
   * schemeType:唤起哪个端，默认天猫
   * taokeParams:淘客数据
   * backUrl: 跳转回来的url
   * result: {"data":{"code":"xxx"},"errorMessage":"成功","errorCode":"0"}//获取成功为code，获取失败为空字符串
   */
    FlutterAlibc.taoKeLoginForCode(
                    url:"",	//必须参数，用于授权登录的url
                    openType : AlibcOpenType.AlibcOpenTypeAuto,
                    isNeedCustomNativeFailMode : false,
                    nativeFailMode :    AlibcNativeFailMode.AlibcNativeFailModeNone,
                    schemeType : AlibcSchemeType.AlibcSchemeTmall,
                    taokeParams : {},
                    backUrl:"",
                    callback: (result){
                        print('淘客登录 ' + json.encode(result));
                    });
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
   * result: {
   *		errorCode,
   *		errorMessage,
   *		type,			//0为添加购物车，1为付款成功
   *		payResult,	//type为1时返回
   *  }
   */
   FlutterAlibc.openByUrl(
                    url:"",	//必须参数
                    openType : AlibcOpenType.AlibcOpenTypeAuto,
                    isNeedCustomNativeFailMode : false,
                    nativeFailMode :    AlibcNativeFailMode.AlibcNativeFailModeNone,
                    schemeType : AlibcSchemeType.AlibcSchemeTmall,
                    taokeParams : {},
                    backUrl:"",
                    callback: (result){
                        print('openByURL ' + json.encode(result));
                    });
```

* 唤起淘宝，openItemDetail方式
```
/**
   * @description: 打开商品详情
   * @param 
   * itemID 商品id，可以是真实的也可以是混淆的，必须参数
   * trackParam	需要额外追踪的业务数据
   * 其他同上
   * @return: 同openByUrl
   */
    FlutterAlibc.openItemDetail(
										itemID:"",	//必须参数
                    openType : AlibcOpenType.AlibcOpenTypeAuto,
                    isNeedCustomNativeFailMode : false,
                    nativeFailMode :    AlibcNativeFailMode.AlibcNativeFailModeNone,
                    schemeType : AlibcSchemeType.AlibcSchemeTmall,
                    taokeParams : {},
                    trackParam : {}, //需要额外追踪的业务数据
                    backUrl:"",
                    callback: (result){
                        print('openItemDetail ' + json.encode(result));
                    });
```

* 打开店铺，openShop方式
```
/**
   * @description: 打开店铺
   * @param 
   * shopId 店铺id，必须参数
   * 其他同上
   * result: 同openByUrl
   */
    FlutterAlibc.openShop(
										shopId:"",	//必须参数
                    openType : AlibcOpenType.AlibcOpenTypeAuto,
                    isNeedCustomNativeFailMode : false,
                    nativeFailMode :    AlibcNativeFailMode.AlibcNativeFailModeNone,
                    schemeType : AlibcSchemeType.AlibcSchemeTmall,
                    taokeParams : {},
                    trackParam : {}, //需要额外追踪的业务数据
                    backUrl:"",
                    callback: (result){
                         print('openShop ' + json.encode(result));
                    });
```

* 打开购物车，openCart方式
```
/**
   * @description: 打开购物车
   * @param 
   * 无必须参数
   * 其他同上
   * result: 同openByUrl
   */
    FlutterAlibc.openCart(
                    openType : AlibcOpenType.AlibcOpenTypeAuto,
                    isNeedCustomNativeFailMode : false,
                    nativeFailMode :    AlibcNativeFailMode.AlibcNativeFailModeNone,
                    schemeType : AlibcSchemeType.AlibcSchemeTmall,
                    taokeParams : {},
                    trackParam : {}, //需要额外追踪的业务数据
                    backUrl:"",
                    callback: (result){
                          print('openShop ' + json.encode(result));
                    });
```


* 是否设置同步打点
```
FlutterAlibc.syncForTaoke(true);
````

* 是否使用Native Alipay
```
FlutterAlibc.useAlipayNative(true);
```



[![Powered by DartNode](https://dartnode.com/branding/DN-Open-Source-sm.png)](https://dartnode.com "Powered by DartNode - Free VPS for Open Source")
