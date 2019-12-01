#import "FlutterAlibcPlugin.h"
#import "FlutterAlibcHandle.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>

@interface FlutterAlibcPlugin()
//一个handle服务
@property(nonatomic,strong)FlutterAlibcHandle *handler;
//一个service服务
@property(nonatomic,strong)FlutterEventSink eventSink;
@end

@implementation FlutterAlibcPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_alibc"
                                     binaryMessenger:[registrar messenger]];
    FlutterAlibcPlugin* instance = [[FlutterAlibcPlugin alloc] initWithRegistrar:registrar methodChannel:channel];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
//    [instance setstre]
//    UIViewController *rootViewController =
//           [UIApplication sharedApplication].delegate.window.rootViewController;
    FlutterViewController *controller = (FlutterViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"flutter_alibc_event" binaryMessenger:controller];
    [eventChannel setStreamHandler:instance];
     [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(webviewChangeUrl:) name:@"webviewChangeUrl" object:nil];
}


- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar methodChannel:(FlutterMethodChannel *)flutterMethodChannel{
    self = [super init];

    if (self) {
        self.handler = [[FlutterAlibcHandle alloc]init];
    }

    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }else if ([@"initAlibc" isEqualToString:call.method]){
        [_handler initAlibc:call result:result];
    }else if([@"loginTaoBao" isEqualToString:call.method]){
        [_handler loginTaoBao:call result:result];
    }else if([@"taoKeLogin" isEqualToString:call.method]){
        [_handler taoKeLogin:call result:result];
    }else if([@"loginOut" isEqualToString:call.method]){
        [_handler loginOut];
    }else if([@"openByUrl" isEqualToString:call.method]){
        [_handler openByUrl:call result:result];
    }else if([@"openItemDetail" isEqualToString:call.method]){
        [_handler openItemDetail:call result:result];
    }else if([@"openShop" isEqualToString:call.method]){
        [_handler openShop:call result:result];
    }else if([@"openCart" isEqualToString:call.method]){
        [_handler openCart:call result:result];
    }else if([@"syncForTaoke" isEqualToString:call.method]){
        [_handler syncForTaoke:call result:result];
    }else if([@"useAlipayNative" isEqualToString:call.method]){
        [_handler useAlipayNative:call result:result];
    }else if([@"closeAlibcWebview" isEqualToString:call.method]){
//        [_handler useAlipayNative:call result:result];
        [_handler closeWebView];
    }else {
        result(FlutterMethodNotImplemented);
    }
}

//发送数据给flutter
- (void)webviewChangeUrl:(NSNotification *)notification{
    if (self.eventSink) {
        self.eventSink(notification.object);
    }
}
#pragma mark -- 下面两个为百川处理应用跳转
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 如果百川处理过会返回YES
    if (![[AlibcTradeSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
        return YES;
    }
    return NO;
}


//IOS9.0 系统新的处理openURL 的API
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    
    if (@available(iOS 9.0, *)) {
        __unused BOOL isHandledByALBBSDK=[[AlibcTradeSDK sharedInstance] application:application openURL:url options:options];
        return isHandledByALBBSDK;
    } else {
        // Fallback on earlier versions
    }//处理其他app跳转到自己的app，如果百川处理过会返回YES
    
    return NO;
    
    
}
#pragma mark -- stream通道的代理方法
- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    self.eventSink = nil;
    return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
    NSLog(@"flutter开始进行监听，并在此方法传入 原生主动传值给flutter的桥梁 event");
    self.eventSink = events;
    return nil;
}

@end
