import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'webview_controller.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final controller = Get.put(WebviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YO!GIFT'),
      ),
      body: GetBuilder<WebviewController>(
        builder: (c) {
          if (c.src.isEmpty) {
            return Container();
          }
          return WebView(
            initialUrl: c.src,
          );
        },
      ),
    );
  }
}
