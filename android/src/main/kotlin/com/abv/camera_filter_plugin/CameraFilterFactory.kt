package com.abv.camera_filter_plugin

import android.content.Context
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class CameraFilterFactory(registrar: PluginRegistry.Registrar):PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private var mPluginRegistrar : PluginRegistry.Registrar = registrar
    override fun create(context: Context,i: Int,o:Any?): PlatformView? {
        return CameraFilter(context,mPluginRegistrar,i)
    }
}