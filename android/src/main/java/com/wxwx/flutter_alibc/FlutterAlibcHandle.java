package com.wxwx.flutter_alibc;

import android.util.Log;
import android.webkit.WebChromeClient;
import android.webkit.WebViewClient;
import android.widget.Toast;
import android.content.Intent;
import com.ali.auth.third.core.model.Session;
import com.alibaba.baichuan.trade.biz.context.AlibcResultType;
import com.alibaba.baichuan.android.trade.AlibcTrade;
import com.alibaba.baichuan.android.trade.callback.AlibcTradeCallback;
import com.alibaba.baichuan.android.trade.model.AlibcShowParams;
import com.alibaba.baichuan.android.trade.model.OpenType;
import com.alibaba.baichuan.android.trade.page.AlibcBasePage;
import com.alibaba.baichuan.android.trade.page.AlibcDetailPage;
import com.alibaba.baichuan.android.trade.page.AlibcMyCartsPage;
import com.alibaba.baichuan.android.trade.page.AlibcShopPage;
import com.alibaba.baichuan.trade.biz.applink.adapter.AlibcFailModeType;
import com.alibaba.baichuan.trade.biz.context.AlibcTradeResult;
import com.alibaba.baichuan.trade.biz.core.taoke.AlibcTaokeParams;
import com.alibaba.baichuan.trade.biz.login.AlibcLogin;
import com.alibaba.baichuan.trade.biz.login.AlibcLoginCallback;
import com.alibaba.baichuan.android.trade.AlibcTradeSDK;
import com.alibaba.baichuan.android.trade.callback.AlibcTradeInitCallback;
import com.alibaba.baichuan.trade.common.utils.AlibcLogger;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import java.util.HashMap;
import android.app.AlertDialog;
import static com.wxwx.flutter_alibc.PluginConstants.*;
import static com.wxwx.flutter_alibc.PluginUtil.*;
import com.wxwx.flutter_alibc.web.WebViewActivity;
import java.util.Map;

/**
 * @Author karedem
 * @Date 2019/9/7 19:55
 * @Description 接口处理者
**/
public class FlutterAlibcHandle{

    private static FlutterAlibcHandle handle;
    private Registrar register;

    //第一次调用getInstance register不能为空
    public static FlutterAlibcHandle getInstance(Registrar register){
        if (handle == null){
            synchronized (FlutterAlibcHandle.class){
                handle = new FlutterAlibcHandle();
                handle.register = register;
            }
        }
        return handle;
    }

    /**
     * 初始化阿里百川
     * @param call
     * @param result
     */
    public void initAlibc(MethodCall call, Result result){
        AlibcTradeSDK.asyncInit(register.activity().getApplication(), new AlibcTradeInitCallback() {
            @Override
            public void onSuccess() {
                result.success(PluginResponse.success(null).toMap());
            }
            @Override
            public void onFailure(int code, String msg) {
                result.success(new PluginResponse(Integer.toString(code), msg, null).toMap());
            }
        });
    }

    /**
     * 登陆淘宝
     * @param result
     */
    public void loginTaoBao(Result result){
        final AlibcLogin alibcLogin = AlibcLogin.getInstance();
        if (alibcLogin.isLogin()){
            Session session = AlibcLogin.getInstance().getSession();
            Map<String, Object> userInfo = new HashMap<>();
            userInfo.put("nick", session.nick);
            userInfo.put("avatarUrl", session.avatarUrl);
            userInfo.put("openId", session.openId);
            userInfo.put("openSid", session.openSid);
            userInfo.put("topAccessToken", session.topAccessToken);
            userInfo.put("topAuthCode", session.topAuthCode);
            result.success(PluginResponse.success(userInfo).toMap());
            return;
        }
        alibcLogin.showLogin(new AlibcLoginCallback() {
            @Override
            public void onSuccess(int loginResult, String openId, String userNick) {
                Map<String, Object> userInfo = new HashMap<>();
                Session session = AlibcLogin.getInstance().getSession();
                userInfo.put("nick", session.nick);
                userInfo.put("avatarUrl", session.avatarUrl);
                userInfo.put("openId", session.openId);
                userInfo.put("openSid", session.openSid);
                userInfo.put("topAccessToken", session.topAccessToken);
                userInfo.put("topAuthCode", session.topAuthCode);
                result.success(PluginResponse.success(userInfo).toMap());
            }
            @Override
            public void onFailure(int code, String msg) {
                // code：错误码  msg： 错误信息
                result.success(new PluginResponse(Integer.toString(code), msg, null).toMap());
            }
        });
    }

