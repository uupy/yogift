import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'user_controller.dart';
import 'widgets/header_info.dart';
import 'widgets/menu_group.dart';

class UserPage extends StatelessWidget implements TabBarPage {
  UserPage({Key? key}) : super(key: key);

  final controller = Get.put(UserController());

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      leading: null,
      title: const Text('我的'),
      actions: [
        Container(
          width: 24.w,
          margin: EdgeInsets.only(right: 16.w),
          child: Obx(() {
            if (controller.isLogged.value) {
              return AppAssetImage(
                img: 'icon_setting.png',
                onTap: () {},
              );
            }
            return Container();
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              HeaderBackground(height: 210.w),
              const UserHeaderInfo(),
            ],
          ),
          UserMenuGroup(menus: controller.menus1),
          UserMenuGroup(menus: controller.menus2),
          UserMenuGroup(menus: controller.menus3),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
