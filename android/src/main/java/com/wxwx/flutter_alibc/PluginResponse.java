package com.wxwx.flutter_alibc;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author karedem
 * @Date 2019/9/7 19:55
 * @Description 插件 响应返回实体类
**/
public class PluginResponse implements Serializable {

    private String errorCode;
    private String errorMessage;
    private Object data;

    public static PluginResponse success(Object obj){
        return new PluginResponse("0", "成功", obj);
    }

    public PluginResponse(String errorCode, String errorMessage, Object data) {
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
        this.data = data;
    }

    public Map<String, Object> toMap(){
        HashMap<String, Object> map = new HashMap<>();
        map.put("errorCode", errorCode);
        map.put("errorMessage", errorMessage);
        map.put("data", data);
        return map;
    }
}
