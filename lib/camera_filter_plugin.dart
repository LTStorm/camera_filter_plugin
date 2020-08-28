// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

typedef void CameraFilterCreatedCallback(CameraFilterController controller);

class CameraFilter extends StatefulWidget {
  final CameraFilterCreatedCallback cameraCreated;
  final CameraFilterController controller;

  CameraFilter({@required this.cameraCreated,@required this.controller});
  @override
  _CameraFilterState createState() => _CameraFilterState();
}

class _CameraFilterState extends State<CameraFilter> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform ==TargetPlatform.iOS){
      return UiKitView(
        viewType: "camera_filter_plugin",
        onPlatformViewCreated: onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    else if (defaultTargetPlatform == TargetPlatform.android){
      return AndroidView(
        viewType: "camera_filter_plugin",
        onPlatformViewCreated: onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Container();
  }

  Future<void> onPlatformViewCreated(id) async{
    if(widget.cameraCreated==null){
      return;
    }
    widget.cameraCreated(widget.controller);
  }
}

class CameraFilterController{
  MethodChannel _methodChannel;

  CameraFilterController.init(int id){
    _methodChannel = new MethodChannel("camera_filter_plugin_$id");
  }
}


