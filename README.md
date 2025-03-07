# android_web_view_check
Provides version upgrade due to webview call error when using webview in Android

When updating the version, you will be taken to the page below.

![img1 daumcdn](https://github.com/user-attachments/assets/712798a7-e7c4-40ae-85cd-ae1c0d01bb5b)


MainActivity.kt add

class MainActivity : FlutterFragmentActivity() {

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