

public class CameraFilterFactory: NSObject, FlutterPlatformViewFactory {
  let messenger:FlutterBinaryMessenger
  init(messenger:FlutterBinaryMessenger) {
    self.messenger=messenger
 }
 public func create(withFrame frame: CGRect,
                    viewIdentifier viewId: Int64,
                    arguments args: Any?) -> FlutterPlatformView {
  let channel = FlutterMethodChannel(name:"camera_Filter_plugin"+String(viewId),binaryMessenger:messenger)
  return CameraFilterPlatformView(channel:channel,
                             frame: frame, viewId: viewId,
                             messenger:messenger,
                             args: args)
 }
 public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
   return FlutterStandardMessageCodec.sharedInstance()
 }
}