    /**
     * 登出
     * @param result
     */
    public void loginOut(Result result){
        AlibcLogin alibcLogin = AlibcLogin.getInstance();
        alibcLogin.logout(new AlibcLoginCallback() {
            @Override
            public void onSuccess(int loginResult, String openId, String userNick) {
            }
            @Override
            public void onFailure(int code, String msg) {
                // code：错误码  msg： 错误信息
            }
        });
    }

    /**
     * 淘宝授权登陆  获取access_token
     *  官方说明文档 {https://open.taobao.com/doc.htm?docId=118&docType=1}
     * @param call
     * @param result
     */
    public void taoKeLogin(MethodCall call, Result result){
        HashMap<String, Object> map = (HashMap<String, Object>)call.arguments;
        String url = call.argument("url");
        WebViewActivity.setCallBack(new WebViewActivity.CallBack() {
            @Override
            public void success(String accessToken) {
                Map<String,String> resMap = new HashMap();
                resMap.put("accessToken", accessToken);
                result.success(resMap);
            }

            @Override
            public void failed(String errorMsg) {
                Map<String,String> resMap = new HashMap();
                resMap.put("accessToken", "");
                result.success(resMap);
            }
        });
        Intent intent = new Intent(register.activity(), WebViewActivity.class);
        intent.putExtra("url", url);
        intent.putExtra("arguments", map);
        register.activity().startActivity(intent);
    }

    /**
     * 通过URL方式打开淘宝
     * @param call
     * @param result
     */
    public void openByUrl(MethodCall call, Result result){
        AlibcShowParams showParams = new AlibcShowParams();
        AlibcTaokeParams taokeParams = new AlibcTaokeParams("","","");

        showParams.setBackUrl(call.argument(key_BackUrl));

        if (call.argument(key_OpenType) != null){
            System.out.println("openType" + call.argument(key_OpenType));
            showParams.setOpenType(getOpenType(""+call.argument(key_OpenType)));
        }
        if (call.argument(key_ClientType) != null){
            System.out.println("clientType " + call.argument(key_ClientType));
            showParams.setClientType(getClientType(""+call.argument(key_ClientType)));
        }
        if (call.argument("taokeParams") != null){
            taokeParams  = getTaokeParams(call.argument("taokeParams"));
        }
        if ("false".equals(call.argument("isNeedCustomNativeFailMode"))){
            showParams.setNativeOpenFailedMode(AlibcFailModeType.AlibcNativeFailModeNONE);
        }else if (call.argument(key_NativeFailMode) != null){
            showParams.setNativeOpenFailedMode(getFailModeType(""+call.argument(key_NativeFailMode)));
        }

        Map<String, String> trackParams = new HashMap<>();
        String url = call.argument("url");
        // 以显示传入url的方式打开页面（第二个参数是套件名称）
        AlibcTrade.openByUrl(register.activity(), "", url, null,
                new WebViewClient(), new WebChromeClient(), showParams,
                taokeParams, trackParams, new AlibcTradeCallback() {
                    @Override
                    public void onTradeSuccess(AlibcTradeResult tradeResult) {
                        Map<String, Object> results = new HashMap<>();
                        if (AlibcResultType.TYPECART == tradeResult.resultType){
                            results.put("type", 1);
                        }else if (AlibcResultType.TYPEPAY == tradeResult.resultType){
                            results.put("type", 0);
                            results.put("payFailedOrders", tradeResult.payResult.payFailedOrders);
                            results.put("paySuccessOrders", tradeResult.payResult.paySuccessOrders);
                        }
                        result.success(PluginResponse.success(results).toMap());
                    }
                    @Override
                    public void onFailure(int code, String msg) {
                        result.success(new PluginResponse(Integer.toString(code), msg, null).toMap());
                    }
                });
    }

