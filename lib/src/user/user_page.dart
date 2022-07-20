import 'package:yo_gift/router/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'user_controller.dart';
import 'widgets/menu_group.dart';

class UserPage extends StatelessWidget implements TabBarPage {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  const HeaderBackground(),
                  Row(
                    children: [
                      AppImage(
                        width: 100.r,
                        height: 100.r,
                        radius: 100.r,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  AppCard(
                    child: Column(),
                  ),
                ],
              ),

              UserMenuGroup(menus: c.menus1),
              UserMenuGroup(menus: c.menus2),
              UserMenuGroup(menus: c.menus3),

              const SizedBox(height: 90),
            ],
          ),
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
