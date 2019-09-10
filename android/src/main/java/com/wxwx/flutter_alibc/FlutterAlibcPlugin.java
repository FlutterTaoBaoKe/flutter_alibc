package com.wxwx.flutter_alibc;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterAlibcPlugin */
public class FlutterAlibcPlugin implements MethodCallHandler {

  private static com.wxwx.flutter_alibc.FlutterAlibcHandle handle;
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    handle = com.wxwx.flutter_alibc.FlutterAlibcHandle.getInstance(registrar);
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_alibc");
    channel.setMethodCallHandler(new FlutterAlibcPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("initAlibc")){
      handle.initAlibc(call, result);
    }else if (call.method.equals("openItemDetail")){
      handle.openItemDetail(call, result);
    } else if (call.method.equals("loginTaoBao")){
      handle.loginTaoBao(result);
    } else if (call.method.equals("loginOut")){
      handle.loginOut(result);
    }else if (call.method.equals("openByUrl")){
      handle.openByUrl(call, result);
    }else if (call.method.equals("openShop")){
      handle.openShop(call, result);
    }else if (call.method.equals("openCart")){
      handle.openCart(call, result);
    }else if (call.method.equals("syncForTaoke")){
      handle.syncForTaoke(call);
    }else if (call.method.equals("useAlipayNative")){
      handle.useAlipayNative(call);
    }else {
      result.notImplemented();
    }
  }
}
