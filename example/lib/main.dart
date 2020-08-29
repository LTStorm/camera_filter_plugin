import 'package:flutter/material.dart';
import 'package:camera_filter_plugin/camera_filter_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  CameraFilterController controller;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        child: CameraFilter(
          cameraCreated: (controller) {
            widget.controller = controller;
          },
        ),
        height: 400,
      )),
    );
  }
}
