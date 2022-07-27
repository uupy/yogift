import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/clause/clause_controller.dart';

class ClausePage extends StatefulWidget {
  const ClausePage({Key? key}) : super(key: key);

  @override
  State<ClausePage> createState() => _ClausePageState();
}

class _ClausePageState extends State<ClausePage> {
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
            padding: EdgeInsets.all(10.w),
            child: Html(data: e.content),
          ),
        );
      },
    );
  }
}
