import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/clause/clause_controller.dart';

class ClausePage extends StatefulWidget {
  const ClausePage({Key? key}) : super(key: key);

  @override
  State<ClausePage> createState() => _ClausePageState();
}

class _ClausePageState extends State<ClausePage> {
  // final controller = Get.put(ClauseController());

  get textAlign => null;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClauseController>(
        init: ClauseController(),
        builder: (e) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('條款及細則'),
              ),
              body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.all(20.w),
                  child: Html(
                   data:e.content
                  )));
        });
  }
}
