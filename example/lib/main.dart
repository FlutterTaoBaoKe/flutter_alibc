import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alibc/flutter_alibc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterAlibc.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    /* try {
      var initRes = await FlutterAlibc.initAlibc();
    } on Exception {}*/

    try {
      // var waite3s = await FlutterAlibc.openItemDetail(itemID: "12345");
      var result = await FlutterAlibc.initAlibc();
      print(result);
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("初始化阿里百川"),
              onPressed: () async {
                try {
                  // var waite3s = await FlutterAlibc.openItemDetail(itemID: "12345");
                  // 如果什么都不给
                  var result = await FlutterAlibc.initAlibc();
                  print(result);
                } on Exception {}
              },
            ),
            FlatButton(
              child: Text("登录淘宝"),
              onPressed: () async {
                var result = await FlutterAlibc.loginTaoBao();
                print(result);
              },
            ),
            FlatButton(
              child: Text("登出淘宝"),
              onPressed: () {
                FlutterAlibc.loginOut();
              },
            ),
            FlatButton(
              child: Text("唤起淘宝，openByUrl方式"),
              onPressed: () async {
                var result = await FlutterAlibc.openByUrl(
                    url:
                        "https://uland.taobao.com/coupon/edetail?e=0I2EBL%2BTWswGQASttHIRqRXxIesJCFV0jSsDEwaP11URqogtr65NL3IIxArmwXZQtYdj3OrQBBwJkllDQLUC%2B79fwBwwUiqlvyfAqbG%2BQWkG6QT52O7rmXYefz8NXcoYTJnbK5InWzlFfSAQOJJoy8NEaV3mm%2FQSzjZt5gElMznom9kMiklcP0KJ92VgfYGd&traceId=0b0d82cf15669814548736276e3d95&union_lens=lensId:0b0b6466_0c0d_16cd75f7c39_528f&xId=6MboRwsAi2s8Glbqt3lJLAwSlyrPyBLCZ01KOk6QzKCNhw8C6RjXgA1bNbZdKzp30gOqd1J5j1k7ei7HYId1QZ&ut_sk=1.utdid_null_1566981455011.TaoPassword-Outside.taoketop&sp_tk=77+lTU5nMllrdHRqSVLvv6U=",
                    backUrl: "tbopen27822502:https://h5.m.taobao.com");
                print(result);
              },
            ),
            FlatButton(
              child: Text("唤起淘宝，openItemDetail方式"),
              onPressed: () async {
                var result =
                    await FlutterAlibc.openItemDetail(itemID: "590134648441");
                print(result);
              },
            ),
            FlatButton(
              child: Text("打开店铺，openShop方式"),
              onPressed: () async {
                var result = await FlutterAlibc.openShop(shopId: "71955116");
                print(result);
              },
            ),
            FlatButton(
              child: Text("打开购物车，openCart方式"),
              onPressed: () async {
                var result = await FlutterAlibc.openCart();
                print(result);
              },
            ),
            FlatButton(
              child: Text("允许打点"),
              onPressed: () {
                FlutterAlibc.syncForTaoke(true);
              },
            ),
            FlatButton(
              child: Text("使用native Alipay"),
              onPressed: () {
                FlutterAlibc.useAlipayNative(true);
              },
            ),
          ],
        )),
      ),
    );
  }
}
