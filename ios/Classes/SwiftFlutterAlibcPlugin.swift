import Flutter
import UIKit

public class SwiftFlutterAlibcPlugin: NSObject, FlutterPlugin {
    
  var alibchandler : FlutterAlibcHandle? = nil;
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_alibc", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAlibcPlugin()
    instance.alibchandler = FlutterAlibcHandle()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
    let controller : FlutterViewController = UIApplication.shared.windows.last?.rootViewController as! FlutterViewController
    let eventChannel : FlutterEventChannel = FlutterEventChannel(name: "flutter_alibc_event", binaryMessenger: controller.binaryMessenger)
    //  eventChannel.setStreamHandler(<#T##handler: (FlutterStreamHandler & NSObjectProtocol)?##(FlutterStreamHandler & NSObjectProtocol)?#>)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // result("iOS " + UIDevice.current.systemVersion)
    if call.method == "getPlatformVersion"{
        result("iOS " + UIDevice.current.systemVersion)
    } else if call.method == "initAlibc"{
        alibchandler?.initAlibc(call: call, result: result)
    } else if call.method == "loginTaoBao" {
        alibchandler?.loginTaoBao(call: call, result: result)
    } else if call.method == "taoKeLogin" {
        alibchandler?.taoKeLogin(call: call, result: result)
    }else if call.method == "loginOut" {
        alibchandler?.loginOut(call: call, result: result)
    }
  }

  //    MARK:- 百川处理应用跳转
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String, annotation: Any) -> Bool {
        if !(AlibcTradeSDK.sharedInstance()?.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation))! {
            return true
        }
        return false
    }
    //IOS9.0 系统新的处理openURL 的API
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if #available(iOS 9.0, *) {
            var op : [String : Any] = [:];
            for (key,value) in options {
                op[key.rawValue] = value
            }
            
//          转换
            let isHandledByALBBSDK : Bool = (AlibcTradeSDK.sharedInstance()?.application(application, open: url, options: op))!;
            
//            let isHandledByALBBSDK : Bool = (AlibcTradeSDK.sharedInstance()?.application(application, open: url, options:[:]))!
            
            return isHandledByALBBSDK
        } else {
            // Fallback on earlier versions
            //处理其他app跳转到自己的app，如果百川处理过会返回YES
        }

        return false
    }
}
