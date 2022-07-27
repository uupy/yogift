import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/problem/problem_controller.dart';

class ProblemPage extends StatefulWidget {
  const ProblemPage({Key? key}) : super(key: key);

  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProblemController>(
      init: ProblemController(),
      builder: (e) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('常見問題'),
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
