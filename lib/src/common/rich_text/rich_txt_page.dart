import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'rich_txt_controller.dart';

class RichTxtPage extends StatefulWidget {
  const RichTxtPage({Key? key}) : super(key: key);

  @override
  State<RichTxtPage> createState() => _RichTxtPageState();
}

class _RichTxtPageState extends State<RichTxtPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RichTxtController>(
      init: RichTxtController(),
      builder: (c) {
        return Scaffold(
          appBar: AppBar(
            title: Obx(() => Text(c.title.value)),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.all(10.w),
            child: Html(data: c.content),
          ),
        );
      },
    );
  }
}
