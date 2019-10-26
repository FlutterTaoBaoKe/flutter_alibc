package com.wxwx.flutter_alibc.web;
import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.webkit.DownloadListener;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Toast;

import com.alibaba.baichuan.android.trade.AlibcTrade;
import com.alibaba.baichuan.android.trade.callback.AlibcTradeCallback;
import com.alibaba.baichuan.android.trade.model.AlibcShowParams;
import com.alibaba.baichuan.android.trade.model.OpenType;
import com.alibaba.baichuan.trade.biz.applink.adapter.AlibcFailModeType;
import com.alibaba.baichuan.trade.biz.context.AlibcTradeResult;
import com.alibaba.baichuan.trade.biz.core.taoke.AlibcTaokeParams;
import com.alibaba.baichuan.trade.common.utils.AlibcLogger;

import java.util.HashMap;
import java.util.Map;
import static com.wxwx.flutter_alibc.PluginConstants.*;
import static com.wxwx.flutter_alibc.PluginUtil.*;
import com.wxwx.flutter_alibc.R;
import java.net.URLDecoder;

public class WebViewActivity extends Activity {

    //这个回调最好是非静态的  多线程下会有问题  但是这样比较快
    private static CallBack callBack;

    public static void setCallBack(CallBack callBack){
        WebViewActivity.callBack = callBack;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.webview_activity);
        Intent intent = getIntent();
        if (intent != null) {
            final String url = intent.getStringExtra("url");
            HashMap<String, Object> arguments = (HashMap<String, Object>) intent.getSerializableExtra("arguments");
            WebView webView = findViewById(R.id.webview);
            //启用支持JavaScript
            webView.getSettings().setJavaScriptEnabled(true);
            //启用支持DOM Storage
            webView.getSettings().setDomStorageEnabled(true);
            openByUrl(url, webView, arguments);
        }

    }

    private String getAccessToken(String url) {
        try {
            int startIndex = url.indexOf("access_token");
            String subStr = url.substring(startIndex);
            String tempUrl = URLDecoder.decode(subStr, "UTF-8");
            int endIndex = tempUrl.indexOf("&");
            subStr = tempUrl.substring(0, endIndex);
            startIndex = subStr.indexOf("=");
            subStr = subStr.substring(startIndex+1);
            return subStr;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    private void openByUrl(String url, WebView webView, HashMap argument) {
        AlibcShowParams showParams = new AlibcShowParams();
        AlibcTaokeParams taokeParams = new AlibcTaokeParams("", "", "");
        showParams.setBackUrl(String.valueOf(argument.get(key_BackUrl)));

        if (argument.get(key_OpenType) != null){
            showParams.setOpenType(getOpenType(String.valueOf(argument.get(key_OpenType))));
        }
        if (argument.get(key_ClientType) != null){
            showParams.setClientType(getClientType(String.valueOf(argument.get(key_ClientType))));
        }
        if (argument.get("taokeParams") != null){
            taokeParams  = getTaokeParams((HashMap<String, Object>)argument.get("taokeParams"));
        }
        if ("false".equals(argument.get("isNeedCustomNativeFailMode"))){
            showParams.setNativeOpenFailedMode(AlibcFailModeType.AlibcNativeFailModeNONE);
        }else if (argument.get(key_NativeFailMode) != null){
            showParams.setNativeOpenFailedMode(getFailModeType(String.valueOf(argument.get(key_NativeFailMode))));
        }

        Map<String, String> trackParams = new HashMap<>();

        WebViewClient client = new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                return false;
            }

            @Override
            public void onLoadResource(WebView view, String url) {
                super.onLoadResource(view, url);
                //如果包含
                if (url.contains("access_token")){
                    String accessToken = getAccessToken(url);
                    if (callBack != null){
                        callBack.success(accessToken);
                        callBack = null;
                    }
                    finish();
                }
            }
        };

        AlibcTrade.openByUrl(WebViewActivity.this, "", url, webView,
                client, new WebChromeClient(),
                showParams, taokeParams, trackParams, new AlibcTradeCallback() {
                    @Override
                    public void onTradeSuccess(AlibcTradeResult tradeResult) {}//不会回调
                    @Override
                    public void onFailure(int code, String msg) {}//不会回调
                });
    }

    @Override
    protected void onDestroy() {
        if (callBack != null){
            callBack.failed("授权失败");
        }
        super.onDestroy();
    }



    public interface CallBack{
        void success(String accessToken);

        void failed(String errorMsg);
    }

}
