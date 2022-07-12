import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/src/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget implements TabBarPage {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (c) {
        return const Center(
          child: Text('home'),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? get appBar {
    final c = Get.put(HomeController());
    return AppBar(
      leading: null,
      title: const Text('Home'),
      actions: [
        IconButton(
          onPressed: () {
            Get.toNamed('setting');
          },
          icon: Icon(
            IconFont.icon_setting,
            size: 18.sp,
          ),
        ),
      ],
    );
  }
}
