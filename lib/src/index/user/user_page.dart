import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/contact_modal.dart';
import 'package:yo_gift/widgets/header_background.dart';
import 'package:yo_gift/widgets/menu_row/menu_group.dart';

import 'user_controller.dart';
import 'widgets/header_info.dart';

class UserPage extends StatelessWidget implements TabBarPage {
  UserPage({Key? key}) : super(key: key);

  final controller = Get.put(UserController());

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: const Text('我的'),
      actions: [
        GetBuilder<UserController>(
          id: 'UserAppBarAction',
          init: UserController(),
          builder: (c) {
            if (c.isLogged) {
              return AppAssetImage(
                width: 24.w,
                margin: EdgeInsets.only(right: 16.w),
                img: 'icon_setting.png',
                onTap: () {
                  Get.toNamed('/pages/mine/account-setting/index');
                },
              );
            }
            return Container();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              HeaderBackground(height: 210.w),
              const UserHeaderInfo(),
            ],
          ),
          MenuGroup(
            menus: controller.menus1,
            onBack: (value) {
              controller.init();
            },
          ),
          MenuGroup(
            menus: controller.menus2,
            onBack: (value) {
              controller.init();
            },
          ),
          MenuGroup(
            menus: controller.menus3,
            onBack: (value) {
              controller.init();
            },
            onTap: (key) {
              if (key == 'contact') {
                app.showBottomModal(
                  context: context,
                  builder: (BuildContext context) {
                    return const ContactModal();
                  },
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Center(
              child: Text(
                'v${controller.currentVersion}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.26),
                ),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
