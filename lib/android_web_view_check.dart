library android_web_view_check;

import 'dart:io';
import 'dart:developer';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AndroidWebViewCheck {
  Future<String> deviceCheck() async {
    String val = "Available";
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      // Android 디바이스 정보 가져오기
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      const platform = MethodChannel("android_webview_version");

      try {
        final String version = await platform.invokeMethod("getWebViewVersion");

        // 정규식을 사용하여 WebView 버전만 추출
        RegExp regExp = RegExp(r'Chrome/(\d+)\.');
        Match? match = regExp.firstMatch(version);

        if (match != null) {
          String majorVersion = match.group(1) ?? "Unknown";
          // 엘지폰이고 웹뷰구현 버전이 90대 이하면 (엘지 스마트폰 사업 철수로 인한 대응)
          bool flag = int.parse(majorVersion) < 90 ? true : false;
          if (androidInfo.brand == "lge" && flag) {
            val = "Not available";
          } else if (flag) {
            val = "Update";
          }
          return val;
        }
      } on PlatformException catch (e) {
        log("Error  WebView version: '${e.message}'.");
      }
    }
    return val;
  }

  void updateWebView() async {
    const url = "https://play.google.com/store/apps/details?id=com.google.android.webview";
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