    /**
     * 打开商店
     * @param call
     * @param result
     */
    public void openShop(MethodCall call, Result result){
        AlibcBasePage page = new AlibcShopPage(call.argument("shopId"));
        openByBizCode(page, "shop", call, result);
    }

    /**
     * 打开购物车
     * @param result
     */
    public void openCart(MethodCall call, Result result){
        AlibcBasePage page = new AlibcMyCartsPage();
        openByBizCode(page, "cart",call, result);
    }

    /**
     * 打开商品详情
     * @param call   call.argument["itemID"]  详情id
     * @param result
     */
    public void openItemDetail(MethodCall call, Result result){
        AlibcBasePage page = new AlibcDetailPage(call.argument("itemID"));
        openByBizCode(page, "detail", call, result);
    }

    private void openByBizCode(AlibcBasePage page,String type, MethodCall call, Result result){
        AlibcShowParams showParams = new AlibcShowParams();
        AlibcTaokeParams taokeParams = new AlibcTaokeParams("", "", "");

        showParams.setBackUrl(call.argument(key_BackUrl));

        if (call.argument(key_OpenType) != null){
            showParams.setOpenType(getOpenType(""+call.argument(key_OpenType)));
        }
        if (call.argument(key_ClientType) != null){
            showParams.setClientType(getClientType(""+call.argument(key_ClientType)));
        }
        if (call.argument("taokeParams") != null){
            taokeParams  = getTaokeParams(call.argument("taokeParams"));
        }

        if ("false".equals(call.argument("isNeedCustomNativeFailMode"))){
            showParams.setNativeOpenFailedMode(AlibcFailModeType.AlibcNativeFailModeNONE);
        }else if (call.argument(key_NativeFailMode) != null){
            showParams.setNativeOpenFailedMode(getFailModeType(""+call.argument(key_NativeFailMode)));
        }

        Map<String, String> trackParams = new HashMap<>();
        AlibcTrade.openByBizCode(register.activity(), page, null, new WebViewClient(),
                new WebChromeClient(), type, showParams, taokeParams,
                trackParams, new AlibcTradeCallback() {
                    @Override
                    public void onTradeSuccess(AlibcTradeResult tradeResult) {
                        Map<String, Object> results = new HashMap<>();
                        if (AlibcResultType.TYPECART == tradeResult.resultType){
                            results.put("type", 1);
                        }else if (AlibcResultType.TYPEPAY == tradeResult.resultType){
                            results.put("type", 0);
                            results.put("payFailedOrders", tradeResult.payResult.payFailedOrders);
                            results.put("paySuccessOrders", tradeResult.payResult.paySuccessOrders);
                        }
                        result.success(PluginResponse.success(results).toMap());
                    }
                    @Override
                    public void onFailure(int code, String msg) {
                        // 失败回调信息
                        result.success(new PluginResponse(Integer.toString(code), msg, null).toMap());
                    }
                });
    }

    /**
     * 设置淘客打点策略 是否异步
     * @param call
     */
    public void syncForTaoke(MethodCall call){
        AlibcTradeSDK.setSyncForTaoke(call.argument("isSync"));
    }

    /**
     * TODO
     * @param call
     */
    public void useAlipayNative(MethodCall call){
        AlibcTradeSDK.setShouldUseAlipay(call.argument("isNeed"));
    }


}