package com.example.android_web_view_check

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.webkit.WebView
import io.flutter.embedding.android.FlutterFragmentActivity

class WebViewCheckPlugin : FlutterFragmentActivity() {
    private val CHANNEL = "android_webview_version"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getWebViewVersion") {
                val webViewVersion = WebView(this).settings.userAgentString
                result.success(webViewVersion)
            } else {
                result.notImplemented()
            }
        }
    }
}