import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/user/user_controller.dart';
import 'package:yo_gift/src/user/widgets/menu_row.dart';
import 'package:yo_gift/widgets/app_card.dart';

class UserMenuGroup extends StatelessWidget {
  final List<UserMenuItem> menus;

  const UserMenuGroup({Key? key, required this.menus,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      child: Column(
        children: menus.asMap().keys.map((index) {
          final item = menus[index];
          return MenuRow(
            icon: item.icon,
            label: item.label,
            showBottomBorder: index != menus.length - 1,
            onTap: () {
              if (item.path?.isNotEmpty ?? false) {
                Get.toNamed(item.path!);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
