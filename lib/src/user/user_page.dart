import 'package:yo_gift/router/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'user_controller.dart';

class UserPage extends StatelessWidget implements TabBarPage {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) {
        return const Center(
          child: Text('user'),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      leading: null,
      title: const Text('我的'),
    );
  }
}
