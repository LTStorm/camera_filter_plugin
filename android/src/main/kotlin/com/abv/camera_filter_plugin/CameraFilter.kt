package com.abv.camera_filter_plugin

import android.content.Context
import android.view.View
import android.webkit.WebView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.platform.PlatformView

class CameraFilter(context: Context,registrar: PluginRegistry.Registrar,id:Int?):PlatformView,
        MethodChannel.MethodCallHandler {
    private var methodChannel:MethodChannel = MethodChannel(registrar.messenger(),"camera_filter_plygin_$id")
    private var context:Context = context
    init {
        methodChannel.setMethodCallHandler(this)
    }

    override fun getView(): View {
        return WebView(this.context);
    }

    override fun dispose() {
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    }

}