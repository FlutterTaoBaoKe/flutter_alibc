#import "FlutterAlibcPlugin.h"
#import "FlutterAlibcHandle.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>

@interface FlutterAlibcPlugin()
//一个handle服务
@property(nonatomic,strong)FlutterAlibcHandle *handler;
//一个service服务
@end

@implementation FlutterAlibcPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_alibc"
                                     binaryMessenger:[registrar messenger]];
    FlutterAlibcPlugin* instance = [[FlutterAlibcPlugin alloc] initWithRegistrar:registrar];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
}


- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
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
    }else {
        result(FlutterMethodNotImplemented);
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
@end
