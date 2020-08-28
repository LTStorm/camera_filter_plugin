package com.abv.camera_filter_plugin_example

import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant;

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?){
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
        com.abv.camera_filter_plugin.CameraFilterPlugin.registerWith(this.registrarFor("Camera_filter"))
    }
}
