#import "FlutterAlibcPlugin.h"
#if __has_include(<flutter_alibc/flutter_alibc-Swift.h>)
#import <flutter_alibc/flutter_alibc-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_alibc-Swift.h"
#endif

@implementation FlutterAlibcPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAlibcPlugin registerWithRegistrar:registrar];
}
@end
