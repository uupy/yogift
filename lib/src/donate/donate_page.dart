import 'package:yo_gift/router/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'donate_controller.dart';

class DonatePage extends StatelessWidget implements TabBarPage {
  const DonatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonateController>(
      init: DonateController(),
      builder: (c) {
        return const Center(
          child: Text('donate'),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: const Text('慈善捐贈'),
    );
  }
}
