#import "CameraFilterPlugin.h"
#if __has_include(<camera_filter_plugin/camera_filter_plugin-Swift.h>)
#import <camera_filter_plugin/camera_filter_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "camera_filter_plugin-Swift.h"
#endif

@implementation CameraFilterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCameraFilterPlugin registerWithRegistrar:registrar];
}
@end
