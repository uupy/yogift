import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yo_gift/common/logger.dart';

import 'webview_controller.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final controller = Get.put(WebviewController());

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebviewController>(
      builder: (c) {
        logger.i('WebView src: ${c.src}');
        return Scaffold(
          appBar: AppBar(
            title: const Text('YO!GIFT'),
          ),
          body: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: c.src,
            // initialUrl: 'https://www.baidu.com',
            onWebResourceError: (err) async {
              logger.e(err.toString());
              if (!await launchUrl(Uri.parse(c.src))) {
                throw 'Could not launch ${c.src}';
              }
            },
          ),
        );
      },
    );
  }
}
