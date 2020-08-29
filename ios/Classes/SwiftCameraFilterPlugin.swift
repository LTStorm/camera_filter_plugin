
import Flutter
import UIKit

public class SwiftCameraFilterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "camera_filter_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftCameraFilterPlugin()
    let factory = CameraFilterFactory(messenger:registrar.messenger())
    registrar.register(factory as FlutterPlatformViewFactory,withId:"camera_filter_plugin")
  }
}