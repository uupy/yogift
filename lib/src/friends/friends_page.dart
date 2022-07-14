import 'package:yo_gift/router/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'friends_controller.dart';

class FriendsPage extends StatelessWidget implements TabBarPage {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendsController>(
      init: FriendsController(),
      builder: (c) {
        return const Center(
          child: Text('friends'),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: const Text('好友'),
    );
  }
}
