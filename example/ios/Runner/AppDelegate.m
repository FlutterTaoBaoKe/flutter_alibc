#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
//    获取本身vc
//    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    //
//    UINavigationController* root = [[UINavigationController alloc]initWithRootViewController:vc];
//    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = root;
//    [self.window makeKeyAndVisible];
//    

    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


-(FlutterViewController *)getFlutterViewCtrl{
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([viewController isKindOfClass:[FlutterViewController class]]) {
        return (FlutterViewController*)viewController;
    }
    return nil;
}
@end
